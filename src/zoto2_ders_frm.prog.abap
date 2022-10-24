*&---------------------------------------------------------------------*
*&  Include           ZOTO2_DERS_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data .
  CLEAR gt_ders.
  IF gs_ders-bolum_kod IS NOT INITIAL AND  gs_ders-sinif_kod IS INITIAL.
    SELECT *
      FROM zoto2_ders
      INTO CORRESPONDING FIELDS OF TABLE gt_ders
     WHERE bolum_kod = gs_ders-bolum_kod.
    IF sy-subrc NE 0.
      MESSAGE 'Geçersiz Bölüm Kodu!' TYPE 'W' DISPLAY LIKE 'E'.
      CLEAR gs_ders.
    ENDIF.

  ELSEIF  gs_ders-bolum_kod IS NOT INITIAL  AND gs_ders-sinif_kod IS NOT INITIAL.
    SELECT *
      FROM zoto2_ders
      INTO CORRESPONDING FIELDS OF TABLE gt_ders
     WHERE bolum_kod = gs_ders-bolum_kod
       AND sinif_kod = gs_ders-sinif_kod.
    IF sy-subrc NE 0.
      MESSAGE 'Geçersiz Sınıf veya Bölüm Kodu!' TYPE 'W' DISPLAY LIKE 'E'.
      CLEAR gs_ders.
    ENDIF.

  ELSEIF gs_ders-sinif_kod IS NOT INITIAL AND gs_ders-bolum_kod IS INITIAL.
    MESSAGE 'Bölüm Kodu boş olamaz!' TYPE 'W' DISPLAY LIKE 'E'.
    CLEAR gs_ders.
  ENDIF.
ENDFORM.
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


    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
        is_layout                     = gs_layout
      CHANGING
        it_outtab                     = gt_ders
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

  ELSE.
    CALL METHOD go_alv->refresh_table_display.
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
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZOTO2_DERS_S'
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
*&      Form  SAVE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM save .
  IF gs_ders-bolum_kod IS NOT INITIAL AND
     gs_ders-ders_kod IS NOT INITIAL AND
     gs_ders-ders_tnm IS NOT INITIAL.
    MODIFY zoto2_ders FROM gs_ders.
  ELSE.
    MESSAGE 'Lütfen boş alanları doldurunuz!' TYPE 'E'.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CHECK_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM check_data .
  SELECT SINGLE *
    FROM zoto2_ders
    INTO CORRESPONDING FIELDS OF  gs_ders
   WHERE bolum_kod = gs_ders-bolum_kod
     AND sinif_kod = gs_ders-sinif_kod
     AND ders_kod = gs_ders-ders_kod.
ENDFORM.
