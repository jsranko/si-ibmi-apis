**FREE

//******************************************************************************************
//
//
// Programname    : SIJIUT
// Programautor   : Sranko Informatik
// Created on     : 07.02.2019
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See QCLLESRC,makesiiia
//
//==========================================================================================

 ctl-opt main(SIJIUT) dftactgrp(*no) actgrp(*new);
 ctl-opt bnddir('$(LIBRARY)/SIIIA');

//==========================================================================================
// Templates
//==========================================================================================

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

/include qcpylesrc/sijip

//==========================================================================================
// Procedures
//==========================================================================================

dcl-proc SIJIUT;
dcl-pi SIJIUT;
end-pi;
dcl-s Job like(tSIJI);
dcl-s QualifiedJobName like(tSIJI_QualifiedJobName);

  Job = SIJI_new('*');
  QualifiedJobName = SIJI_getQualifiedJobName(Job);
  SIJI_close(Job);

  Job = SIJI_new(*omit:*omit:*omit:'021712/CECUSER/QPADEV0004');
  QualifiedJobName = SIJI_getQualifiedJobName(Job);
  SIJI_close(Job);

  Job = SIJI_new(*omit:*omit:*omit);
  QualifiedJobName = SIJI_getQualifiedJobName(Job);
  SIJI_close(Job);

  return;
end-proc;
