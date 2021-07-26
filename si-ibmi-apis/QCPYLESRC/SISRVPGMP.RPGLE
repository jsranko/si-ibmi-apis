**FREE

/if not defined(SISRVPGMP)
/define SISRVPGMP
/else
/eof
/endif

/include qcpylesrc/qleawip
/include qcpylesrc/qlicvttpp
/include qcpylesrc/rslvspp

//==========================================================================================
// Constants
//==========================================================================================
//
dcl-c cSISRVPGM_ObjectType const('*SRVPGM');

//==========================================================================================
// Templates
//==========================================================================================

 dcl-s tSISRVPGM like(tSISRVPGM_Def) template;
 dcl-s tSISRVPGM_ServiceProgram varchar(10) template;
 dcl-s tSISRVPGM_Library varchar(10) template;
 dcl-s tSISRVPGM_SymbolicObjectType like(tQLICVTTP_SymbolicObjectType) template;
 dcl-s tSISRVPGM_HexadecimalObjectType like(tQLICVTTP_HexadecimalObjectType) template;
 dcl-s tSISRVPGM_ActivationMark int(10) template;
 dcl-ds tSISRVPGM_ActivationInformation likeds(tQLEAWI_ActivationInformation) template;
 dcl-s tSISRVPGM_ProcedurePointer pointer(*proc) template;
 dcl-s tSISRVPGM_SystemPointer like(tRSLVSP_SystemPointer) template;
 dcl-s tSISRVPGM_Procedure pointer template;
 dcl-s tSISRVPGM_TypeOfExportItem like(tQLEAWI_TypeOfExportItem) template;

 dcl-ds tSISRVPGM_Def qualified;
   ServiceProgram like(tSISRVPGM_ServiceProgram);
   Library like(tSISRVPGM_Library);
   SymbolicObjectType like(tSISRVPGM_SymbolicObjectType);
   HexadecimalObjectType like(tSISRVPGM_HexadecimalObjectType);
   SystemPointer like(tSISRVPGM_SystemPointer);
   ActivationMark like(tSISRVPGM_ActivationMark);
   ActivationInformation likeds(tSISRVPGM_ActivationInformation);
 end-ds;

 /if defined(SISRVPGM)
 /eof
 /endif

//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr SISRVPGM_ like(tSISRVPGM) extproc(*dclcase);
  ServiceProgram like(tSISRVPGM_ServiceProgram) const;
  Library like(tSISRVPGM_Library) const;
end-pr;

dcl-pr SISRVPGM_load ind extproc(*dclcase);
  SISRVPGM like(tSISRVPGM);
end-pr;

dcl-pr SISRVPGM_getProcedurePointerByName like(tSISRVPGM_ProcedurePointer) extproc(*dclcase);
  SISRVPGM like(tSISRVPGM);
  Procedure like(tSISRVPGM_Procedure) const options(*string);
end-pr;


