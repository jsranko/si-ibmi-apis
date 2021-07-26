**FREE
/if not defined(QMHRTVMP)
  /define QMHRTVMP
/else
  /eof
/endif

/include qcpylesrc/qusecp

//==========================================================================================
//             Templates
//==========================================================================================

dcl-s tQMHRTVM_MessageInformation varchar(3000) template;
dcl-s tQMHRTVM_LengthOfMessageInformation int(10) template;
dcl-s tQMHRTVM_FormatName char(8) template;
dcl-s tQMHRTVM_MessageIdentifier char(7) template;
dcl-s tQMHRTVM_QualifiedMessageFileName char(20) template;
dcl-s tQMHRTVM_ReplacementData char(3000) template;
dcl-s tQMHRTVM_LengthOfReplacementData int(10) template;
dcl-s tQMHRTVM_ReplaceSubstitutionValues char(10) template;
dcl-s tQMHRTVM_ReturnFormatControlCharacters char(10) template;
dcl-s tQMHRTVM_RetrieveOption char(10) template;
dcl-s tQMHRTVM_CCSIDToConvertTo int(10) template;
dcl-s tQMHRTVM_CCSIDOfreplacementData int(10) template;
dcl-s tQMHRTVM_BytesReturned int(10) template;
dcl-s tQMHRTVM_BytesAvailable int(10) template;
dcl-s tQMHRTVM_LengthOfMessageReturned int(10) template;
dcl-s tQMHRTVM_LengthOfMessageAvailable int(10) template;
dcl-s tQMHRTVM_LengthOfMessageHelpReturned int(10) template;
dcl-s tQMHRTVM_LengthOfMessageHelpAvailable int(10) template;
dcl-s tQMHRTVM_Message char(3000) template;
dcl-s tQMHRTVM_MessageHelp char(3000) template;

dcl-ds tQMHRTVM_RTVM0100 qualified template;
  BytesReturned like(tQMHRTVM_BytesReturned);
  BytesAvailable like(tQMHRTVM_BytesAvailable);
  LengthOfMessageReturned like(tQMHRTVM_LengthOfMessageReturned);
  LengthOfMessageAvailable like(tQMHRTVM_LengthOfMessageAvailable);
  LengthOfMessageHelpReturned like(tQMHRTVM_LengthOfMessageHelpReturned);
  LengthOfMessageHelpAvailable like(tQMHRTVM_LengthOfMessageHelpAvailable);
  Message like(tQMHRTVM_Message);
end-ds;

//==========================================================================================
//             Prototypes
//==========================================================================================

dcl-pr RetrieveMessage extpgm('QMHRTVM');
   MessageInformation like(tQMHRTVM_MessageInformation) options(*varsize);
   LengthOfMessageInformation like(tQMHRTVM_LengthOfMessageInformation) const;
   FormatName like(tQMHRTVM_FormatName) const;
   MessageIdentifier like(tQMHRTVM_MessageIdentifier) const;
   QualifiedMessageFileName like(tQMHRTVM_QualifiedMessageFileName) const;
   ReplacementData like(tQMHRTVM_ReplacementData) const;
   LengthOfReplacementData like(tQMHRTVM_LengthOfReplacementData) const;
   ReplaceSubstitutionValues like(tQMHRTVM_ReplaceSubstitutionValues) const;
   ReturnFormatControlCharacters like(tQMHRTVM_ReturnFormatControlCharacters) const;
   ErrorCode likeds(tQUSEC);
   RetrieveOption like(tQMHRTVM_RetrieveOption) options(*nopass);
   CCSIDToConvertTo like(tQMHRTVM_CCSIDToConvertTo) options(*nopass);
   CCSIDOfreplacementData like(tQMHRTVM_CCSIDOfreplacementData) options(*nopass);
end-pr;
