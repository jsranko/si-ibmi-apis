**FREE

/if not defined(SISCLIP)
  /define SISCLIP
/else
  /eof
/endif



//==========================================================================================
// Constants
//==========================================================================================

dcl-c cSISCLI_LOCAL const('*LOCAL');
dcl-c cSISCLI_TRUE const(1);
dcl-c cSISCLI_FALSE const(0);
dcl-c cSISCLI_NO_COMMIT const(1);
dcl-c cSISCLI_MAXCOLS const(500);


//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSISCLI like(tSISCLI_Def) template;
dcl-s tSISCLI_Environment int(10) template;
dcl-s tSISCLI_ConnectionHandle int(10) template;
dcl-s tSISCLI_ConnectionAttr int(10) template;
dcl-s tSISCLI_Return int(10) template;
dcl-s tSISCLI_Database varchar(50) template;
dcl-s tSISCLI_Option int(10) template;
dcl-s tSISCLI_StatementText varchar(1024) template;
dcl-s tSISCLI_StatementHandle int(10) template;
dcl-s tSISCLI_Statement like(tSISCLI_Statement_Def) template;
dcl-s tSISCLI_SqlState char(6) template;
dcl-s tSISCLI_SqlCode int(10) template;
dcl-s tSISCLI_MessageText char(512) template;
dcl-s tSISCLI_DBConfig like(tSISCLI_DBConfig_Def) template;
dcl-s tSISCLI_SysNaming int(10) template;
dcl-s tSISCLI_CommitCtl int(10) template;
dcl-s tSISCLI_Name varchar(40) template;
dcl-s tSISCLI_NumResultCols int(5) template;
dcl-s tSISCLI_DataType int(10) template;

dcl-ds tSISCLI_FieldAttrs qualified template;
  offset int(10);
  size int(10);
  dataType like(tSISCLI_DataType);
  dataTypeC like(tSISCLI_DataType);
end-ds;

dcl-ds tSISCLI_DBConfig_Def qualified template;
  name like(tSISCLI_Name) inz('*INIT');
  sysNaming like(tSISCLI_SysNaming) inz(cSISCLI_TRUE);
  commitCtl like(tSISCLI_commitCtl) inz(cSISCLI_NO_COMMIT);
end-ds;

dcl-ds tSISCLI_Error qualified template;
  sqlState like(tSISCLI_SqlState);
  sqlCode like(tSISCLI_SqlCode);
  MessageText like(tSISCLI_MessageText);
end-ds;

dcl-ds tSISCLI_Def qualified template;
  env like(tSISCLI_Environment) inz;
  hdbc like(tSISCLI_ConnectionHandle) inz;
  retCode like(tSISCLI_Return) inz;
  db like(tSISCLI_Database) inz;
  error likeds(tSISCLI_Error) inz;
  config likeds(tSISCLI_DBConfig_Def) inz(*likeds);
end-ds;

dcl-ds tSISCLI_Statement_Def qualified template;
  hstmt like(tSISCLI_StatementHandle);
  hstmtEmergency like(tSISCLI_StatementHandle);
  text like(tSISCLI_StatementText);
  retCode like(tSISCLI_Return);
  error likeds(tSISCLI_Error);
  eof ind;
  numResultCols like(tSISCLI_NumResultCols);
  fields likeds(tSISCLI_FieldAttrs) dim(cSISCLI_MAXCOLS);
end-ds;

//==========================================================================================
// Prototypes
//==========================================================================================

/if defined(SISCLI)
  /eof
/endif

dcl-pr SISCLI_crtConfig like(tSISCLI_DBConfig) extproc(*dclcase);
 Name like(tSISCLI_Name) value options(*nopass);
end-pr;

dcl-pr SISCLI_connect like(tSISCLI) extproc(*dclcase);
  Database like(tSISCLI_Database) const options(*omit:*nopass);
  SISCLI_DBConfig like(tSISCLI_DBConfig) options(*nopass);
end-pr;

dcl-pr SISCLI_disconnect ind extproc(*dclcase);
 SISCLI like(tSISCLI);
end-pr;

dcl-pr SISCLI_setCommit ind extproc(*dclcase);
  SISCLI_DBConfig like(tSISCLI_DBConfig);
  CommitCtl like(tSISCLI_CommitCtl) value;
end-pr;

dcl-pr SISCLI_crtStatement like(tSISCLI_Statement) extproc(*dclcase);
  SISCLI like(tSISCLI);
  StatementText like(tSISCLI_StatementText) value;
  ForUpdate ind value options(*nopass);
end-pr;

dcl-pr SISCLI_execute ind extproc(*dclcase);
  Statement like(tSISCLI_Statement);
end-pr;

dcl-pr SISCLI_closeStatement ind extproc(*dclcase);
  Statement like(tSISCLI_Statement);
end-pr;

dcl-pr SISCLI_setSysNaming extproc(*dclcase);
  SISCLI_DBConfig like(tSISCLI_DBConfig);
  Attr ind value;
end-pr;

dcl-pr SISCLI_fetch ind extproc(*dclcase);
  Statement like(tSISCLI_Statement);
  PointerToData pointer value;
end-pr;

dcl-pr SISCLI_isEOF ind extproc(*dclcase);
  Statement like(tSISCLI_Statement);
end-pr;

dcl-pr SISCLI_getNumResultCols like(tSISCLI_NumResultCols) extproc(*dclcase);
  Statement like(tSISCLI_Statement);
end-pr;

dcl-pr SISCLI_closeCursor ind extproc(*dclcase);
  Statement like(tSISCLI_Statement);
end-pr;
