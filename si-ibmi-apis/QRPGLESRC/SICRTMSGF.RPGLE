**FREE

//******************************************************************************************
//
//
// Programname    : SICRTMSGF
// Programautor   : Sranko Informatik, Juraj Sranko
// Created on     : 01.20.2020
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// gmake SICRTMSGF.pgm
//
//==========================================================================================

 ctl-opt main(SICRTMSGF) dftactgrp(*no) actgrp(*new);

 /include qcpylesrc/sictlopt

//==========================================================================================
// Templates
//==========================================================================================



//==========================================================================================
// Prototypes
//==========================================================================================

/include qcpylesrc/sicrtmsgfp

/include qcpylesrc/sixcpp
/include qcpylesrc/siisfp
/include qcpylesrc/simfp

//==========================================================================================
// Procedures
//==========================================================================================

dcl-proc SICRTMSGF;
dcl-pi SICRTMSGF;
  Streamfile like(tSICRTMSGF_Streamfile) const;
end-pi;
dcl-s StmFile like(tSIISF);

  StmFile = SIISF_newByFileName(%trim(Streamfile));

  if not SIISF_exist(StmFile);
    SIXCP_throwWithMessage('Streamfile ' + %trim(Streamfile) + ' not found');
  endif;
  SIISF_close(StmFile);



  return;
end-proc;



//------------------------------------------------------------------------------------------
