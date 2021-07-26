**FREE

//******************************************************************************************
//
//
// Programname    : SIREUT
// Programautor   : Sranko Informatik, Juraj Sranko
// Created on     : 07.04.2020
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See makefile
//
//==========================================================================================

ctl-opt main(SIREUT) dftactgrp(*no) actgrp(*new);

/include qcpylesrc/sictlopt
/include qcpylesrc/sijlp

//==========================================================================================
// Templates
//==========================================================================================

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

/include qcpylesrc/sirep

//==========================================================================================
// Procedures
//==========================================================================================

dcl-proc SIREUT;
dcl-pi SIREUT;
end-pi;
dcl-s pattern like(tSIRE_Pattern) inz('[a-zA-Z\s]{3,4}-[0-9]{2}-[0-9]{6}');
dcl-s data like(tSIRE_Data);
dcl-s RegularExpresion like(tSIRE);

  RegularExpresion = SIRE_new(pattern);

  data = 'AAAA-11-000000-xx-a-a';
  if SIRE_match(RegularExpresion:data);
    SIJL_write('%s is for %s valid':data:pattern);
  else;
    SIJL_write('%s is for %s not valid':data:pattern);
  endif;

  data = 'AAAAx11-000000-xx-a-a';
  if SIRE_match(RegularExpresion:data);
    SIJL_write('%s is for %s valid':data:pattern);
  else;
    SIJL_write('%s is for %s not valid':data:pattern);
  endif;

  SIRE_close(RegularExpresion);

  return;
end-proc;


