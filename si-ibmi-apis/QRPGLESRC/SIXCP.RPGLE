**FREE

//******************************************************************************************
//
//
// Programname    : SIXCP
// Programautor   : Sranko Informatik
// Created on     : 04.04.2019
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See QCLLESRC,makesiiia
//
//==========================================================================================

ctl-opt NoMain;

/include qcpylesrc/sictlopt

//==========================================================================================
// Templates
//==========================================================================================

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

/define SIXCP
/include qcpylesrc/sixcpp

//==========================================================================================
// Procedures
//==========================================================================================

//------------------------------------------------------------------------------------------

dcl-proc SIXCP_throw export;
dcl-pi SIXCP_throw extproc(*dclcase);
end-pi;


return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIXCP_throwWithMessage export;
dcl-pi SIXCP_throwWithMessage extproc(*dclcase);
  Message like(tSIXCP_MessageData) const;
  CallStackEntryQualification like(tSIXCP_CallStackEntryQualification) const options(*nopass);
end-pi;

if %parms < %parmnum(CallStackEntryQualification);
  throw('SIE0000':Message:cSIIIA_MSGF);
else;
  throw('SIE0000':Message:cSIIIA_MSGF:CallStackEntryQualification);
endif;

return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIXCP_throwWithMessageId export;
dcl-pi SIXCP_throwWithMessageId extproc(*dclcase);
  MessageId like(tSIXCP_MessageId) const;
  MessageData like(tSIXCP_MessageData) const options(*omit);
  MessageFile like(tSIXCP_MessageFile) const;
  CallStackEntryQualification like(tSIXCP_CallStackEntryQualification) const options(*nopass);
end-pi;

if %parms < %parmnum(CallStackEntryQualification);
  if %addr(MessageData) = *null;
    throw(MessageId:*omit:MessageFile);
  else;
    throw(MessageId:MessageData:MessageFile);
  endif;
else;
  if %addr(MessageData) = *null;
    throw(MessageId:*omit:MessageFile:CallStackEntryQualification);
  else;
    throw(MessageId:MessageData:MessageFile:CallStackEntryQualification);
  endif;
endif;

return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-Proc throw;
dcl-pi throw;
  MessageId like(tSIXCP_MessageId) const;
  MessageData like(tSIXCP_MessageData) const options(*omit);
  MessageFile like(tSIXCP_MessageFile) const;
  CallStackEntryQualification like(tSIXCP_CallStackEntryQualification) const options(*nopass);
end-pi;
dcl-s MsgData like(tSIXCP_MessageData);
dcl-s MessageKey like(tQMHSNDPM_MessageKey);
dcl-ds ErrorCode likeds(tQUSEC);

if %addr(MessageData) <> *null;
  MsgData = MessageData;
endif;

if %parms >= %parmnum(CallStackEntryQualification);
  SendProgramMessage(MessageId
                    :MessageFile
                    :MsgData
                    :%len(%trim(MsgData))
                    :cQMHSNDPM_MessageType_Escape
                    :cQMHSNDPM_CallStackEntry_PGMNAME
                    :0
                    :MessageKey
                    :ErrorCode
                    :10
                    :CallStackEntryQualification
                    :0
                    );
else;
  SendProgramMessage(MessageId
                    :MessageFile
                    :MsgData
                    :%len(%trim(MsgData))
                    :cQMHSNDPM_MessageType_Escape
                    :cQMHSNDPM_CallStackEntry_CurrentEntry
                    :4
                    :MessageKey
                    :ErrorCode
                    );
endif;


return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIXCP_status export;
dcl-pi SIXCP_status extproc(*dclcase);
end-pi;


return;
end-proc;
//------------------------------------------------------------------------------------------

dcl-proc SIXCP_statusWithMessage export;
dcl-pi SIXCP_statusWithMessage extproc(*dclcase);
  Message like(tSIXCP_MessageData) const;
end-pi;

status('SIE0000':Message:cSIIIA_MSGF);

return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIXCP_statusWithMessageId export;
dcl-pi SIXCP_statusWithMessageId extproc(*dclcase);
  MessageId like(tSIXCP_MessageId) const;
  MessageData like(tSIXCP_MessageData) const options(*omit);
  MessageFile like(tSIXCP_MessageFile) const;
end-pi;

if %addr(MessageData) = *null;
  status(MessageId:*omit:MessageFile);
else;
  status(MessageId:MessageData:MessageFile);
endif;

return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-Proc status;
dcl-pi status;
  MessageId like(tSIXCP_MessageId) const;
  MessageData like(tSIXCP_MessageData) const options(*omit);
  MessageFile like(tSIXCP_MessageFile) const;
end-pi;
dcl-s MsgData like(tSIXCP_MessageData);
dcl-s MessageKey like(tQMHSNDPM_MessageKey);
dcl-ds ErrorCode likeds(tQUSEC);

if %addr(MessageData) <> *null;
  MsgData = MessageData;
endif;

SendProgramMessage(MessageId
                  :MessageFile
                  :MsgData
                  :%len(%trim(MsgData))
                  :cQMHSNDPM_MessageType_Status
                  :cQMHSNDPM_CallStackEntry_EXT
                  :3
                  :MessageKey
                  :ErrorCode
                  );

return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIXCP_diag export;
dcl-pi SIXCP_diag extproc(*dclcase);
end-pi;


return;
end-proc;
//------------------------------------------------------------------------------------------

dcl-proc SIXCP_diagWithMessage export;
dcl-pi SIXCP_diagWithMessage extproc(*dclcase);
  Message like(tSIXCP_MessageData) const;
end-pi;

diag('SIE0000':Message:cSIIIA_MSGF);

return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIXCP_diagWithMessageId export;
dcl-pi SIXCP_diagWithMessageId extproc(*dclcase);
  MessageId like(tSIXCP_MessageId) const;
  MessageData like(tSIXCP_MessageData) const options(*omit);
  MessageFile like(tSIXCP_MessageFile) const;
end-pi;

if %addr(MessageData) = *null;
  diag(MessageId:*omit:MessageFile);
else;
  diag(MessageId:MessageData:MessageFile);
endif;

return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-Proc diag;
dcl-pi diag;
  MessageId like(tSIXCP_MessageId) const;
  MessageData like(tSIXCP_MessageData) const options(*omit);
  MessageFile like(tSIXCP_MessageFile) const;
end-pi;
dcl-s MsgData like(tSIXCP_MessageData);
dcl-s MessageKey like(tQMHSNDPM_MessageKey);
dcl-ds ErrorCode likeds(tQUSEC);

if %addr(MessageData) <> *null;
  MsgData = MessageData;
endif;

SendProgramMessage(MessageId
                  :MessageFile
                  :MsgData
                  :%len(%trim(MsgData))
                  :cQMHSNDPM_MessageType_Diag
                  :cQMHSNDPM_CallStackEntry_PGMBDY
                  :3
                  :MessageKey
                  :ErrorCode
                  );

return;
end-proc;
//------------------------------------------------------------------------------------------

dcl-proc SIXCP_info export;
dcl-pi SIXCP_info extproc(*dclcase);
end-pi;


return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIXCP_infoWithMessage export;
dcl-pi SIXCP_infoWithMessage extproc(*dclcase);
  Message like(tSIXCP_MessageData) const;
end-pi;

info('SIE0000':Message:cSIIIA_MSGF);

return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIXCP_infoWithMessageId export;
dcl-pi SIXCP_infoWithMessageId extproc(*dclcase);
  MessageId like(tSIXCP_MessageId) const;
  MessageData like(tSIXCP_MessageData) const options(*omit);
  MessageFile like(tSIXCP_MessageFile) const;
end-pi;

if %addr(MessageData) = *null;
  info(MessageId:*omit:MessageFile);
else;
  info(MessageId:MessageData:MessageFile);
endif;

return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-Proc info;
dcl-pi info;
  MessageId like(tSIXCP_MessageId) const;
  MessageData like(tSIXCP_MessageData) const options(*omit);
  MessageFile like(tSIXCP_MessageFile) const;
end-pi;
dcl-s MsgData like(tSIXCP_MessageData);
dcl-s MessageKey like(tQMHSNDPM_MessageKey);
dcl-ds ErrorCode likeds(tQUSEC);

if %addr(MessageData) <> *null;
  MsgData = MessageData;
endif;

SendProgramMessage(MessageId
                  :MessageFile
                  :MsgData
                  :%len(%trim(MsgData))
                  :cQMHSNDPM_MessageType_Info
                  :cQMHSNDPM_CallStackEntry_PGMBDY
                  :3
                  :MessageKey
                  :ErrorCode
                  );

return;
end-proc;

