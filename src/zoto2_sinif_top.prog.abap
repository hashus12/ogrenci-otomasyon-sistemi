*&---------------------------------------------------------------------*
*&  Include           ZOTO2_SINIF_TOP
*&---------------------------------------------------------------------*

DATA: ok_code LIKE sy-ucomm.
DATA: save_ok LIKE ok_code.

DATA: go_alv  TYPE REF TO cl_gui_alv_grid,
      go_cont TYPE REF TO cl_gui_custom_container.

TYPES: BEGIN OF gty_sinif,
         mandt     TYPE mandt,
         bolum_kod TYPE zoto2_bolkod_de,
         sinif_kod TYPE zoto2_snfkod_de,
         sinif_tnm TYPE zoto2_snftnm_de,
       END OF gty_sinif.

DATA: gt_sinif TYPE TABLE OF gty_sinif,
      gs_sinif TYPE gty_sinif.

DATA: gt_fcat TYPE lvc_t_fcat,
      gs_fcat TYPE lvc_s_fcat.

DATA: gs_layout TYPE lvc_s_layo.
