**FREE

//******************************************************************************************
//
//
// Programname    : SIQSHLOGUT
// Programautor   : Sranko Informatik
// Created on     : 01.03.2019
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See QCLLESRC,makesiiia
//
//==========================================================================================

ctl-opt main(SIQSHLOGUT) dftactgrp(*no) actgrp(*new) bnddir('$(LIBRARY)/SIIIA');

//==========================================================================================
// Templates
//==========================================================================================

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

/include qcpylesrc/siqshp
/include qcpylesrc/siqshlogp

//==========================================================================================
// Procedures
//==========================================================================================

dcl-proc SIQSHLOGUT;
dcl-pi SIQSHLOGUT;
end-pi;
dcl-s QShell like(tSIQSH);
dcl-s QShellLog like(tSIQSHLOG);

  QShellLog = SIQSHLOG_create();
  QShell = SIQSH_init('siqshlogut.stdin'
                     :'siqshlogut.stdout'
                     :'siqshlogut.stderr');

  SIQSH_runCommand(QShell:'ls -la');

  SIQSHLOG_write(QShellLog:QShell);

  SIQSH_clearStdFiles(QShell);

  SIQSH_runCommand(QShell:'curl --xxxxxx');

  SIQSHLOG_write(QShellLog:QShell);

  SIQSH_close(QShell);
  SIQSH_deleteStdInFile(QShell);
  SIQSH_deleteStdOutFile(QShell);
  SIQSH_deleteStdErrFile(QShell);
  SIQSHLOG_delete(QShellLog);

  return;
end-proc;


