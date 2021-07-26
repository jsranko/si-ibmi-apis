**FREE

/if not defined(SICMDP)
  /define  SICMDP
/else
  /eof
/endif

//==========================================================================================
// Constant
//==========================================================================================


//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSICMD like(tSICMD_Def) template;
dcl-s tSICMD_CommandName varchar(10) template;
dcl-s tSICMD_Library varchar(10) template;
dcl-s tSICMD_XML varchar(32765) template;

dcl-ds tSICMD_Def qualified template;
  Command like(tSICMD_CommandName);
  Library like(tSICMD_Library);
end-ds;

/if defined(SICMD)
  /eof
/endif

//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr SICMD_new like(tSICMD) extproc(*dclcase);
  Command like(tSICMD_CommandName) const options(*nopass);
  Library like(tSICMD_Library) const options(*nopass);
end-pr;

dcl-pr SICMD_getDefinitionAsXML like(tSICMD_XML) extproc(*dclcase);
  SICMD like(tSICMD);
end-pr;

