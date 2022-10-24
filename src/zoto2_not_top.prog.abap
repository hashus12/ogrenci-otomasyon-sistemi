*&---------------------------------------------------------------------*
*&  Include           ZOTO2_NOT_TOP
*&---------------------------------------------------------------------*

TABLES: zoto2_not.
TABLES: zoto2_sinif.
TABLES: zoto2_bolum.
TABLES: zoto2_ders.

DATA: ok_code LIKE sy-ucomm.
DATA: save_ok LIKE ok_code.

DATA: go_alv  TYPE REF TO cl_gui_alv_grid,
      go_cont TYPE REF TO cl_gui_custom_container.

DATA: gs_cell_color TYPE lvc_s_scol.

DATA: gs_puharf TYPE zoto_puhares_t,
      gt_puharf TYPE TABLE OF zoto_puhares_t.

CLASS cl_event_receiver DEFINITION DEFERRED.
DATA: go_event_receiver TYPE REF TO cl_event_receiver.

SELECTION-SCREEN BEGIN OF BLOCK b13 WITH FRAME TITLE text-003.
PARAMETERS: p_rad1 RADIOBUTTON GROUP rgr1 DEFAULT 'X' USER-COMMAND usrl,
            p_rad2 RADIOBUTTON GROUP rgr1.
SELECTION-SCREEN END OF BLOCK b13.

SELECTION-SCREEN BEGIN OF BLOCK b11 WITH FRAME TITLE text-001.
PARAMETERS: p_rblkd TYPE zoto2_bolum-bolum_kod  MODIF ID gr1 DEFAULT '',
            p_rsnkd TYPE zoto2_sinif-sinif_kod  MODIF ID gr1 DEFAULT ''.
SELECT-OPTIONS : s_drskd FOR zoto2_ders-ders_kod   MODIF ID gr1,
                 s_ogrno FOR zoto2_not-ogrenci_no MODIF ID gr1.
SELECTION-SCREEN END OF BLOCK b11.


SELECTION-SCREEN BEGIN OF BLOCK b12 WITH FRAME TITLE text-002.
PARAMETERS: p_vblkd TYPE zoto2_bolum-bolum_kod  MODIF ID gr2 DEFAULT '',
            p_vsnkd TYPE zoto2_sinif-sinif_kod  MODIF ID gr2 DEFAULT '',
            p_vdrkd TYPE zoto2_ders-ders_kod MODIF ID gr2 DEFAULT ''.
SELECTION-SCREEN END OF BLOCK b12.


TYPES: BEGIN OF gty_not,
         mandt             TYPE  mandt,
         ogrenci_no        TYPE  zoto2_ogrno_de,
         ogrenci_ad        TYPE  zoto2_ograd_de,
         bolum_kod         TYPE  zoto2_bolkod_de,
         bolum_ad          TYPE  zoto2_bolad_de,
         ogrenci_sinif     TYPE  zoto2_ogrsinif_de,
         sinif_kod         TYPE  zoto2_snfkod_de,
         sinif_tnm         TYPE  zoto2_snftnm_de,
         ders_kod          TYPE  zoto2_derskod_de,
         ders_tnm          TYPE  zoto2_derstnm_de,
         vize_not          TYPE  zoto2_vize_de,
         final_not         TYPE  zoto2_final_de,
         ortalama_not      TYPE  zoto2_ort_de,
         harf_not          TYPE  zoto2_harf_de,
         gecerlilik        TYPE  zoto2_gecerlilik_de,
         line_color        TYPE  char4,
         cell_color        TYPE  lvc_t_scol,
         cell_renk_kontrol TYPE int4,
       END OF gty_not.

TYPES: BEGIN OF gty_not_sonuc,
         mandt         TYPE  mandt,
         ogrenci_no    TYPE  zoto2_ogrno_de,
         ogrenci_sinif TYPE  zoto2_ogrsinif_de,
         ders_kod      TYPE  zoto2_derskod_de,
         vize_not      TYPE  zoto2_vize_de,
         final_not     TYPE  zoto2_final_de,
         ortalama_not  TYPE  zoto2_ort_de,
         harf_not      TYPE  zoto2_harf_de,
         gecerlilik    TYPE  zoto2_gecerlilik_de,
       END OF gty_not_sonuc.

DATA:
  gt_not       TYPE TABLE OF gty_not,
  gt_not_tmp   TYPE TABLE OF gty_not,
  gt_not_tmp2  TYPE TABLE OF gty_not,
  gt_hesap_tmp TYPE TABLE OF gty_not,
*      gt_not_sonuc TYPE TABLE OF zoto2_not WITH HEADER LINE INITIAL SIZE 0,
  gt_not_sonuc TYPE TABLE OF gty_not_sonuc,
  gs_hesap_tmp TYPE gty_not,
  gs_not_tmp2  TYPE gty_not,
  gs_not_tmp   TYPE gty_not,
  gs_not_sonuc TYPE gty_not_sonuc,
  gs_not       TYPE gty_not.

DATA: gt_fcat TYPE lvc_t_fcat,
      gs_fcat TYPE lvc_s_fcat.

DATA: gs_layout TYPE lvc_s_layo.

FIELD-SYMBOLS: <gfs_not> TYPE gty_not.
