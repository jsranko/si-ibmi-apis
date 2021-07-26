**FREE

//******************************************************************************************
//
//
// Programname    : SIEPCSQ01
// Programautor   : Sranko Informatik, Juraj Sranko
// Created on     : 06.04.2020
//
// Exit-program is necessary to create sqlrpgle programs.
// There is a bug in crtsqlrpgli if you want to enter PPSRCFILE or PPSRCSTMF.
// See SI71483 - SQL-CMPL-OTHER-MSGCPD0042 CRTSQLCI/CRTSQLCPPI ERROR WITH TER
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See gmake makefile
//
//==========================================================================================

 ctl-opt main(SIEPCSQ01) dftactgrp(*no) actgrp(*new);

//==========================================================================================
// Templates
//==========================================================================================

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

/include qcpylesrc/siepcsq01p

/include qcpylesrc/systemp

//==========================================================================================
// Procedures
//==========================================================================================

dcl-proc SIEPCSQ01;
dcl-pi SIEPCSQ01;
  RetrieveCommandExitInformation like(tSIEPCSQ01_RetrieveCommandExitInformation);
end-pi;

  if system('DLTF FILE(QTEMP/QSQLPRE)') <> cSystem_Return_Succesful;
  endif;

  if system('CRTSRCPF FILE(QTEMP/QSQLPRE) RCDLEN(240) TEXT(''Created with si-ibmi-apis, gmake exit-Programs'')') <> cSystem_Return_Succesful;
  endif;

  return;
end-proc;

//------------------------------------------------------------------------------------------
