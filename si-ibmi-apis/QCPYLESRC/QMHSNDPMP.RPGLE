**FREE

/if not defined(QMHSNDPMP)
  /define QMHSNDPMP
/else
  /eof
/endif

/include qcpylesrc/qusecp

//==========================================================================================
//             Konstanten
//==========================================================================================

dcl-c cQMHSNDPM_MessageType_Escape const('*ESCAPE');
dcl-c cQMHSNDPM_MessageType_Status const('*STATUS');
dcl-c cQMHSNDPM_MessageType_Diag   const('*DIAG');
dcl-c cQMHSNDPM_MessageType_Info   const('*INFO');

dcl-c cQMHSNDPM_CallStackEntry_CurrentEntry const('*');
dcl-c cQMHSNDPM_CallStackEntry_PGMBDY const('*PGMBDY');
dcl-c cQMHSNDPM_CallStackEntry_CTLBDY const('*CTLBDY');
dcl-c cQMHSNDPM_CallStackEntry_PGMNAME const('*PGMNAME');
dcl-c cQMHSNDPM_CallStackEntry_EXT const('*EXT');

//==========================================================================================
//             Templates
//==========================================================================================

dcl-s tQMHSNDPM_MessageIdentifier char(7) template;
dcl-s tQMHSNDPM_QualifiedMessageFileName char(20) template;
dcl-s tQMHSNDPM_MessageData char(6000) template;
dcl-s tQMHSNDPM_LengthOfMessageData int(10) template;
dcl-s tQMHSNDPM_MessageType char(10) template;
dcl-s tQMHSNDPM_CallStackEntry char(10) template;
dcl-s tQMHSNDPM_CallStackCounter int(10) template;
dcl-s tQMHSNDPM_MessageKey char(4) template;
dcl-s tQMHSNDPM_LengthOfCallStackEntry int(10) template;
dcl-s tQMHSNDPM_CallStackEntryQualification char(20) template;
dcl-s tQMHSNDPM_DisplayProgramMessagesScreenWaitTime int(10) template;

//==========================================================================================
//             Prototypes
//==========================================================================================

dcl-pr SendProgramMessage extpgm('QMHSNDPM');
   MessageIdentifier like(tQMHSNDPM_MessageIdentifier) const;
   QualifiedMessageFileName like(tQMHSNDPM_QualifiedMessageFileName) const;
   MessageData like(tQMHSNDPM_MessageData) const;
   LengthOfMessageData like(tQMHSNDPM_LengthOfMessageData) const;
   MessageType like(tQMHSNDPM_MessageType) const;
   CallStackEntry like(tQMHSNDPM_CallStackEntry) const;
   CallStackCounter like(tQMHSNDPM_CallStackCounter) const;
   MessageKey like(tQMHSNDPM_MessageKey);
   ErrorCode likeds(tQUSEC);
   LengthOfCallStackEntry like(tQMHSNDPM_LengthOfCallStackEntry) options(*nopass) const;
   CallStackEntryQualification like(tQMHSNDPM_CallStackEntryQualification)  options(*nopass) const;
   DisplayProgramMessagesScreenWaitTime like(tQMHSNDPM_DisplayProgramMessagesScreenWaitTime)  options(*nopass) const;
end-pr;
