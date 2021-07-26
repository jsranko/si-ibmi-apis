**FREE

//******************************************************************************************
//
//
// Programname    : SISRVPGM
// Programautor   : Sranko Informatik
// Created on     : 05.05.2020
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See makefile
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

/define SISRVPGM
/include qcpylesrc/sisrvpgmp

/include qcpylesrc/sixcpp
/include qcpylesrc/sijip

//==========================================================================================
// Procedures
//==========================================================================================

//------------------------------------------------------------------------------------------

dcl-proc SISRVPGM_ export;
dcl-pi SISRVPGM_ like(tSISRVPGM) extproc(*dclcase);
  ServiceProgram like(tSISRVPGM_ServiceProgram) const;
  Library like(tSISRVPGM_Library) const;
end-pi;
dcl-ds SISRVPGM likeds(tSISRVPGM_Def);
dcl-ds ErrorCode likeds(tQUSEC);

SISRVPGM.ServiceProgram = ServiceProgram;
SISRVPGM.Library = Library;
SISRVPGM.SymbolicObjectType = cSISRVPGM_ObjectType;

ConvertType(cQLICVTTP_TO_HEX
           :SISRVPGM.SymbolicObjectType
           :SISRVPGM.HexadecimalObjectType
           :ErrorCode);

SISRVPGM.SystemPointer = ResolveSystemPointer(SISRVPGM.HexadecimalObjectType
                                             :ServiceProgram
                                             :Library
                                             :cRSLVSP_AUTH_NONE
                                             );

return SISRVPGM;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISRVPGM_load export;
dcl-pi SISRVPGM_load ind extproc(*dclcase);
  SISRVPGM like(tSISRVPGM);
end-pi;
dcl-ds dsSISRVPGM likeds(tSISRVPGM_Def) based(pSISRVPGM);
dcl-ds ErrorCode likeds(tQUSEC);

pSISRVPGM = %addr(SISRVPGM);

ActivateBoundProgram(dsSISRVPGM.SystemPointer
                    :dsSISRVPGM.ActivationMark
                    :dsSISRVPGM.ActivationInformation
                    :%size(dsSISRVPGM.ActivationInformation)
                    :ErrorCode
                    );
if ErrorCode.ExceptionId <> *blanks;
  SIXCP_throwWithMessageId('MCH4422':%trim(dsSISRVPGM.ServiceProgram):getCaller());
endif;

return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISRVPGM_getProcedurePointerByName export;
dcl-pi SISRVPGM_getProcedurePointerByName like(tSISRVPGM_ProcedurePointer) extproc(*dclcase);
  SISRVPGM like(tSISRVPGM);
  Procedure like(tSISRVPGM_Procedure) const options(*string);
end-pi;
dcl-ds dsSISRVPGM likeds(tSISRVPGM_Def) based(pSISRVPGM);
dcl-s ProcedurePointer like(tSISRVPGM_ProcedurePointer);
dcl-s TypeOfExportItem like(tSISRVPGM_TypeOfExportItem);
dcl-ds ErrorCode likeds(tQUSEC);

pSISRVPGM = %addr(SISRVPGM);

GetExport(dsSISRVPGM.ActivationMark
         :cQLEAWI_Use_export_name
         :%len(%str(Procedure))
         :%str(Procedure)
         :ProcedurePointer
         :TypeOfExportItem
         :ErrorCode
         );
if ErrorCode.ExceptionId <> *blanks;
  SIXCP_throwWithMessageId('CPFAF19':%str(Procedure):'QCPFMSG':getCaller());
endif;

if TypeOfExportItem <> cQLEAWI_Export_is_a_procedure
or TypeOfExportItem = cQLEAWI_Export_was_not_found;
  return *null;
endif;

return ProcedurePointer;
end-proc;

// -----------------------------------------------------------------------------
// getCaller
// -----------------------------------------------------------------------------

dcl-proc getCaller;
dcl-pi getCaller like(tSIXCP_CallStackEntryQualification);
end-pi;
dcl-s CurrentJob like(tSIJI);
dcl-ds Caller likeds(tSIJI_CallStackEntry);
dcl-s output like(tSIXCP_CallStackEntryQualification);

  CurrentJob = SIJI_new('*');
  Caller = SIJI_getCallStackEntryForCaller(CurrentJob);
  if Caller.ModuleName = *blanks;
    Caller.ModuleName = '*NONE';
  endif;
  output = Caller.ModuleName + Caller.ProgramName;

return output;
end-proc;
