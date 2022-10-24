*&---------------------------------------------------------------------*
*& Report  ZOTO2_OGRENCI
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zoto2_ogrenci.
TABLES zoto2_ogrenci_s.

INCLUDE zoto2_ogrenci_top.
INCLUDE zoto2_ogrenci_pbo.
INCLUDE zoto2_ogrenci_pai.
INCLUDE zoto2_ogrenci_frm.

START-OF-SELECTION.


  PERFORM set_fcat.
  PERFORM set_layout.

  CALL SCREEN 0100.
  CALL SCREEN 0200.
