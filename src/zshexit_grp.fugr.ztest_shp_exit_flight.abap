FUNCTION ztest_shp_exit_flight.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  TABLES
*"      SHLP_TAB TYPE  SHLP_DESCT
*"      RECORD_TAB STRUCTURE  SEAHLPRES
*"  CHANGING
*"     VALUE(SHLP) TYPE  SHLP_DESCR
*"     VALUE(CALLCONTROL) TYPE  DDSHF4CTRL
*"----------------------------------------------------------------------

  CASE callcontrol-step.
    WHEN 'SELONE'.
    WHEN 'PRESEL1'.
    WHEN 'SELECT'.
    WHEN 'DISP'.
    SORT record_tab.

    DELETE ADJACENT DUPLICATES FROM record_tab.
*      LOOP AT record_tab.
*        IF record_tab-string+10(2) <> 'US'.
*          DELETE record_tab INDEX sy-tabix.
*        ENDIF.
*      ENDLOOP.
    WHEN 'RETURN'.
  ENDCASE.
ENDFUNCTION.
