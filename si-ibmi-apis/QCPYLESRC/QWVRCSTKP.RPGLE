**FREE
/if defined(qwvrcstkp)
/eof
/endif

/define qwvrcstkp

/include qcpylesrc/qusecp

// -----------------------------------------------------------------------------
dcl-c cQWVRCSTK_Format0100 const('CSTK0100');
dcl-c cQWVRCSTK_Format0200 const('CSTK0200');
dcl-c cQWVRCSTK_Format0300 const('CSTK0300');
dcl-c cQWVRCSTK_JobFormat0100 const('JIDF0100');
dcl-c cQWVRCSTK_JobFormat0200 const('JIDF0200');
// -----------------------------------------------------------------------------
dcl-s tQWVRCSTK_ReceiverVariable char(32767) template;
dcl-s tQWVRCSTK_LengthOfReceiverVariable int(10) template;
dcl-s tQWVRCSTK_FormatOfReceiverInformation char(8) template;
dcl-s tQWVRCSTK_FormatOfJobIdentificationInformation char(8) template;
dcl-s tQWVRCSTK_JobName char(10) template;
dcl-s tQWVRCSTK_UserName char(10) template;
dcl-s tQWVRCSTK_JobNumber char(6) template;
dcl-s tQWVRCSTK_InternalJobIdentifier char(16) template;
dcl-s tQWVRCSTK_Reserved char(2) template;
dcl-s tQWVRCSTK_ThreadIndicator int(10) template;
dcl-s tQWVRCSTK_ThreadIdentifier char(8) template;
dcl-s tQWVRCSTK_BytesReturned int(10) template;
dcl-s tQWVRCSTK_BytesAvailable int(10) template;
dcl-s tQWVRCSTK_NumberOfCallStackEntriesForThread int(10) template;
dcl-s tQWVRCSTK_OffsetToCallStackEntryInformation int(10) template;
dcl-s tQWVRCSTK_NumberOfCallStackEntriesReturned int(10) template;
dcl-s tQWVRCSTK_ReturnedThreadIdentifier char(8) template;
dcl-s tQWVRCSTK_InformationStatus char(1) template;
dcl-ds tQWVRCSTK_JobIdentificationInformation qualified template;
  JobName like(tQWVRCSTK_JobName);
  UserName like(tQWVRCSTK_UserName);
  JobNumber like(tQWVRCSTK_JobNumber);
  InternalJobIdentifier like(tQWVRCSTK_InternalJobIdentifier);
  Reserved like(tQWVRCSTK_Reserved);
  ThreadIndicator like(tQWVRCSTK_ThreadIndicator);
  ThreadIdentifier like(tQWVRCSTK_ThreadIdentifier);
end-ds;
dcl-ds tQWVRCSTK_CSTK0100 qualified template;
  BytesReturned like(tQWVRCSTK_BytesReturned);
  BytesAvailable like(tQWVRCSTK_BytesAvailable);
  NumberOfCallStackEntriesForThread like(tQWVRCSTK_NumberOfCallStackEntriesForThread);
  OffsetToCallStackEntryInformation like(tQWVRCSTK_OffsetToCallStackEntryInformation);
  NumberOfCallStackEntriesReturned like(tQWVRCSTK_NumberOfCallStackEntriesReturned);
  ReturnedThreadIdentifier like(tQWVRCSTK_ReturnedThreadIdentifier);
  InformationStatus like(tQWVRCSTK_InformationStatus);
  Entry char(32000);
end-ds;
dcl-s tQWVRCSTK_DisplacementToStatementIdentifiers int(10) template;
dcl-s tQWVRCSTK_NumberOfStatementIdentifiers int(10) template;
dcl-s tQWVRCSTK_DisplacementToTheProcedureName int(10) template;
dcl-s tQWVRCSTK_LengthOfProcedureName int(10) template;
dcl-s tQWVRCSTK_RequestLevel int(10) template;
dcl-s tQWVRCSTK_ProgramName char(10) template;
dcl-s tQWVRCSTK_ProgramLibraryName char(10) template;
dcl-s tQWVRCSTK_ModuleName char(10) template;
dcl-s tQWVRCSTK_ModuleLibraryName char(10) template;
dcl-s tQWVRCSTK_MIInstructionNumber int(10) template;
dcl-s tQWVRCSTK_LengthOfThisCallStackEntry int(10) template;
dcl-s tQWVRCSTK_ControlBoundary char(1) template;
dcl-s tQWVRCSTK_Reserved2 char(3) template;
dcl-s tQWVRCSTK_ActivationGroupNumber uns(10) template;
dcl-s tQWVRCSTK_ActivationGroupName char(10) template;
dcl-s tQWVRCSTK_Reserved3 char(2) template;
dcl-s tQWVRCSTK_ProgramASPName char(10) template;
dcl-s tQWVRCSTK_ProgramLibraryASPName char(10) template;
dcl-s tQWVRCSTK_ProgramASPNumber int(10) template;
dcl-s tQWVRCSTK_ProgramLibraryASPNumber int(10) template;
dcl-s tQWVRCSTK_ActivationGroupNumberLong uns(20) template;
dcl-s tQWVRCSTK_ProcedureName char(256) template;
dcl-ds tQWVRCSTK_Entry qualified template;
  LengthOfThisCallStackEntry like(tQWVRCSTK_LengthOfThisCallStackEntry);
  DisplacementToStatementIdentifiers like(tQWVRCSTK_DisplacementToStatementIdentifiers);
  NumberOfStatementIdentifiers like(tQWVRCSTK_NumberOfStatementIdentifiers);
  DisplacementToTheProcedureName like(tQWVRCSTK_DisplacementToTheProcedureName);
  LengthOfProcedureName like(tQWVRCSTK_LengthOfProcedureName);
  RequestLevel like(tQWVRCSTK_RequestLevel);
  ProgramName like(tQWVRCSTK_ProgramName);
  ProgramLibraryName like(tQWVRCSTK_ProgramLibraryName);
  MIInstructionNumber like(tQWVRCSTK_MIInstructionNumber);
  ModuleName like(tQWVRCSTK_ModuleName);
  ModuleLibraryName like(tQWVRCSTK_ModuleLibraryName);
  ControlBoundary like(tQWVRCSTK_ControlBoundary);
  Reserved2 like(tQWVRCSTK_Reserved2);
  ActivationGroupNumber like(tQWVRCSTK_ActivationGroupNumber);
  ActivationGroupName like(tQWVRCSTK_ActivationGroupName);
  Reserved3 like(tQWVRCSTK_Reserved3);
  ProgramASPName like(tQWVRCSTK_ProgramASPName);
  ProgramLibraryASPName like(tQWVRCSTK_ProgramLibraryASPName);
  ProgramASPNumber like(tQWVRCSTK_ProgramASPNumber);
  ProgramLibraryASPNumber like(tQWVRCSTK_ProgramLibraryASPNumber);
  ActivationGroupNumberLong like(tQWVRCSTK_ActivationGroupNumberLong);
  Data char(32767);
end-ds;
dcl-ds tQWVRCSTK_STKE0100 qualified template;
  DisplacementToStatementIdentifiers like(tQWVRCSTK_DisplacementToStatementIdentifiers);
  NumberOfStatementIdentifiers like(tQWVRCSTK_NumberOfStatementIdentifiers);
  LengthOfProcedureName like(tQWVRCSTK_LengthOfProcedureName);
  RequestLevel like(tQWVRCSTK_RequestLevel);
  ProgramName like(tQWVRCSTK_ProgramName);
  ProgramLibraryName like(tQWVRCSTK_ProgramLibraryName);
  ModuleName like(tQWVRCSTK_ModuleName);
  ModuleLibraryName like(tQWVRCSTK_ModuleLibraryName);
  MIInstructionNumber like(tQWVRCSTK_MIInstructionNumber);
end-ds;
// -----------------------------------------------------------------------------
dcl-pr RetrieveCallStack extpgm('QWVRCSTK');
  ReceiverVariable like(tQWVRCSTK_ReceiverVariable);
  LengthOfReceiverVariable like(tQWVRCSTK_LengthOfReceiverVariable) const;
  FormatOfReceiverInformationt like(tQWVRCSTK_FormatOfReceiverInformation) const;
  JobIdentificationInformation likeds(tQWVRCSTK_JobIdentificationInformation) const;
  FormatOfJobIdentificationInformation like(tQWVRCSTK_FormatOfJobIdentificationInformation) const;
  ErrorCode like(tQUSEC);
end-pr;
