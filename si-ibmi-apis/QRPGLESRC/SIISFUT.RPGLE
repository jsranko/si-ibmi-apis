**FREE

//******************************************************************************************
//
//
// Programname    : SIISFUT
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

ctl-opt main(siisfut) dftactgrp(*no) actgrp(*new) bnddir('$(LIBRARY)/SIIIA');

//==========================================================================================
// Templates
//==========================================================================================

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

/include qcpylesrc/siisfp
/include qcpylesrc/siimfp
/include qcpylesrc/siiofp
/include qcpylesrc/sinlp

//==========================================================================================
// Procedures
//==========================================================================================

dcl-proc siisfut;
dcl-pi siisfut;
end-pi;
dcl-s SIISF like(tSIISF);
dcl-s FileGrand like(tSIIMF);
dcl-s FileMode like(tSIIOF);
dcl-s CodePage like(tSINL);
dcl-s File like(tSIISF_Name);

  FileGrand = SIIMF_new();
  SIIMF_setAllForOwner(FileGrand);

  FileMode = SIIOF_new();
  SIIOF_createIfNotExist(FileMode);
  SIIOF_writingOnly(FileMode);
  SIIOF_convertTextToCodePage(FileMode);
  SIIOF_openInTextMode(FileMode);

  CodePage = SINL_forGerman();
  File = './SIISFUT_' + %char(%timestamp()) + '.txt';
  SIISF = SIISF_create(File
                      :CodePage
                      :FileMode
                      :FileGrand
                      );
  SIISF_close(SIISF);

  FileMode = SIIOF_new();
  SIIOF_openInTextMode(FileMode);
  SIIOF_writingOnly(FileMode);
  SIISF_open(SIISF:FileMode);
  SIISF_writeText(SIISF:'Hallo Filip');
  SIISF_close(SIISF);
  return;
end-proc;

