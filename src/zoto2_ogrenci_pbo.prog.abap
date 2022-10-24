*&---------------------------------------------------------------------*
*&  Include           ZOTO2_OGRENCI_PBO
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '0100'.
  SET TITLEBAR '0100'.

  IF gs_ogrenci-ogrenci_tc IS INITIAL.
    LOOP AT SCREEN.
      CASE screen-group2.
        WHEN abap_true.
          screen-input = 0.
          MODIFY SCREEN.
      ENDCASE.
    ENDLOOP.
    CLEAR gs_ogrenci.
  ENDIF.

  PERFORM check_data.

  IF save_ok = '&KAY'.
    IF gs_ogrenci-ogrenci_tc IS NOT INITIAL.
      LOOP AT SCREEN.
        CASE screen-group1.
          WHEN abap_true.
            screen-input = 0.
            MODIFY SCREEN.
        ENDCASE.
      ENDLOOP.
    ENDIF.
    CLEAR gs_ogrenci.
  ELSEIF save_ok = '&YGR'.
    LOOP AT SCREEN.
      CASE screen-group2.
        WHEN abap_true.
          screen-input = 0.
          MODIFY SCREEN.
      ENDCASE.
    ENDLOOP.
    CLEAR gs_ogrenci.
  ENDIF.
  CLEAR ok_code.

  PERFORM get_data.
  PERFORM display_alv.

ENDMODULE.
