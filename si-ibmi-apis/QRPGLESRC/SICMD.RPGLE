**FREE

//******************************************************************************************
//
//
// Programname    : SICMD
// Programautor   : Sranko Informatik
// Created on     : 29.03.2021
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See QCLLESRC,makesiiia
//
//==========================================================================================

 ctl-opt NoMain;
 ctl-opt bnddir('$(LIBRARY)/SIIIA');

//==========================================================================================
// Constant
//==========================================================================================


//==========================================================================================
// Templates
//==========================================================================================


//==========================================================================================
// Prototypes
//==========================================================================================

 /define SICMD
 /include qcpylesrc/sicmdp

//==========================================================================================
// Procedures
//==========================================================================================

//------------------------------------------------------------------------------------------

dcl-proc SICMD_new export;
dcl-pi SICMD_new like(tSICMD) extproc(*dclcase);
  Command like(tSICMD_CommandName) const options(*nopass);
  Library like(tSICMD_Library) const options(*nopass);
end-pi;
dcl-ds dsSICMD likeds(tSICMD_Def) inz;

  if %parms() >= %parmnum(Command);
    if %addr(Command) <> *null;
    endif;
  endif;

  if %parms() >= %parmnum(Library);
    if %addr(Library) <> *null;
    endif;
  endif;

  return dsSICMD;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SICMD_getDefinitionAsXML export;
dcl-pi SICMD_getDefinitionAsXML like(tSICMD_XML) extproc(*dclcase);
  SICMD like(tSICMD);
end-pi;
dcl-ds dsSICMD likeds(tSICMD_Def) based(pSICMD);

  pSICMD = %addr(SICMD);

  return *blanks;
end-proc;

