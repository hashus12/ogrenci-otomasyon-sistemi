*&---------------------------------------------------------------------*
*& Report  ZOTO2_SINIF
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zoto2_sinif.
INCLUDE zoto2_sinif_top.
INCLUDE zoto2_sinif_pbo.
INCLUDE zoto2_sinif_pai.
INCLUDE zoto2_sinif_frm.


START-OF-SELECTION.


  PERFORM set_fcat.
  PERFORM set_layout.

  CALL SCREEN 0100.
