**FREE

//******************************************************************************************
//
//
// Programname    : SIENVVART
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

ctl-opt main(SIENVVART) dftactgrp(*no) actgrp(*new) ;
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

/include qcpylesrc/sienvvarp

//==========================================================================================
// Procedures
//==========================================================================================

dcl-proc SIENVVART;
dcl-pi SIENVVART;
end-pi;
dcl-s erstellt ind;
dcl-s VarValue like(tSIENVVAR_Value);
dcl-s dsp varchar(52);

  // Variable setzen
  SIENVVAR_set('VariableHugo':'Wert für Variable Hugo');

  // Variable lesen
  dsp = SIENVVAR_get('VariableHugo');
  dsply (dsp);

  // Variable mit/in SQL setzen
  exec sql set :erstellt = SIENVVAR_set('VariableHugo2','Wert für Variable Hugo aus SQL');

  // Variable mit/in SQL lesen
  exec sql set :VarValue = SIENVVAR_get('VariableHugo');
  dsp = VarValue;
  dsply (dsp);
  // oder in Select
  exec sql set :VarValue = (Select SIENVVAR_get('VariableHugo')
                              From sysibm/sysdummy1);
  dsp = VarValue;
  dsply (dsp);

  return;
end-proc;


