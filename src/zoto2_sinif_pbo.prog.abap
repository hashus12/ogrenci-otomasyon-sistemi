*&---------------------------------------------------------------------*
*&  Include           ZOTO2_SINIF_PBO
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '0100'.
  SET TITLEBAR '0100'.

  IF gs_sinif-bolum_kod IS INITIAL.
    LOOP AT SCREEN.
      CASE screen-name.
        WHEN 'GS_SINIF-SINIF_KOD'.
          screen-input = 0.
          MODIFY SCREEN.
        WHEN 'GS_SINIF-SINIF_TNM'.
          screen-input = 0.
          MODIFY SCREEN.
      ENDCASE.
    ENDLOOP.
    CLEAR gs_sinif.
  ENDIF.

  PERFORM check_data.

  IF save_ok = '&KAY'.
    IF gs_sinif-bolum_kod IS NOT INITIAL.
      LOOP AT SCREEN.
        CASE screen-group1.
          WHEN abap_true.
            screen-input = 0.
            MODIFY SCREEN.
        ENDCASE.
      ENDLOOP.
    ENDIF.
    CLEAR gs_sinif.
  ELSEIF save_ok = '&YGR'.
    CLEAR gs_sinif.
    LOOP AT SCREEN.
      CASE screen-name.
        WHEN 'GS_SINIF-SINIF_KOD'.
          screen-input = 0.
          MODIFY SCREEN.
        WHEN 'GS_SINIF-SINIF_TNM'.
          screen-input = 0.
          MODIFY SCREEN.
        WHEN 'GS_SINIF-BOLUM_KOD'.
          screen-input = 1.
          MODIFY SCREEN.
      ENDCASE.
    ENDLOOP.
    SET PF-STATUS '0100'.
  ENDIF.
  CLEAR ok_code.

  PERFORM get_data.
  PERFORM display_alv.

ENDMODULE.
