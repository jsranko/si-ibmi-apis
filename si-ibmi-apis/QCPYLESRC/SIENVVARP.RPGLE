**FREE

/if not defined(SIENVVARP)
  /define SIENVVARP
/else
  /eof
/endif


//==========================================================================================
// Constant
//==========================================================================================

dcl-c cSIENVVAR_QCPFMSG const('QCPFMSG   QSYS');

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSIENVVAR_VarName varchar(128) template;
dcl-s tSIENVVAR_Value varchar(1024) template;

/if defined(SIENVVAR)
  /eof
/endif

//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr SIENVVAR_get like(tSIENVVAR_Value) extproc(*dclcase);
  VarName like(tSIENVVAR_VarName) const;
end-pr;

dcl-pr SIENVVAR_set ind extproc(*dclcase);
  VarName like(tSIENVVAR_VarName) const;
  VarValue like(tSIENVVAR_Value) const;
end-pr;
