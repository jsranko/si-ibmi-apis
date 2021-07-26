**FREE
/if defined(qwtchgjbp)
/eof
/endif

/define qwtchgjbp

/include qcpylesrc/qusecp

// -----------------------------------------------------------------------------
dcl-c cQWTCHGJB_Format_JOBC0100 const('JOBC0100');
dcl-c cQWTCHGJB_Format_JOBC0200 const('JOBC0200');
dcl-c cQWTCHGJB_Format_JOBC0300 const('JOBC0300');
dcl-c cQWTCHGJB_Format_JOBC0400 const('JOBC0400');
dcl-c cQWTCHGJB_TypeOfData_Binary const('B');
dcl-c cQWTCHGJB_TypeOfData_Character const('C');
dcl-c cQWTCHGJB_Key_BreakMessageHandling const(201);
dcl-c cQWTCHGJB_Key_CodedCharacterSetID const(302);
dcl-c cQWTCHGJB_Key_CountryOrRegionID const(303);
// -----------------------------------------------------------------------------
dcl-s tQWTCHGJB_CodedCharacterSetID int(10) template;
dcl-s tQWTCHGJB_QualifiedJobName char(26) template;
dcl-s tQWTCHGJB_InternalJobIdentifier char(16) template;
dcl-s tQWTCHGJB_FormatName char(8) template;
dcl-s tQWTCHGJB_JobChangeInformation char(1) template;
dcl-s tQWTCHGJB_LengthOfAttributeInformation int(10) template;
dcl-s tQWTCHGJB_TypeOfData char(1) template;
dcl-s tQWTCHGJB_LengthOfData int(10) template;
dcl-s tQWTCHGJB_Data256 char(256) template;
dcl-s tQWTCHGJB_Data10 char(10) template;
dcl-s tQWTCHGJB_Reserved1 char(1) template;
dcl-s tQWTCHGJB_Reserved2 char(2) template;
dcl-s tQWTCHGJB_Reserved3 char(3) template;
dcl-s tQWTCHGJB_Key int(10) template;
dcl-s tQWTCHGJB_NumberOfVariableLengthRecords int(10) template;
dcl-ds tQWTCHGJB_VariableLengthRecord1 qualified template;
  NumberOfVariableLengthRecords like(tQWTCHGJB_NumberOfVariableLengthRecords);
  LengthOfAttributeInformation like(tQWTCHGJB_LengthOfAttributeInformation);
  Key like(tQWTCHGJB_Key);
  TypeOfData like(tQWTCHGJB_TypeOfData);
  Reserved like(tQWTCHGJB_Reserved3);
  LengthOfData like(tQWTCHGJB_LengthOfData);
  Data like(tQWTCHGJB_Data256);
  Reserved2 like(tQWTCHGJB_Reserved1);
end-ds;
dcl-ds tQWTCHGJB_VariableLengthRecord2 qualified template;
  Key like(tQWTCHGJB_Key);
  Data like(tQWTCHGJB_Data10);
  Reserved2 like(tQWTCHGJB_Reserved2);
end-ds;
// -----------------------------------------------------------------------------
dcl-pr ChangeJob extpgm('QWTCHGJB');
  QualifiedJobName like(tQWTCHGJB_QualifiedJobName) const;
  InternalJobIdentifier like(tQWTCHGJB_InternalJobIdentifier) const;
  FormatName like(tQWTCHGJB_FormatName) const;
  JobChangeInformation like(tQWTCHGJB_JobChangeInformation) const;
  ErrorCode like(tQUSEC);
end-pr;
