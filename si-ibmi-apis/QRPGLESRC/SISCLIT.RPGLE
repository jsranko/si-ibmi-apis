**FREE
//******************************************************************************************
//
//
// Programname    : SISCLIT
// Programautor   : Sranko Informatik
// Created on     : 05.03.2021
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See QCLLESRC,makesiiia
//
//==========================================================================================

 ctl-opt main(SISCLIT) dftactgrp(*no) actgrp(*new) bnddir('$(LIBRARY)/SIIIA');

//==========================================================================================
// Templates
//==========================================================================================

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

 /include qcpylesrc/sisclip

//==========================================================================================
// Procedures
//==========================================================================================

dcl-proc SISCLIT;
dcl-pi SISCLIT;
end-pi;
dcl-s dspVar varchar(52);
dcl-s indAra int(10) dim(20);
dcl-s stmSelTBL like(tSISCLI_Statement);
dcl-s confWW like(tSISCLI_DBConfig);
dcl-s dbWW like(tSISCLI);
dcl-ds dsFetch extname('SYSFEATURE') qualified;
end-ds;

  confWW = SISCLI_crtConfig('W+W');
  SISCLI_setSysNaming(confWW:*on);
  SISCLI_setCommit(confWW:cSISCLI_NO_COMMIT);

  dbWW = SISCLI_connect(*omit:confWW);

  stmSelTBL = SISCLI_crtStatement(dbWW:'select * from sysfeature':*on);
  if not SISCLI_execute(stmSelTBL);

  endif;
  dow not SISCLI_isEOF(stmSelTBL);
    if not SISCLI_fetch(stmSelTBL:%addr(dsFetch));
      leave;
    endif;

    dspVar = dsFetch.FEATURE_ID;
    dsply (dspVar);

  enddo;

return;

on-exit;
  SISCLI_closeStatement(stmSelTBL);
  SISCLI_disconnect(dbWW);
end-proc;
