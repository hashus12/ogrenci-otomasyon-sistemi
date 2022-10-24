*&---------------------------------------------------------------------*
*&  Include           ZOTO2_BOLUM_PBO
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  TYPES:BEGIN OF ty_s_exclude,
          ucomm TYPE sy-ucomm,
        END OF ty_s_exclude.

  DATA: lt_exclude TYPE TABLE OF sy-ucomm.
  DATA: ls_exclude TYPE sy-ucomm.


  SET TITLEBAR '0100'.


  IF gs_bolum-bolum_kod IS INITIAL.
    LOOP AT SCREEN.
      CASE screen-name.
        WHEN 'GS_BOLUM-BOLUM_AD'.
          screen-input = 0.
          MODIFY SCREEN.
      ENDCASE.
    ENDLOOP.
  ENDIF.

  IF save_ok = '&KAY'.
    APPEND '&KAY' TO lt_exclude.
    IF gs_bolum-bolum_kod IS NOT INITIAL.
      LOOP AT SCREEN.
        CASE screen-group1.
          WHEN abap_true.
            screen-input = 0.
            MODIFY SCREEN.
        ENDCASE.
      ENDLOOP.
    ENDIF.

    CLEAR gs_bolum.
  ELSEIF save_ok = '&YGR'.
    CLEAR gs_bolum.
    LOOP AT SCREEN.
      CASE screen-name.
        WHEN 'GS_BOLUM-BOLUM_AD'.
          screen-input = 0.
          MODIFY SCREEN.
        WHEN 'GS_BOLUM-BOLUM_KOD'.
          screen-input = 1.
          MODIFY SCREEN.
      ENDCASE.
    ENDLOOP.

  ENDIF.
  CLEAR ok_code.

  SET PF-STATUS '0100' EXCLUDING lt_exclude.
  PERFORM get_data.
  PERFORM display_alv.

ENDMODULE.
