*&---------------------------------------------------------------------*
*&  Include           ZOTO2_DERS_PBO
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '0100'.
  SET TITLEBAR '0100'.

  IF gs_ders-bolum_kod IS INITIAL AND gs_ders-sinif_kod IS INITIAL.
    LOOP AT SCREEN.
      IF screen-group1 EQ abap_true.
        screen-input = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ELSEIF gs_ders-bolum_kod IS NOT INITIAL AND gs_ders-sinif_kod IS INITIAL.
    LOOP AT SCREEN.
      IF screen-group2 EQ abap_true.
        screen-input = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ELSEIF gs_ders-bolum_kod IS NOT INITIAL AND  gs_ders-sinif_kod IS NOT INITIAL.
    LOOP AT SCREEN.
      IF screen-group2 EQ abap_true.
        screen-input = 1.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDIF.

  PERFORM check_data.

  IF save_ok = '&KAY'.
    IF gs_ders-bolum_kod IS NOT INITIAL.
      LOOP AT SCREEN.
        CASE screen-group1.
          WHEN abap_true.
            screen-input = 0.
            MODIFY SCREEN.
        ENDCASE.
      ENDLOOP.
    ENDIF.
  ELSEIF save_ok = '&YGR'.
    CLEAR gs_ders.
    LOOP AT SCREEN.
      IF screen-group1 EQ abap_true.
        screen-input = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDIF.
  CLEAR ok_code.

  PERFORM get_data.
  PERFORM display_alv.
ENDMODULE.
