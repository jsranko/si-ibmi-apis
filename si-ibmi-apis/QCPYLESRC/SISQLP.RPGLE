**FREE
/if not defined(SISQLP)
 /define SISQLP
/else
 /eof
/endif

//==========================================================================================
// Constant
//==========================================================================================

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSISQL_Diagnostics_Message_Text varchar(32740) template;

/if defined(SISQL)
  /eof
/endif

//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr SISQL_isWarning ind extproc(*dclcase);
  SQLCommArea likeds(SQLCA);
end-pr;

dcl-pr SISQL_noData ind extproc(*dclcase);
  SQLCommArea likeds(SQLCA);
end-pr;

dcl-pr SISQL_isError ind extproc(*dclcase);
  SQLCommArea likeds(SQLCA);
end-pr;

dcl-pr SISQL_getLastDiagnosticsMessageText like(tSISQL_Diagnostics_Message_Text) extproc(*dclcase);
  SQLCommArea likeds(SQLCA);
end-pr;
