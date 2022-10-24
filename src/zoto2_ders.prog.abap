*&---------------------------------------------------------------------*
*& Report  ZOTO2_DERS
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT ZOTO2_DERS.

include zoto2_ders_top.
include zoto2_ders_pbo.
include zoto2_ders_pai.
include zoto2_ders_frm.


START-OF-SELECTION.

PERFORM set_fcat.
PERFORM set_layout.

call screen 0100.
