**FREE

/if not defined(SIREP)
  /define SIREP
/else
  /eof
/endif

/include qcpylesrc/regexhp

//==========================================================================================
// Constants
//==========================================================================================


//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSIRE like(tSIRE_Def) template;
dcl-s tSIRE_Pattern varchar(512) template;
dcl-ds tSIRE_Regex likeds(tRegex) template;
dcl-ds tSIRE_RegexMatch likeds(tRegexMatch) template;
dcl-s tSIRE_ReturnCode int(10) template;
dcl-s tSIRE_Data varchar(1024) template;

dcl-ds tSIRE_Def qualified template;
  Pattern like(tSIRE_Pattern);
  Regex likeds(tSIRE_Regex);
end-ds;

/if defined(SIRE)
  /eof
/endif

//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr SIRE_new like(tSIRE) extproc(*dclcase);
  Pattern like(tSIRE_Pattern) const;
end-pr;

dcl-pr SIRE_match ind extproc(*dclcase);
  SIRE like(tSIRE);
  Data like(tSIRE_Data) const;
end-pr;

dcl-pr SIRE_close extproc(*dclcase);
  SIRE like(tSIRE);
end-pr;

dcl-pr SIRE_like ind extproc(*dclcase);
  Pattern like(tSIRE_Pattern) const;
  Data like(tSIRE_Data) const;
end-pr;
