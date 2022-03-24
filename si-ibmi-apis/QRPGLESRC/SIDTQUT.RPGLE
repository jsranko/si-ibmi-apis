**FREE
//******************************************************************************************
//
//
// Programname    : SIDTQUT
// Programautor   : Sranko Informatik
// Created on     : 24.03.2022
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See QCLLESRC,makesiiia
//
//==========================================================================================

ctl-opt main(SIDTQUT) dftactgrp(*no) actgrp(*new) ;
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

/include qcpylesrc/sidtqp
/include qcpylesrc/sijlp
/include qcpylesrc/systemp

//==========================================================================================
// Procedures
//==========================================================================================

dcl-proc SIDTQUT;
dcl-pi SIDTQUT;
end-pi;
dcl-s Name like(tSIDTQ_Name) inz('SIDTQUT');
dcl-s Library like(tSIDTQ_Library) inz('QTEMP');
dcl-s cmd varchar(512);
dcl-s Data like(tQSNDDTAQ_Data);
dcl-s dtaqObj like(tSIDTQ);

  cmd = 'CRTDTAQ DTAQ(' + Library + '/' + Name + ') MAXLEN(64512)';
  if system(cmd) <> cSystem_Return_Succesful;
     dsply ('DTAQ nicht erstellt.');
     return;
  endif;

  dtaqObj = SIDTQ_new(Name:Library);

  if not SIDTQ_write(dtaqObj:'Data');
  endif;

  Data = SIDTQ_read(dtaqObj);

  SIDTQ_close(dtaqObj);

return;
on-exit;
  cmd = 'DLTDTAQ DTAQ(' + Library + '/' + Name + ')';
  system(cmd);
end-proc;

//------------------------------------------------------------------------------------------


