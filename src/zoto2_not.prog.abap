*&---------------------------------------------------------------------*
*& Report  ZOTO2_NOT
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zoto2_not.

INCLUDE zoto2_not_top.
INCLUDE zoto2_not_cls.
INCLUDE zoto2_not_pbo.
INCLUDE zoto2_not_pai.
INCLUDE zoto2_not_frm.


AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.
    IF p_rad1 EQ abap_true.
      IF screen-group1 EQ 'GR1'.
        screen-active = 1.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR2'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
    IF p_rad2 EQ abap_true.
      IF screen-group1 EQ 'GR1'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR2'.
        screen-active = 1.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
  ENDLOOP.


START-OF-SELECTION.

  PERFORM set_fcat.
  PERFORM set_layout.


  CALL SCREEN 0100.
