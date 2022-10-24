*&---------------------------------------------------------------------*
*&  Include           ZOTO2_OGRENCI_TOP
*&---------------------------------------------------------------------*

DATA: ok_code LIKE sy-ucomm.
DATA: save_ok LIKE ok_code.

DATA: go_alv  TYPE REF TO cl_gui_alv_grid,
      go_cont TYPE REF TO cl_gui_custom_container.

TYPES: BEGIN OF gty_ogrenci,
         mandt         TYPE mandt,
         ogrenci_tc    TYPE zoto2_ogrtc_de,
         ogrenci_no    TYPE zoto2_ogrno_de,
         ogrenci_ad    TYPE zoto2_ograd_de,
         ogrenci_email TYPE zoto2_ogremail_de,
         ogrenci_tel   TYPE zoto2_ogrtel_de,
         ogrenci_cin   TYPE zoto2_ogrtcin_de,
         ogrenci_bolum TYPE zoto2_ogrbolum_de,
         ogrenci_sinif TYPE zoto2_ogrsinif_de,
       END OF gty_ogrenci.

DATA: gt_ogrenci TYPE TABLE OF gty_ogrenci,
      gs_ogrenci TYPE gty_ogrenci.

DATA: gt_fcat TYPE lvc_t_fcat,
      gs_fcat TYPE lvc_s_fcat.

DATA: gs_layout TYPE lvc_s_layo.
