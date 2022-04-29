**FREE

//******************************************************************************************
//
//
// Programname    : SIODUT
// Programautor   : Sranko Informatik
// Created on     : 02.09.2020
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See makeFile
//
//==========================================================================================

ctl-opt main(SIODUT) dftactgrp(*no) actgrp(*new) ;
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

/include qcpylesrc/siodp
/include qcpylesrc/siobjtypp

//==========================================================================================
// Procedures
//==========================================================================================

dcl-proc SIODUT;
dcl-pi SIODUT;
end-pi;
dcl-s ObjectDesc like(tSIOD);

  ObjectDesc = SIOD_new('SIIIA':'SIODUT':cOBJECTTYPE_Program);
  dsply SIOD_getObjectType(ObjectDesc);
  dsply SIOD_getCreationDateAndTime(ObjectDesc);
  dsply SIOD_getReturnLibrary(ObjectDesc);
  dsply SIOD_getObjectType(ObjectDesc);
  dsply SIOD_exist(ObjectDesc);
  dsply SIOD_getTextDescription(ObjectDesc);
  SIOD_close(ObjectDesc);
  return;
end-proc;


