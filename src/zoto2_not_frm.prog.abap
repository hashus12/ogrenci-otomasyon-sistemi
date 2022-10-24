*&---------------------------------------------------------------------*
*&  Include           ZOTO2_NOT_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  DISPLAY_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM display_alv .
  IF  go_cont IS INITIAL.
    CREATE OBJECT go_cont
      EXPORTING
        container_name              = 'CC_ALV'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    CREATE OBJECT go_alv
      EXPORTING
        i_parent          = go_cont
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    CREATE OBJECT go_event_receiver.
    SET HANDLER go_event_receiver->handle_data_changed FOR go_alv.
    SET HANDLER go_event_receiver->handle_toolbar FOR go_alv.
    SET HANDLER go_event_receiver->handle_user_command FOR go_alv.

    CALL METHOD go_alv->set_table_for_first_display
*      EXPORTING
*        is_layout                     = gs_layout
      CHANGING
        it_outtab                     = gt_not
        it_fieldcatalog               = gt_fcat
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    CALL METHOD go_alv->register_edit_event
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_modified
      EXCEPTIONS
        error      = 1
        OTHERS     = 2.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.

    ENDIF.

  ENDIF.

  CALL METHOD go_alv->set_frontend_layout( is_layout = gs_layout ).
  CALL METHOD go_alv->refresh_table_display.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SET_FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_fcat .
  gs_fcat-fieldname = 'VIZE_NOT'.
  gs_fcat-edit      = abap_true.
  APPEND gs_fcat TO gt_fcat.

  gs_fcat-fieldname = 'FINAL_NOT'.
  gs_fcat-edit      = abap_true.
  APPEND gs_fcat TO gt_fcat.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZOTO2_NOT_S'
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = gt_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SET_LAYOUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_layout .
  CLEAR: gs_layout.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-zebra = abap_true.
  gs_layout-info_fname = 'LINE_COLOR'.
  gs_layout-ctab_fname = 'CELL_COLOR'.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data .
*  CLEAR gt_not.
*  IF gt_not IS INITIAL.
  SELECT *
  FROM zoto2_bolum   AS b
  JOIN zoto2_sinif   AS s
  ON b~bolum_kod EQ s~bolum_kod
  JOIN zoto2_ders    AS d
  ON d~bolum_kod EQ s~bolum_kod
  AND d~sinif_kod EQ s~sinif_kod
  JOIN zoto2_not     AS n
  ON n~ders_kod EQ d~ders_kod
  JOIN zoto2_ogrenci AS o
  ON o~ogrenci_no EQ n~ogrenci_no
  INTO CORRESPONDING FIELDS OF TABLE gt_not_tmp.


  IF p_rad1 IS NOT INITIAL.
    LOOP AT gt_not_tmp INTO gs_not
    WHERE bolum_kod = p_rblkd
    AND sinif_kod = p_rsnkd
    AND ders_kod IN s_drskd
*    AND ders_kod >= s_drskd-low
*    AND ders_kod <= s_drskd-high
    AND ogrenci_no IN s_ogrno.
*    AND ogrenci_no >= s_ogrno-low
*    AND ogrenci_no <= s_ogrno-high.
      APPEND gs_not TO gt_not.
    ENDLOOP.
  ELSE.
    IF gt_not IS INITIAL.
      LOOP AT gt_not_tmp INTO gs_not
      WHERE bolum_kod = p_vblkd
      AND sinif_kod = p_vsnkd
      AND ders_kod = p_vdrkd.
        APPEND gs_not TO gt_not.
      ENDLOOP.
      gt_not_tmp = gt_not.
    ENDIF.
  ENDIF.

*  LOOP AT gt_not ASSIGNING <gfs_not>.
*    gs_cell_color-fname = 'VIZE_NOT'.
*    gs_cell_color-color-col = '3'.
*    gs_cell_color-color-int = '1'.
*    gs_cell_color-color-inv = '0'.
*    APPEND gs_cell_color TO <gfs_not>-cell_color.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SAVE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM save .
  IF  gt_not IS NOT INITIAL.
    MOVE-CORRESPONDING gt_not TO gt_not_sonuc.
    MODIFY zoto2_not FROM TABLE gt_not_sonuc.
    IF sy-subrc EQ 0.
      MESSAGE 'Kaydedildi.' TYPE 'S'.
    ENDIF.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  HESAP
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM hesap .
  LOOP AT gt_not INTO gs_not.
    "ortalama not
    gs_not-ortalama_not = gs_not-vize_not * ( 3 / 10 ) + gs_not-final_not * ( 7 / 10 ).
    "harf notu
    SELECT SINGLE *
    FROM zoto_puhares_t
    INTO gs_puharf
    WHERE alt_deg <= gs_not-ortalama_not
    AND ust_deg >= gs_not-ortalama_not.
    gs_not-harf_not = gs_puharf-harf_kod.

    "Geçerlilik
    DATA: lv_toplam    TYPE numc3,
          lv_sayac     TYPE numc3,
          lv_sinif_ort TYPE numc3.

    LOOP AT gt_not_tmp INTO gs_not_tmp.
      lv_toplam = gs_not_tmp-ortalama_not + lv_toplam.
      lv_sayac  = lv_sayac + 1.
    ENDLOOP.

    lv_toplam = lv_toplam + gs_not-ortalama_not.
    lv_sayac = lv_sayac + 1.

    lv_sinif_ort = lv_toplam / lv_sayac.

    IF gs_not-ortalama_not >= lv_sinif_ort AND gs_not-harf_not NE 'FF'.
      gs_not-gecerlilik = 'geçti'.
      IF gs_not-cell_renk_kontrol IS NOT INITIAL.
        CLEAR gs_cell_color.
        CLEAR gs_not-cell_color.
        gs_cell_color-fname = 'HARF_NOT'.
        gs_cell_color-color-col = '5'.
        gs_cell_color-color-int = '1'.
        gs_cell_color-color-inv = '0'.
        APPEND gs_cell_color TO gs_not-cell_color.
        gs_cell_color-fname = 'GECERLILIK'.
        gs_cell_color-color-col = '5'.
        gs_cell_color-color-int = '1'.
        gs_cell_color-color-inv = '0'.
        APPEND gs_cell_color TO gs_not-cell_color.
        gs_cell_color-fname = 'ORTALAMA_NOT'.
        gs_cell_color-color-col = '5'.
        gs_cell_color-color-int = '1'.
        gs_cell_color-color-inv = '0'.
        APPEND gs_cell_color TO gs_not-cell_color.
      ENDIF.

    ELSE.
      gs_not-gecerlilik = 'kaldı'.
      IF gs_not-cell_renk_kontrol IS NOT INITIAL.
        CLEAR gs_cell_color.
        CLEAR gs_not-cell_color.
        gs_cell_color-fname = 'HARF_NOT'.
        gs_cell_color-color-col = '6'.
        gs_cell_color-color-int = '1'.
        gs_cell_color-color-inv = '0'.
        APPEND gs_cell_color TO gs_not-cell_color.
        gs_cell_color-fname = 'GECERLILIK'.
        gs_cell_color-color-col = '6'.
        gs_cell_color-color-int = '1'.
        gs_cell_color-color-inv = '0'.
        APPEND gs_cell_color TO gs_not-cell_color.
        gs_cell_color-fname = 'ORTALAMA_NOT'.
        gs_cell_color-color-col = '6'.
        gs_cell_color-color-int = '1'.
        gs_cell_color-color-inv = '0'.
        APPEND gs_cell_color TO gs_not-cell_color.
      ENDIF.
    ENDIF.
    MODIFY gt_not FROM gs_not.
  ENDLOOP.
*  CLEAR gt_not.
*  gt_not = gt_not_tmp.
ENDFORM.
