*&---------------------------------------------------------------------*
*&  Include           ZOTO2_DERS_TOP
*&---------------------------------------------------------------------*

DATA: ok_code LIKE sy-ucomm.
DATA: save_ok LIKE ok_code.

DATA: go_alv  TYPE REF TO cl_gui_alv_grid,
      go_cont TYPE REF TO cl_gui_custom_container.

TYPES: BEGIN OF gty_ders,
         mandt      TYPE mandt,
         bolum_kod  TYPE zoto2_bolkod_de,
         sinif_kod  TYPE zoto2_snfkod_de,
         ders_kod   TYPE zoto2_derskod_de,
         ders_tnm   TYPE zoto2_derstnm_de,
         kredi_puan TYPE zoto2_kredipuan_de,
       END OF gty_ders.

DATA: gt_ders TYPE TABLE OF gty_ders,
      gs_ders TYPE gty_ders.

DATA: gt_fcat TYPE lvc_t_fcat,
      gs_fcat TYPE lvc_s_fcat.

DATA: gs_layout TYPE lvc_s_layo.
