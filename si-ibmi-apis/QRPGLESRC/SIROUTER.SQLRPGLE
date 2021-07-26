**FREE

//******************************************************************************************
//
//
// Programname    : SIROUTER
// Programautor   : Sranko Informatik
// Created on     : 06.05.2020
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See makefile
//
//==========================================================================================

ctl-opt main(SIROUTER) dftactgrp(*no) actgrp(*new);
ctl-opt pgminfo(*pcml:*module);
ctl-opt stgmdl(*teraspace);

/include qcpylesrc/sictlopt

//==========================================================================================
// Constants
//==========================================================================================

dcl-c cNull const(x'00');
dcl-c cLIBL const('*LIBL');

//==========================================================================================
// Global-Definition
//==========================================================================================

dcl-s cJSON_Path_Uri like(tSIROUTER_Uri) inz('$.uri');
dcl-s cJSON_Path_Payload like(tSIROUTER_Uri) inz('$.payload');

//==========================================================================================
// Prototypes
//==========================================================================================

/include qcpylesrc/sirouterp
/include qcpylesrc/sisqlp
/include qcpylesrc/memcpyp
/include qcpylesrc/memsetp
/include qcpylesrc/sisrvpgmp

//==========================================================================================
// Main
//==========================================================================================

dcl-proc SIROUTER;
dcl-pi SIROUTER;
  PayloadIn like(tSIROUTER_Payload) options(*varsize) ccsid(*utf8);
  PayloadOut like(tSIROUTER_Payload) options(*varsize) ccsid(*utf8);
  ResponseCode like(tSIROUTER_HttpStatus);
  ResponseHeaders like(tSIROUTER_HttpHeaderEntry) dim(cSIROUTER_ResponseHeaders_Count);
end-pi;
dcl-s nStdIn ind inz(*off);
dcl-s nStdOut ind inz(*off);
dcl-s uri like(tSIROUTER_Uri);
dcl-s PayloadInLength int(10);
dcl-s payloadCLOB sqltype(clob:8000000) ccsid(*utf8);

if %addr(PayloadIn) = *null;
  nStdIn = *on;
endif;

if %addr(PayloadOut) = *null;
  nStdOut = *on;
endif;

exsr prepareParameters;

exsr savePayloadToSQLVar;

exsr checkParameters;
if ResponseCode <> *zeros;
  return;
endif;

monitor;
  //uri = getUri(%addr(PayloadIn));
  uri = getUri();
on-error;
endmon;

exsr processPayload;

exsr processResponse;

return;

// .........................................................................................
begsr prepareParameters;

  if %addr(PayloadIn) <> *null;
    //PayloadInLength = %len(%trim(PayloadIn));
    PayloadInLength = getEndOfData(PayloadIn);
    memset(%addr(PayloadIn) + PayloadInLength:cNull:%size(PayloadOut) - PayloadInLength);
  endif;

  if %addr(PayloadOut) <> *null;
    memset(%addr(PayloadOut):cNull:%size(PayloadOut));
  endif;

endsr;

// .........................................................................................
begsr checkParameters;

  //if not existUri(%addr(PayloadIn))
  //or not existPayload(%addr(PayloadIn));
  if not existUri()
  or not existPayload();
    ResponseCode = cSIIWS_ResponseCode_InternalServerError;
    PayloadOut = 'teste';
  endif;

endsr;

// .........................................................................................
begsr savePayloadToSQLVar;

  payloadCLOB_len = PayloadInLength;
  memcpy(%addr(payloadCLOB_data):%addr(PayloadIn):payloadCLOB_len);

  exec sql set si_payload_in = json_to_bson(:payloadCLOB);

endsr;

// .........................................................................................
begsr processPayload;

  monitor;
    select;
    when isServiceProgram(uri);
      //doServiceProgramCall(uri:PayloadIn:PayloadOut);
      doServiceProgramCall(uri);
    when isProgram(uri);
      //doProgramCall(uri:PayloadIn:PayloadOut);
      doProgramCall(uri);
    when isStatement(uri);
      //doStatement(uri:PayloadIn:PayloadOut);
      doStatement(uri);
    endsl;
  on-error;
    ResponseCode = cSIIWS_ResponseCode_InternalServerError;
  endmon;

endsr;

// .........................................................................................
begsr processResponse;

  exsr processResponseCode;

  exsr setPayloadFromSQLVar;

  exsr processResponseHeaders;

endsr;

// .........................................................................................
begsr setPayloadFromSQLVar;

  exec sql set :payloadCLOB = json_query(si_payload_out, 'strict $.response') ;

  memcpy(%addr(PayloadOut):%addr(payloadCLOB_data):payloadCLOB_len);

endsr;

// .........................................................................................
begsr processResponseCode;

  if %addr(ResponseCode) <> *null;
    //ResponseCode = getResponseCode(%addr(PayloadOut));
    ResponseCode = getResponseCode();

    if ResponseCode = *zeros;
      ResponseCode = cSIIWS_ResponseCode_OK;
    endif;

  endif;

endsr;

// .........................................................................................
begsr processResponseHeaders;
  if %addr(ResponseHeaders) <> *null;
    //ResponseHeaders = getResponseHeaders(%addr(PayloadOut));
    ResponseHeaders = getResponseHeaders();
  endif;
endsr;

end-proc;

//------------------------------------------------------------------------------------------

dcl-proc getUri;
dcl-pi getUri like(tSIROUTER_Uri);
  //Payload pointer value;
end-pi;
dcl-s uri like(tSIROUTER_Uri);
dcl-s NullInd int(5);
//dcl-s payloadCLOB sqltype(clob:8000000);

//  payloadCLOB_len = %len(%str(Payload));
//  memcpy(%addr(payloadCLOB_data):Payload:payloadCLOB_len);

  exec sql set :uri :NullInd =
           json_value(si_payload_in,
                      :cJSON_Path_Uri returning char(276)
                      error on error);
  select;
  when NullInd = -1;
    return *blanks;
  when SISQL_isError(sqlca);
    return *blanks;
  endsl;

  return uri;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc existUri;
dcl-pi existUri ind;
  //Payload pointer value;
end-pi;
dcl-s uri char(1);
dcl-s NullInd int(5);
//dcl-s payloadCLOB sqltype(clob:8000000);

//  payloadCLOB_len = %len(%str(Payload));
//  memcpy(%addr(payloadCLOB_data):Payload:payloadCLOB_len);

  exec sql set :uri :NullInd =
           json_value(si_payload_in,
                      :cJSON_Path_Uri returning char(1)
                      error on error);
  select;
  when NullInd = -1;
    return *off;
  when SISQL_isError(sqlca);
    return *off;
  endsl;

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc existPayload;
dcl-pi existPayload ind;
//  Payload pointer value;
end-pi;
dcl-s pay char(1);
dcl-s NullInd int(5);
//dcl-s payloadCLOB sqltype(clob:8000000);

//  payloadCLOB_len = %len(%str(Payload));
//  memcpy(%addr(payloadCLOB_data):Payload:payloadCLOB_len);

  exec sql set :pay :NullInd =
           json_value(si_payload_in,
                      :cJSON_Path_Payload returning char(1)
                      error on error);
  select;
  when NullInd = -1;
    return *off;
  when SISQL_isError(sqlca);
    return *off;
  endsl;

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc getResponseCode;
dcl-pi getResponseCode like(tSIROUTER_HttpStatus);
//  Payload pointer value;
end-pi;
dcl-s ResponseCode like(tSIROUTER_HttpStatus);
dcl-s NullInd int(5);
//dcl-s payloadCLOB sqltype(clob:8000000);

//  payloadCLOB_len = %len(%str(Payload));
//  memcpy(%addr(payloadCLOB_data):Payload:payloadCLOB_len);

  exec sql set :ResponseCode :NullInd =
           json_value(si_payload_out,
                      '$.response_code' returning integer
                      error on error);
  select;
  when NullInd = -1;
    return *zeros;
  when SISQL_isError(sqlca);
    return *zeros;
  endsl;

  return ResponseCode;
end-proc;

//------------------------------------------------------------------------------------------
//{
// "headers":[
//    {
//       "key":"KeyX",
//       "value":"ValueForX"
//    },
//    {
//       "key":"KeyX",
//       "value":"ValueForX"
//    }
//           ]
//}'
//------------------------------------------------------------------------------------------

dcl-proc getResponseHeaders;
dcl-pi getResponseHeaders like(tSIROUTER_HttpHeaderEntry) dim(cSIROUTER_ResponseHeaders_Count);
//  Payload pointer value;
end-pi;
dcl-s ResponseHeaders like(tSIROUTER_HttpHeaderEntry) dim(cSIROUTER_ResponseHeaders_Count);
dcl-s Key like(tSIROUTER_HttpHeaderEntry);
dcl-s Value like(tSIROUTER_HttpHeaderEntry);
//dcl-s payloadCLOB sqltype(clob:8000000);
dcl-s idx int(5);
dcl-s json_path varchar(50);
dcl-s existHeaders ind;

//  payloadCLOB_len = %len(%str(Payload));
//  memcpy(%addr(payloadCLOB_data):Payload:payloadCLOB_len);
  exec sql set :existHeaders =
           case
           when json_exists(si_payload_out, 'strict $.headers' false on error) then '1'
           else '0' end;

  if not existHeaders;
    return *blanks;
  endif;

  for idx = 0 to cSIROUTER_ResponseHeaders_Count - 1;
    json_path = 'strict $.headers[' + %char(idx) + '].key';

    exec sql set :existHeaders =
             case
             when json_exists(si_payload_out, :json_path false on error) then '1'
             else '0' end;

    if not existHeaders;
      leave;
    endif;

    exec sql set :Key = json_value(si_payload_out,
                                  :json_path returning varchar(256)
                                  error on error);
    if SISQL_isError(sqlca);
      leave;
    endif;

    json_path = 'strict $.headers[' + %char(idx) + '].value';
    exec sql set :Value = json_value(si_payload_out,
                                     :json_path returning varchar(256)
                                     error on error);
    ResponseHeaders(idx + 1) = %trim(Key) + ':' + %trim(Value);
  endfor;

  return ResponseHeaders;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isServiceProgram;
dcl-pi isServiceProgram ind;
  Uri like(tSIROUTER_Uri);
end-pi;

  if %scan('(': Uri: 2) = 0
  or %scan(')': Uri: 2) = 0
  or getProcedure(Uri) = *blanks;
    return *off;
  endif;

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isProgram;
dcl-pi isProgram ind;
  uri like(tSIROUTER_Uri);
end-pi;

  if Uri = *blanks
  or isServiceProgram(Uri)
  or isStatement(Uri);
    return *off;
  endif;

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isStatement;
dcl-pi isStatement ind;
  uri like(tSIROUTER_Uri);
end-pi;

  if %scan(',': uri: 2) = 0;
    return *off;
  endif;

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc doServiceProgramCall;
dcl-pi doServiceProgramCall;
  Uri like(tSIROUTER_Uri);
//  PayloadIn like(tSIROUTER_Payload) options(*varsize);
//  PayloadOut like(tSIROUTER_Payload) options(*varsize) ccsid(*utf8);
end-pi;
dcl-s Library like(tSIROUTER_Library);
dcl-s Object like(tSIROUTER_Object);
dcl-s Procedure like(tSIROUTER_Procedure);
dcl-s ServiceProgram like(tSISRVPGM);
dcl-s procedurePointer like(tSISRVPGM_ProcedurePointer);
//dcl-pr callProcedure extproc(procedurePointer);
//  PayloadIn like(tSIROUTER_Payload) options(*varsize);
//  PayloadOut like(tSIROUTER_Payload) options(*varsize) ccsid(*utf8);
//end-pr;
dcl-pr callProcedure extproc(procedurePointer);
end-pr;

  Library = getLibrary(Uri);
  Object = getObject(Uri);
  Procedure = getProcedure(Uri);
  ServiceProgram =  SISRVPGM_(Object:Library);

  if not SISRVPGM_load(ServiceProgram);

  endif;

  procedurePointer = SISRVPGM_getProcedurePointerByName(ServiceProgram:Procedure);
  callProcedure();

  return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc doProgramCall;
dcl-pi doProgramCall;
  Uri like(tSIROUTER_Uri);
//  PayloadIn like(tSIROUTER_Payload) options(*varsize);
//  PayloadOut like(tSIROUTER_Payload) options(*varsize) ccsid(*utf8);
end-pi;
dcl-s Library like(tSIROUTER_Library);
dcl-s Object like(tSIROUTER_Object);
dcl-s sCallProgram varchar(21);
//dcl-pr callProgram extpgm(sCallProgram);
//  PayloadIn like(tSIROUTER_Payload) options(*varsize);
//  PayloadOut like(tSIROUTER_Payload) options(*varsize) ccsid(*utf8);
//end-pr;
dcl-pr callProgram extpgm(sCallProgram);
end-pr;

  Library = getLibrary(Uri);
  Object = getObject(Uri);
  sCallProgram = Library + '/' + Object;
  //callProgram(PayloadIn:PayloadOut);
  callProgram();

  return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc doStatement;
dcl-pi doStatement;
  Uri like(tSIROUTER_Uri);
//  PayloadIn like(tSIROUTER_Payload) options(*varsize);
//  PayloadOut like(tSIROUTER_Payload) options(*varsize) ccsid(*utf8);
end-pi;

  return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc getLibrary;
dcl-pi getLibrary like(tSIROUTER_Library);
  Uri like(tSIROUTER_Uri);
end-pi;
dcl-s strPos int(5);
dcl-s Library like(tSIROUTER_Library);

  strPos = %scan('/': Uri: 2);
  if strPos = 0;
    return cLIBL;
  endif;

  Library = %subst(Uri:1:StrPos-1);
  if Library = *blanks;
    return cLIBL;
  endif;

  return Library;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc getObject;
dcl-pi getObject like(tSIROUTER_Object);
  Uri like(tSIROUTER_Uri);
end-pi;
dcl-s strPos int(5);
dcl-s endPos int(5);
dcl-s Object like(tSIROUTER_Object);

  strPos = %scan('/': Uri: 2);
  if strPos = 0
  and not isServiceProgram(Uri)
  and not isStatement(Uri);
    return Uri;
  else;
    strPos = 1;
  endif;

  if isServiceProgram(Uri);
    endPos = %scan('(': Uri: 2) ;
  endif;

  Object = %subst(Uri:strPos:endPos - strPos);

  return Object;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc getProcedure;
dcl-pi getProcedure like(tSIROUTER_Procedure);
  Uri like(tSIROUTER_Uri);
end-pi;
dcl-s strPos int(5);
dcl-s endPos int(5);
dcl-s Procedure like(tSIROUTER_Procedure);

  strPos = %scan('(': Uri: 2);
  if strPos = 0;
    return *blanks;
  endif;

  endPos = %scan(')': Uri: 4) - 1;
  if endPos = 0;
    return *blanks;
  endif;

  Procedure = %subst(Uri:strPos + 1:endPos - strPos);

  return Procedure;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc getEndOfData;
dcl-pi getEndOfData int(10);
  PayloadIn like(tSIROUTER_Payload)  ccsid(*utf8);
end-pi;
dcl-c cBlankEBCDIC const(x'40');
dcl-c cBlankASCII const(x'20');
dcl-s index int(10);
dcl-s lastDataIndex int(10) inz(0);
dcl-s length int(10);
dcl-s symbol char(1) based(pSymbol);

  length = %size(PayloadIn);
  pSymbol = %addr(PayloadIn);
  for index = 1 to length;
    if symbol <> cNull
    and symbol <> cBlankEBCDIC
    and symbol <> cBlankASCII;
      lastDataIndex = index;
    endif;
    pSymbol = pSymbol + 1;
  endfor;

  return lastDataIndex;
end-proc;
