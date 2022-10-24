*&---------------------------------------------------------------------*
*&  Include           ZOTO2_NOT_CLS
*&---------------------------------------------------------------------*

CLASS cl_event_receiver DEFINITION.
  PUBLIC SECTION.
    METHODS handle_data_changed
        FOR EVENT data_changed OF cl_gui_alv_grid
      IMPORTING
        er_data_changed
        e_onf4
        e_onf4_before
        e_onf4_after
        e_ucomm.

  METHODS handle_toolbar                   "TOOLBAR
  FOR EVENT toolbar OF cl_gui_alv_grid
  IMPORTING
    e_object
    e_interactive.

  METHODS handle_user_command              "USER_COMMAND
  FOR EVENT user_command OF cl_gui_alv_grid
  IMPORTING
    e_ucomm.
ENDCLASS.

CLASS cl_event_receiver IMPLEMENTATION.
  METHOD handle_data_changed.
    DATA: ls_modi TYPE lvc_s_modi.
    LOOP AT er_data_changed->mt_good_cells INTO ls_modi.
      READ TABLE gt_not INTO gs_not INDEX ls_modi-row_id.
      IF sy-subrc EQ 0.
        CASE ls_modi-fieldname.
          WHEN 'VIZE_NOT'.
*            CLEAR gs_not.
            gs_not-cell_renk_kontrol = ls_modi-row_id.
            gs_cell_color-fname = 'VIZE_NOT'.
            gs_cell_color-color-col = '3'.
            gs_cell_color-color-int = '1'.
            gs_cell_color-color-inv = '0'.
            APPEND gs_cell_color TO gs_not-cell_color.
            MODIFY gt_not FROM gs_not INDEX ls_modi-row_id TRANSPORTING cell_renk_kontrol cell_color.
          WHEN 'FINAL_NOT'.
*            CLEAR gs_not.
            gs_not-cell_renk_kontrol = ls_modi-row_id.

            gs_cell_color-fname = 'FINAL_NOT'.
            gs_cell_color-color-col = '3'.
            gs_cell_color-color-int = '1'.
            gs_cell_color-color-inv = '0'.
            APPEND gs_cell_color TO gs_not-cell_color.
            MODIFY gt_not FROM gs_not INDEX ls_modi-row_id TRANSPORTING cell_renk_kontrol cell_color.
          WHEN OTHERS.
        ENDCASE.
      ENDIF.
    ENDLOOP.
    CALL METHOD go_alv->refresh_table_display.
  ENDMETHOD.

  METHOD handle_toolbar.
    DATA: ls_toolbar TYPE stb_button.

    CLEAR: ls_toolbar.
    ls_toolbar-FUNCTION = '&KAY'.
    ls_toolbar-TEXT = 'Kaydet'.
    ls_toolbar-ICON = '@2L@'.
    ls_toolbar-quickinfo = 'Kayıt işlemi'.
    ls_toolbar-disabled = abap_false.
    APPEND ls_toolbar TO e_object->mt_toolbar.
  ENDMETHOD.        "handle_toolbar

  METHOD handle_user_command.
    CASE e_ucomm.
    WHEN '&KAY'.
      PERFORM save.
    ENDCASE.
  ENDMETHOD.        "handle_user_command
ENDCLASS.
