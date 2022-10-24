*&---------------------------------------------------------------------*
*&  Include           ZOTO2_OGRENCI_PAI
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  save_ok = ok_code.
  CASE save_ok.
    WHEN '&BACK'.
      LEAVE TO SCREEN 0.
    WHEN '&KAY'.
      PERFORM save.
  ENDCASE.
ENDMODULE.
