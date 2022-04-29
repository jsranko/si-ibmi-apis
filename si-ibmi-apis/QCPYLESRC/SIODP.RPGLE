**FREE

/if not defined(SIODP)
  /define SIODP
/else
  /eof
/endif


/include qcpylesrc/qusrobjdp

//==========================================================================================
// Constant
//==========================================================================================


//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSIOD like(tSIOD_Def) template;
dcl-s tSIOD_Library char(10) template;
dcl-s tSIOD_Object char(10) template;
dcl-s tSIOD_Type char(10) template;
dcl-s tSIOD_FormatNubmer uns(5) template;
dcl-s tSIOD_ObjectType varchar(10) template;
dcl-s tSIOD_ReturnLibrary varchar(10) template;
dcl-s tSIOD_TextDescription like(tQUSROBJD_TextDescription) template;

dcl-s tSIOD_CreationDateAndTime char(13) template;

dcl-ds tSIOD_Def qualified;
  Data likeds(tQUSROBJD_OBJD0400);
  Library like(tSIOD_Library);
  Object like(tSIOD_Object);
  Type like(tSIOD_Type);
  lastFormat like(tSIOD_FormatNubmer);
  exist ind;
end-ds;

/if defined(SIOD)
  /eof
/endif

//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr SIOD_new like(tSIOD) extproc(*dclcase);
  Library like(tSIOD_Library) const;
  Object like(tSIOD_Object) const;
  Type like(tSIOD_Type) const;
end-pr;

dcl-pr SIOD_getCreationDateAndTime like(tSIOD_CreationDateAndTime) extproc(*dclcase);
  SIOD like(tSIOD);
end-pr;

dcl-pr SIOD_exist ind extproc(*dclcase);
  SIOD like(tSIOD);
end-pr;

dcl-pr SIOD_getReturnLibrary like(tSIOD_ReturnLibrary) extproc(*dclcase);
  SIOD like(tSIOD);
end-pr;

dcl-pr SIOD_getObjectType like(tSIOD_ObjectType) extproc(*dclcase);
  SIOD like(tSIOD);
end-pr;

dcl-pr SIOD_close extproc(*dclcase);
  SIOD like(tSIOD);
end-pr;

dcl-pr SIOD_getTextDescription like(tSIOD_TextDescription) extproc(*dclcase);
  SIOD like(tSIOD);
end-pr;
