*&---------------------------------------------------------------------*
*& Report  ZOTO2_BOLUM
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zoto2_bolum.


INCLUDE zoto2_bolum_top.
INCLUDE zoto2_bolum_pbo.
INCLUDE zoto2_bolum_pai.
INCLUDE zoto2_bolum_frm.


START-OF-SELECTION.

  PERFORM set_fcat.
  PERFORM set_layout.

  CALL SCREEN 0100.
