**FREE

/if not defined(GETENVP)
  /define GETENVP
/else
  /eof
/endif

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tGETENV_Return pointer template;

//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr getenv like(tGETENV_Return) extproc(*dclcase);
  Name pointer options(*string) value;
end-pr;
