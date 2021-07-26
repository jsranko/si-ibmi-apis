**FREE

//******************************************************************************************
//
//
// Programname    : SIRE
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

ctl-opt NoMain;

/include qcpylesrc/sictlopt

//==========================================================================================
// Constants
//==========================================================================================

//==========================================================================================
// Templates
//==========================================================================================

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

/define SIRE
/include qcpylesrc/sirep

/include qcpylesrc/sixcpp

//==========================================================================================
// Procedures
//==========================================================================================

//------------------------------------------------------------------------------------------
// SIRE_new
//------------------------------------------------------------------------------------------

dcl-proc SIRE_new export;
dcl-pi SIRE_new like(tSIRE) extproc(*dclcase);
  Pattern like(tSIRE_Pattern) const;
end-pi;
dcl-s rc like(tSIRE_ReturnCode);
dcl-ds dsSIRE likeds(tSIRE_Def) inz;

  dsSIRE.Pattern = Pattern;

  rc = regcomp(dsSIRE.Regex:dsSIRE.Pattern:REG_EXTENDED);
  if rc <> *zeros;
    SIXCP_throwWithMessage('regcomp() ended with error.');
  endif;

  return dsSIRE;

end-proc;

//------------------------------------------------------------------------------------------
// SIRE_match
//------------------------------------------------------------------------------------------

dcl-proc SIRE_match export;
dcl-pi SIRE_match ind extproc(*dclcase);
  SIRE like(tSIRE);
  Data like(tSIRE_Data) const;
end-pi;
dcl-s rc like(tSIRE_ReturnCode);
dcl-ds Match likeds(tSIRE_RegexMatch);
dcl-s MatchError char(512);
dcl-ds dsSIRE likeds(tSIRE_Def) based(pSIRE);

  pSIRE = %addr(SIRE);

  rc = regexec(dsSIRE.Regex:Data:dsSIRE.Regex.re_nsub:%addr(Match) :0) ;
  if rc <> *zeros;
    rc = regerror(rc:dsSIRE.Regex:%addr(MatchError):%size(MatchError));
    SIXCP_throwWithMessage(%trim(MatchError));
    return *off;
  endif;

  return *on;

end-proc;

//------------------------------------------------------------------------------------------
// SIRE_close
//------------------------------------------------------------------------------------------

dcl-proc SIRE_close export;
dcl-pi SIRE_close extproc(*dclcase);
  SIRE like(tSIRE);
end-pi;
dcl-ds dsSIRE likeds(tSIRE_Def) based(pSIRE);

  pSIRE = %addr(SIRE);

  regfree(dsSIRE.Regex) ;
  clear dsSIRE;

  return;

end-proc;

//------------------------------------------------------------------------------------------
// SIRE_like
//------------------------------------------------------------------------------------------

dcl-proc SIRE_like export;
dcl-pi SIRE_like ind extproc(*dclcase);
  Pattern like(tSIRE_Pattern) const;
  Data like(tSIRE_Data) const;
end-pi;
dcl-s RegularExpresion like(tSIRE);
dcl-s output ind inz(*on);

  RegularExpresion = SIRE_new(Pattern);
  if SIRE_match(RegularExpresion:Data);
    output = *on;
  else;
    output = *off;
  endif;

  SIRE_close(RegularExpresion);

  return output;

end-proc;
