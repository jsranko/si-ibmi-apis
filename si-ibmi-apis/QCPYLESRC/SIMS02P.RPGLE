**FREE

/if not defined(SIMS02P)
  /define SIMS02P
/else
  /eof
/endif

/include qcpylesrc/sirouterp

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSIMS02_Payload like(tSIROUTER_Payload) template;

//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr getJson extproc(*dclcase);
  PayloadIn like(tSIMS02_Payload) options(*varsize);
  PayloadOut like(tSIMS02_Payload) options(*varsize);
end-pr;
