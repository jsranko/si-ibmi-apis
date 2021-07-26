**FREE

/if not defined(SIROUTERP)
  /define SIROUTERP
/else
  /eof
/endif

/include qcpylesrc/siiwsp

dcl-c cSIROUTER_Payload_Length const(8000000);
dcl-c cSIROUTER_ResponseHeaders_Count const(10);

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSIROUTER_Payload char(cSIROUTER_Payload_Length) template;
dcl-s tSIROUTER_Uri varchar(512) template;
dcl-s tSIROUTER_HttpStatus like(tSIIWS_HttpStatus) template;
dcl-s tSIROUTER_HttpHeaderEntry like(tSIIWS_HttpHeaderEntry) template;
dcl-s tSIROUTER_Library varchar(10) template;
dcl-s tSIROUTER_Object varchar(10) template;
dcl-s tSIROUTER_Procedure varchar(1024) template;

dcl-ds tSIROUTER_Payload_Def qualified template;
  Uri like(tSIROUTER_Uri);
end-ds;


//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr SIROUTER extpgm('SIROUTER');
  PayloadIn like(tSIROUTER_Payload) options(*varsize) ccsid(*utf8);
  PayloadOut like(tSIROUTER_Payload) options(*varsize) ccsid(*utf8);
  ResponseCode like(tSIROUTER_HttpStatus);
  ResponseHeaders like(tSIROUTER_HttpHeaderEntry) dim(cSIROUTER_ResponseHeaders_Count);
end-pr;
