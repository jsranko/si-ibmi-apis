**FREE

//******************************************************************************************
//
//
// Programname    : SISCLI
// Programautor   : Sranko Informatik
// Created on     : 05.03.2021
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See QCLLESRC,makesiiia
//
//==========================================================================================

 ctl-opt NoMain bnddir('$(LIBRARY)/SIIIA');

//==========================================================================================
// Constants
//==========================================================================================

dcl-c cNONE const('*NONE');
dcl-c cLOCAL const('*LOCAL');

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

/define SISCLI
/include qcpylesrc/sisclip

/include qcpylesrc/sqlclip

//==========================================================================================
// Procedures
//==========================================================================================

//------------------------------------------------------------------------------------------

dcl-proc SISCLI_crtConfig export;
dcl-pi SISCLI_crtConfig like(tSISCLI_DBConfig) extproc(*dclcase);
 Name like(tSISCLI_Name) value options(*nopass);
end-pi;
dcl-s sName like(tSISCLI_Name);
dcl-ds dsSISCLI_DBConfig likeds(tSISCLI_DBConfig_Def) inz(*likeds);

  if %parms() >= %parmnum(Name);
    sName = Name;
  else;
    sName = cNONE;
  endif;

  dsSISCLI_DBConfig.Name = sName;

  return dsSISCLI_DBConfig;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISCLI_connect export;
dcl-pi SISCLI_connect like(tSISCLI) extproc(*dclcase);
  Database like(tSISCLI_Database) const options(*omit:*nopass);
  SISCLI_DBConfig like(tSISCLI_DBConfig) options(*nopass);
end-pi;
dcl-s sDatabase like(tSISCLI_Database);
dcl-ds dsSISCLI likeds(tSISCLI_Def) inz(*likeds);

  if %parms() >= %parmnum(Database)
  and %addr(Database) <> *null;
    sDatabase = Database;
  else;
    sDatabase = cLOCAL;
  endif;

  if %parms() >= %parmnum(SISCLI_DBConfig);
    dsSISCLI.config = SISCLI_DBConfig;
  else;
    reset dsSISCLI.config;
  endif;

  // Allocate environment handle
  if not allocEnv(dsSISCLI);
    return dsSISCLI;
  endif;

  // Allocate connection handle
  if not allocConnect(dsSISCLI);
    return dsSISCLI;
  endif;

  dsSISCLI.db = sDatabase;
  dsSISCLI.retCode = SQLConnect(dsSISCLI.hdbc
                               :dsSISCLI.db
                               :SQL_NTS
                               :*null
                               :SQL_NTS
                               :*null
                               :SQL_NTS
                               );
  if isErrorConnect(dsSISCLI);
    dsSISCLI.error = getError(*omit:dsSISCLI.hdbc);
    return *off;
  endif;

  return dsSISCLI;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISCLI_disconnect export;
dcl-pi SISCLI_disconnect ind extproc(*dclcase);
 SISCLI like(tSISCLI);
end-pi;
dcl-ds dsSISCLI likeds(tSISCLI_Def) based(pSISCLI);

  pSISCLI = %addr(SISCLI);

  dsSISCLI.retCode = SQLDisconnect(dsSISCLI.hdbc);
  dsSISCLI.retCode = SQLFreeConnect(dsSISCLI.hdbc);
  dsSISCLI.retCode = SQLFreeEnv(dsSISCLI.env);

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISCLI_setCommit export;
dcl-pi SISCLI_setCommit ind extproc(*dclcase);
  SISCLI_DBConfig like(tSISCLI_DBConfig);
  CommitCtl like(tSISCLI_CommitCtl) value;
end-pi;
dcl-ds dsSISCLI_DBConfig likeds(tSISCLI_DBConfig_Def) based(pSISCLI_DBConfig);

  pSISCLI_DBConfig = %addr(SISCLI_DBConfig);

  dsSISCLI_DBConfig.commitCtl = CommitCtl;

  //dsSISCLI.retCode = setAttr(dsSISCLI:SQL_ATTR_COMMIT:%addr(sAttr));

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISCLI_crtStatement export;
dcl-pi SISCLI_crtStatement like(tSISCLI_Statement) extproc(*dclcase);
  SISCLI like(tSISCLI);
  StatementText like(tSISCLI_StatementText) value;
  ForUpdate ind value options(*nopass);
end-pi;
dcl-ds output likeds(tSISCLI_Statement_Def) inz;
dcl-ds dsSISCLI likeds(tSISCLI_Def) based(pSISCLI);

  pSISCLI = %addr(SISCLI);

  dsSISCLI.retCode = SQLAllocStmt(dsSISCLI.hdbc:output.hstmt);
  if isErrorAllocStmt(dsSISCLI);
    dsSISCLI.error = getError(*omit:dsSISCLI.hdbc);
    return *off;
  endif;
  output.hstmtEmergency = output.hstmt;

  if %parms() >= %parmnum(ForUpdate);
    if ForUpdate;
      output.retCode = SQLSetStmtAttrI(output.hstmt:SQL_ATTR_FOR_FETCH_ONLY:SQL_FALSE:0);
      if isErrorSetStmtAttr(output);
        output.error = getError(*omit:*omit:output.hstmt);
      endif;
    endif;
  else;
    // read-only ist default
  endif;

  output.text =  StatementText;

  return output;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISCLI_execute export;
dcl-pi SISCLI_execute ind extproc(*dclcase);
  Statement like(tSISCLI_Statement);
end-pi;
dcl-ds dsStatement likeds(tSISCLI_Statement_Def) based(pStatement);

  pStatement = %addr(Statement);

  initStmt(dsStatement);

  dsStatement.retCode = SQLExecDirect(dsStatement.hstmt:%trim(dsStatement.text): SQL_NTS );
  if isErrorExecDirect(dsStatement);
    dsStatement.error = getError(*omit:*omit:dsStatement.hstmt);
    return *off;
  endif;

  dsStatement.numResultCols = SISCLI_getNumResultCols(Statement);

  dsStatement.fields = getFieldAttrs(dsStatement);

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISCLI_closeStatement export;
dcl-pi SISCLI_closeStatement ind extproc(*dclcase);
  Statement like(tSISCLI_Statement);
end-pi;
dcl-ds dsStatement likeds(tSISCLI_Statement_Def) based(pStatement);

  pStatement = %addr(Statement);

  initStmt(dsStatement);

  if not SISCLI_closeCursor(Statement);
    return *off;
  endif;

  dsStatement.retCode = SQLFreeHandle(SQL_HANDLE_STMT:dsStatement.hstmt);
  if isErrorFreeHandle(dsStatement);
    dsStatement.error = getError(*omit:*omit:dsStatement.hstmt);
    return *off;
  endif;

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISCLI_setSysNaming export;
dcl-pi SISCLI_setSysNaming extproc(*dclcase);
  SISCLI_DBConfig like(tSISCLI_DBConfig);
  Attr ind value;
end-pi;
dcl-ds dsSISCLI_DBConfig likeds(tSISCLI_DBConfig_Def) based(pSISCLI_DBConfig);

  pSISCLI_DBConfig = %addr(SISCLI_DBConfig);

  if Attr;
    dsSISCLI_DBConfig.sysNaming = SQL_TRUE;
  else;
    dsSISCLI_DBConfig.sysNaming = SQL_FALSE;
  endif;

  return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISCLI_fetch export;
dcl-pi SISCLI_fetch ind extproc(*dclcase);
  Statement like(tSISCLI_Statement);
  PointerToData pointer value;
end-pi;
dcl-ds dsStatement likeds(tSISCLI_Statement_Def) based(pStatement);

  pStatement = %addr(Statement);

  initStmt(dsStatement);

  //if not bindColumnsToProgramVars(dsStatement:PointerToData:PointerToIndAra);
  //  return *off;
  //endif;

  dsStatement.retCode = SQLFetch(dsStatement.hstmt);
  if isErrorFetch(dsStatement);
    dsStatement.error = getError(*omit:*omit:dsStatement.hstmt);
    return *off;
  endif;

  if not getData(dsStatement:PointerToData);
    return *off;
  endif;

  // WICHTIG: Es gib ein Fehler. Nach Fetch wird Erster-Byte von hstmt auf 4 (bzw geändert)
  // Dies ist nur eine Not Lösung!!!!
  dsStatement.hstmt = dsStatement.hstmtEmergency;

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISCLI_isEOF export;
dcl-pi SISCLI_isEOF ind extproc(*dclcase);
  Statement like(tSISCLI_Statement);
end-pi;
dcl-ds dsStatement likeds(tSISCLI_Statement_Def) based(pStatement);

  pStatement = %addr(Statement);

  initStmt(dsStatement);

  return dsStatement.eof;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISCLI_getNumResultCols export;
dcl-pi SISCLI_getNumResultCols like(tSISCLI_NumResultCols) extproc(*dclcase);
  Statement like(tSISCLI_Statement);
end-pi;
dcl-s output like(tSISCLI_NumResultCols);
dcl-ds dsStatement likeds(tSISCLI_Statement_Def) based(pStatement);

  pStatement = %addr(Statement);

  initStmt(dsStatement);

  dsStatement.retCode = SQLNumResultCols(dsStatement.hstmt:output);
  if isErrorNumResultCols(dsStatement);
    dsStatement.error = getError(*omit:*omit:dsStatement.hstmt);
    return 0;
  endif;

  return output;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISCLI_closeCursor export;
dcl-pi SISCLI_closeCursor ind extproc(*dclcase);
  Statement like(tSISCLI_Statement);
end-pi;
dcl-ds dsStatement likeds(tSISCLI_Statement_Def) based(pStatement);

  pStatement = %addr(Statement);

  initStmt(dsStatement);

  dsStatement.retCode = SQLCloseCursor(dsStatement.hstmt);
  if isErrorCloseCursor(dsStatement);
    dsStatement.error = getError(*omit:*omit:dsStatement.hstmt);
    return *off;
  endif;

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc initStmt;
dcl-pi initStmt;
  dsStatement likeds(tSISCLI_Statement_Def);
end-pi;

  clear dsStatement.error;
  clear dsStatement.retCode;

return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc getError;
dcl-pi getError likeds(tSISCLI_Error);
  environmentHandle like(SQLINTEGER) options(*omit:*nopass);
  connectionHandle like(SQLINTEGER) options(*omit:*nopass);
  statementHandle like(SQLINTEGER) options(*nopass);
end-pi;
dcl-s handle like(SQLINTEGER);
dcl-s handleType like(SQLSMALLINT);
dcl-s msgLen like(SQLSMALLINT);
dcl-s recCode like(tSISCLI_Return);
dcl-ds output likeds(tSISCLI_Error);

  if %addr(connectionHandle) <> *null;
    handleType = SQL_HANDLE_DBC;
    handle = connectionHandle;
  endif;
  if %parms() >= %parmnum(environmentHandle)
  and %addr(environmentHandle) <> *null;
    handleType = SQL_HANDLE_ENV;
    handle = environmentHandle;
  endif;
  if %parms() >= %parmnum(statementHandle);
    handleType = SQL_HANDLE_STMT;
    handle = statementHandle;
  endif;

  recCode = SQLGetDiagRec(handleType
                         :handle
                         :1
                         :output.sqlState
                         :output.sqlCode
                         :output.MessageText
                         :%len(output.MessageText)
                         :msgLen
                         );

  return output;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc allocEnv;
dcl-pi allocEnv ind;
  dsSISCLI likeds(tSISCLI_Def);
end-pi;

  // Create Handle
  dsSISCLI.retCode = SqlAllocEnv(dsSISCLI.env);
  if isErrorAllocEnv(dsSISCLI);
    dsSISCLI.error = getError(dsSISCLI.env);
    return *off;
  endif;

  // Set SysNaming
  dsSISCLI.retCode = SQLSetEnvAttr(dsSISCLI.env:SQL_ATTR_SYS_NAMING:%addr(dsSISCLI.config.sysNaming):0);
  if isErrorSetEnvAttr(dsSISCLI);
    dsSISCLI.error = getError(dsSISCLI.env);
    return *off;
  endif;

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc allocConnect;
dcl-pi allocConnect ind;
  dsSISCLI likeds(tSISCLI_Def);
end-pi;

  // Allocate Connection
  dsSISCLI.retCode = SqlAllocConnect(dsSISCLI.env:dsSISCLI.hdbc);
  if isErrorAllocConnect(dsSISCLI);
    return *off;
  endif;

  // Set Attribute commit
  dsSISCLI.retCode = SQLSetConnectOption(dsSISCLI.hdbc:SQL_ATTR_COMMIT:%addr(dsSISCLI.config.commitCtl));
  if isErrorSetConnectOption(dsSiSCLI);
    return *off;
  endif;

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isErrorSetEnvAttr;
dcl-pi isErrorSetEnvAttr ind;
  dsSISCLI likeds(tSISCLI_Def);
end-pi;

  if dsSISCLI.retCode <> SQL_SUCCESS
  and dsSISCLI.retCode <> SQL_SUCCESS_WITH_INFO;
    return *on;
  endif;

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isErrorAllocEnv;
dcl-pi isErrorAllocEnv ind;
  dsSISCLI likeds(tSISCLI_Def);
end-pi;

  if dsSISCLI.retCode <> SQL_SUCCESS;
    return *on;
  endif;

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isErrorAllocConnect;
dcl-pi isErrorAllocConnect ind;
  dsSISCLI likeds(tSISCLI_Def);
end-pi;

  if dsSISCLI.retCode <> SQL_SUCCESS;
    return *on;
  endif;

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isErrorSetConnectOption;
dcl-pi isErrorSetConnectOption ind;
  dsSISCLI likeds(tSISCLI_Def);
end-pi;

  if dsSISCLI.retCode <> SQL_SUCCESS
  and dsSISCLI.retCode <> SQL_SUCCESS_WITH_INFO;
    return *on;
  endif;

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isErrorConnect;
dcl-pi isErrorConnect ind;
  dsSISCLI likeds(tSISCLI_Def);
end-pi;

  if dsSISCLI.retCode <> SQL_SUCCESS
  and dsSISCLI.retCode <> SQL_SUCCESS_WITH_INFO;
    return *on;
  endif;

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isErrorAllocStmt;
dcl-pi isErrorAllocStmt ind;
  dsSISCLI likeds(tSISCLI_Def);
end-pi;

  if dsSISCLI.retCode <> SQL_SUCCESS;
    return *on;
  endif;

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isErrorExecDirect;
dcl-pi isErrorExecDirect ind;
  dsStatement likeds(tSISCLI_Statement_Def);
end-pi;

  if dsStatement.retCode <> SQL_SUCCESS
  and dsStatement.retCode <> SQL_SUCCESS_WITH_INFO;
    return *on;
  endif;

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isErrorFreeHandle;
dcl-pi isErrorFreeHandle ind;
  dsStatement likeds(tSISCLI_Statement_Def);
end-pi;

  if dsStatement.retCode <> SQL_SUCCESS;
    return *on;
  endif;

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isErrorNumResultCols;
dcl-pi isErrorNumResultCols ind;
  dsStatement likeds(tSISCLI_Statement_Def);
end-pi;

  if dsStatement.retCode <> SQL_SUCCESS;
    return *on;
  endif;

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isErrorColAttribute;
dcl-pi isErrorColAttribute ind;
  dsStatement likeds(tSISCLI_Statement_Def);
end-pi;

  if dsStatement.retCode <> SQL_SUCCESS
  and dsStatement.retCode <> SQL_SUCCESS_WITH_INFO;
    return *on;
  endif;

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isErrorSetStmtAttr;
dcl-pi isErrorSetStmtAttr ind;
  dsStatement likeds(tSISCLI_Statement_Def);
end-pi;

  if dsStatement.retCode <> SQL_SUCCESS
  and dsStatement.retCode <> SQL_SUCCESS_WITH_INFO;
    return *on;
  endif;

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isErrorBindCol;
dcl-pi isErrorBindCol ind;
  dsStatement likeds(tSISCLI_Statement_Def);
end-pi;

  if dsStatement.retCode <> SQL_SUCCESS;
    return *on;
  endif;

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isErrorFetch;
dcl-pi isErrorFetch ind;
  dsStatement likeds(tSISCLI_Statement_Def);
end-pi;

  if dsStatement.retCode <> SQL_SUCCESS
  and dsStatement.retCode <> SQL_SUCCESS_WITH_INFO;
    return *on;
  endif;

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isErrorCloseCursor;
dcl-pi isErrorCloseCursor ind;
  dsStatement likeds(tSISCLI_Statement_Def);
end-pi;

  if dsStatement.retCode <> SQL_SUCCESS;
    return *on;
  endif;

  return *off;
end-proc;


//------------------------------------------------------------------------------------------

dcl-proc isErrorGetCol;
dcl-pi isErrorGetCol ind;
  dsStatement likeds(tSISCLI_Statement_Def);
end-pi;

  if dsStatement.retCode <> SQL_SUCCESS
  and dsStatement.retCode <> SQL_SUCCESS_WITH_INFO;
    return *on;
  endif;

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc getFieldAttrs export;
dcl-pi getFieldAttrs likeds(tSISCLI_FieldAttrs) dim(cSISCLI_MAXCOLS) extproc(*dclcase);
  dsStatement likeds(tSISCLI_Statement_Def);
end-pi;
dcl-ds output likeds(tSISCLI_FieldAttrs) dim(cSISCLI_MAXCOLS) inz;
dcl-s retCode like(tSISCLI_Return);
dcl-s offset like(SQLINTEGER) inz(0);
dcl-s nullPtr pointer;
dcl-s fieldNameLen like(SQLSMALLINT);
dcl-s fieldType like(SQLSMALLINT);
dcl-s fieldPrec like(SQLINTEGER);
dcl-s fieldScale like(SQLSMALLINT);
dcl-s fieldNull like(SQLSMALLINT);
dcl-s fieldName char(513);
dcl-s number2 like(SQLINTEGER);
dcl-s i like(tSISCLI_NumResultCols);

  for i = 1 to dsStatement.numResultCols;

      retCode = SQLDescribeCol(dsStatement.hstmt:i:fieldName:%size(fieldName):fieldNameLen:fieldType:fieldPrec:fieldScale:fieldNull);

//      retCode = SQLColAttribute(dsStatement.hstmt:i:SQL_DESC_LENGTH:nullPtr:%size(fieldSize):number2:%addr(fieldSize));
//      if isErrorColAttribute(dsStatement);
//        dsStatement.error = getError(*omit:*omit:dsStatement.hstmt);
//        return output;
//      endif;
//
//      retCode = SQLColAttribute(dsStatement.hstmt:i:SQL_DESC_TYPE:nullPtr:%size(fieldType):number2:%addr(fieldType));
//      if isErrorColAttribute(dsStatement);
//        dsStatement.error = getError(*omit:*omit:dsStatement.hstmt);
//        return output;
//      endif;

//      retCode = SQLColAttribute(dsStatement.hstmt:i:SQL_DESC_BASE_COLUMN:nullPtr:%size(fieldType):number2:%addr(fieldType));
//      if isErrorColAttribute(dsStatement);
//        dsStatement.error = getError(*omit:*omit:dsStatement.hstmt);
//        return output;
//      endif;

      output(i).offset = offset;
      output(i).size = fieldPrec;
      output(i).dataType = fieldType;
      output(i).dataTypeC = fieldType;
      select;
      when fieldType = SQL_NUMERIC;
        output(i).dataTypeC = SQL_CHAR;
      when fieldType = SQL_DECIMAL;
        output(i).dataTypeC = SQL_CHAR;
      when fieldType = SQL_VARCHAR;
        output(i).dataTypeC = SQL_CHAR;
        output(i).size = output(i).size + 2;
        //output(i).dataTypeC = SQL_CHAR;
      endsl;


      offset = offset + output(i).size;
  endfor;

  return output;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc bindColumnsToProgramVars ;
dcl-pi bindColumnsToProgramVars ind;
  dsStatement likeds(tSISCLI_Statement_Def);
  PointerToData pointer;
end-pi;
dcl-s sizeReturned like(SQLINTEGER) dim(cSISCLI_MAXCOLS);
dcl-s i like(tSISCLI_NumResultCols);

  for i = 1 to dsStatement.numResultCols;
    dsStatement.retCode = SQLBindCol(dsStatement.hstmt
                                    :i
                                    :dsStatement.fields(i).dataTypeC
                                    :PointerToData + dsStatement.fields(i).offset
                                    :dsStatement.fields(i).size
                                    :sizeReturned(i)
                                    );
    if isErrorBindCol(dsStatement);
      dsStatement.error = getError(*omit:*omit:dsStatement.hstmt);
      return *off;
    endif;

  endfor;

  //dsStatement.binded = *on;

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc getData ;
dcl-pi getData ind;
  dsStatement likeds(tSISCLI_Statement_Def);
  PointerToData pointer;
end-pi;
dcl-s ptrToBuffer like(SQLPOINTER);
dcl-s sizeReturned like(SQLINTEGER) dim(cSISCLI_MAXCOLS);
dcl-s i like(tSISCLI_NumResultCols);

  ptrToBuffer = PointerToData;
  for i = 1 to dsStatement.numResultCols;

    dsStatement.retCode = SQLGetCol(dsStatement.hstmt
                                   :i
                                   :dsStatement.fields(i).dataTypeC
                                   :ptrToBuffer
                                   :dsStatement.fields(i).size
                                   :sizeReturned(i)
                                   );
    if isErrorGetCol(dsStatement);
      dsStatement.error = getError(*omit:*omit:dsStatement.hstmt);
      return *off;
    endif;
    ptrToBuffer = ptrToBuffer +  dsStatement.fields(i).size;

  endfor;

  //dsStatement.binded = *on;

  return *on;
end-proc;
