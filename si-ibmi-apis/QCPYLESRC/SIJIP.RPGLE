**FREE

/if not defined(SIJIP)
  /define SIJIP
/else
  /eof
/endif

/include qcpylesrc/qusrjobip

/include qcpylesrc/siitrp
/include qcpylesrc/qwvrcstkp

//==========================================================================================
// Constants
//==========================================================================================

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSIJI like(tSIJI_Def) template;
dcl-s tSIJI_List like(tSIITR) template;
dcl-s tSIJI_Jobname char(10) template;
dcl-s tSIJI_Username char(10) template;
dcl-s tSIJI_Jobnumber char(6) template;
dcl-ds tSIJI_QualifiedJobName len(28) template;
   Jobname like(tSIJI_Jobname);
   Username like(tSIJI_Username);
   Jobnumber like(tSIJI_Jobnumber);
end-ds;
dcl-s tSIJI_TemporaryStorageUsed uns(10) template;
dcl-s tSIJI_Program char(10) template;
dcl-ds tSIJI_CallStackEntry qualified template;
  RequestLevel like(tQWVRCSTK_RequestLevel);
  ProgramName like(tQWVRCSTK_ProgramName);
  ProgramLibraryName like(tQWVRCSTK_ProgramLibraryName);
  MIInstructionNumber like(tQWVRCSTK_MIInstructionNumber);
  ModuleName like(tQWVRCSTK_ModuleName);
  ModuleLibraryName like(tQWVRCSTK_ModuleLibraryName);
  ControlBoundary like(tQWVRCSTK_ControlBoundary);
  ActivationGroupNumber like(tQWVRCSTK_ActivationGroupNumber);
  ActivationGroupName like(tQWVRCSTK_ActivationGroupName);
  ProgramASPName like(tQWVRCSTK_ProgramASPName);
  ProgramLibraryASPName like(tQWVRCSTK_ProgramLibraryASPName);
  ProgramASPNumber like(tQWVRCSTK_ProgramASPNumber);
  ProgramLibraryASPNumber like(tQWVRCSTK_ProgramLibraryASPNumber);
  ActivationGroupNumberLong like(tQWVRCSTK_ActivationGroupNumberLong);
  ProcedureName like(tQWVRCSTK_ProcedureName);
end-ds;
dcl-s tSIJI_CodedCharacterSetID like(tQUSRJOBI_CodedCharacterSetID) template;

dcl-ds tSIJI_Def qualified;
  QualifiedJobName likeds(tSIJI_QualifiedJobName);
  Data0150 likeds(tQUSRJOBI_JOBI0150);    // DS with everythink
  Data0400 likeds(tQUSRJOBI_JOBI0400);
end-ds;

/if defined(SIJI)
  /eof
/endif

//==========================================================================================
// Prototypes
//==========================================================================================
//
dcl-pr SIJI_new like(tSIJI) extproc(*dclcase);
   Jobname like(tSIJI_Jobname) options(*varsize:*omit) const;
   Username like(tSIJI_Username) options(*varsize:*nopass:*omit) const;
   Jobnumber like(tSIJI_Jobnumber) options(*nopass:*omit) const;
   QualifiedJobName like(tSIJI_QualifiedJobName) options(*varsize:*nopass) const;
end-pr;

dcl-pr SIJI_existProgramInCallStack ind;
  Program like(tSIJI_Program) const;
end-pr;

dcl-pr SIJI_listCallStackEntrys like(tSIJI_List) extproc(*dclcase);
  SIJI like(tSIJI);
end-pr;

dcl-pr SIJI_getCallStackEntryForCaller like(tSIJI_CallStackEntry) extproc(*dclcase);
  SIJI like(tSIJI);
end-pr;

dcl-pr SIJI_getQualifiedJobName like(tSIJI_QualifiedJobName) extproc(*dclcase);
  SIJI like(tSIJI);
end-pr;

dcl-pr SIJI_close extproc(*dclcase);
  SIJI like(tSIJI);
end-pr;

dcl-pr SIJI_getCodedCharacterSetID like(tSIJI_CodedCharacterSetID) extproc(*dclcase);
  SIJI like(tSIJI);
end-pr;

dcl-pr SIJI_getUserName like(tSIJI_UserName) extproc(*dclcase);
  SIJI like(tSIJI);
end-pr;
