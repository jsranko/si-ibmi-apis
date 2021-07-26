**FREE

//******************************************************************************************
//
//
// Programname    : SISQL
// Programautor   : Sranko Informatik
// Created on     : 06.03.2019
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See QCLLESRC,makesiiia
//
//==========================================================================================

ctl-opt NoMain;

//==========================================================================================
// Constants
//==========================================================================================

//==========================================================================================
// Templates
//==========================================================================================

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

/define SISQL
/include qcpylesrc/sisqlp

//==========================================================================================
// Procedures
//==========================================================================================

//------------------------------------------------------------------------------------------

dcl-proc SISQL_isWarning export;
dcl-pi SISQL_isWarning ind extproc(*dclcase);
  SQLCommArea likeds(SQLCA);
end-pi;

  if SQLCommArea.sqlcode > 0
  and SQLCommArea.sqlcode <> 100;
    return *on;
  else;
    return *off;
  endif;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISQL_noData export;
dcl-pi SISQL_noData ind extproc(*dclcase);
  SQLCommArea likeds(SQLCA);
end-pi;
   if SQLCommArea.sqlcode = 100;
     return *on;
   else;
     return *off;
   endif;
 end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISQL_isError export;
dcl-pi SISQL_isError ind extproc(*dclcase);
  SQLCommArea likeds(SQLCA);
end-pi;

  if SQLCommArea.sqlcode < *zeros;
    return *on;
  else;
    return *off;
  endif;

end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISQL_getLastDiagnosticsMessageText export;
dcl-pi SISQL_getLastDiagnosticsMessageText like(tSISQL_Diagnostics_Message_Text) extproc(*dclcase);
  SQLCommArea likeds(SQLCA);
end-pi;
dcl-s Message_Text like(tSISQL_Diagnostics_Message_Text);

  exec sql get diagnostics condition 1 :Message_Text = MESSAGE_TEXT;

  return Message_Text;
end-proc;
