*&---------------------------------------------------------------------*
*&  Include           ZOTO2_BOLUM_TOP
*&---------------------------------------------------------------------*

DATA: ok_code LIKE sy-ucomm.
DATA: save_ok LIKE ok_code.

DATA: go_alv  TYPE REF TO cl_gui_alv_grid,
      go_cont TYPE REF TO cl_gui_custom_container.

TYPES: BEGIN OF gty_bolum,
         mandt     TYPE mandt,
         bolum_kod TYPE zoto2_bolkod_de,
         bolum_ad  TYPE zoto2_bolad_de,
       END OF gty_bolum.

DATA: gt_bolum TYPE TABLE OF gty_bolum,
      gs_bolum TYPE gty_bolum.

DATA: gt_fcat TYPE lvc_t_fcat,
      gs_fcat TYPE lvc_s_fcat.

DATA: gs_layout TYPE lvc_s_layo.

DATA: gt_filter TYPE lvc_t_filt,
      gs_filter TYPE lvc_s_filt.
