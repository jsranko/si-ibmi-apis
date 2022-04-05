**FREE

//******************************************************************************************
//
//
// Programname    : SIENVVAR
// Programautor   : Sranko Informatik
// Created on     : 04.04.2019
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See QCLLESRC,makesiiia
//
//==========================================================================================

ctl-opt NoMain;

/include qcpylesrc/sictlopt

//==========================================================================================
// Templates
//==========================================================================================

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

/define SIENVVAR
/include qcpylesrc/sienvvarp
/include qcpylesrc/getenvp
/include qcpylesrc/putenvp

//==========================================================================================
// Procedures
//==========================================================================================

//------------------------------------------------------------------------------------------

dcl-proc SIENVVAR_get export;
dcl-pi SIENVVAR_get like(tSIENVVAR_Value) extproc(*dclcase);
  VarName like(tSIENVVAR_VarName) const;
end-pi;
dcl-s ptr like(tGETENV_Return);

  ptr = getenv(VarName);
  if ptr <> *null;
    return %str(ptr);
  endif;

  return *blanks;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIENVVAR_set export;
dcl-pi SIENVVAR_set ind extproc(*dclcase);
  VarName like(tSIENVVAR_VarName) const;
  VarValue like(tSIENVVAR_Value) const;
end-pi;
dcl-s envvar like(tSIENVVAR_Value);

  envvar = VarName + '=' + VarValue;

  if putenv(envvar) <> cPUTENV_Successful ;
    return *off;
  endif;

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIENVVAR_exist export;
dcl-pi SIENVVAR_exist ind extproc(*dclcase);
  VarName like(tSIENVVAR_VarName) const;
end-pi;
dcl-s ptr like(tGETENV_Return);

  ptr = getenv(VarName);
  if ptr <> *null;
    return *on;
  endif;

  return *off;
end-proc;

