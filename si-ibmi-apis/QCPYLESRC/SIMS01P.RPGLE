**FREE

/if not defined(SIMS01P)
  /define SIMS01P
/else
  /eof
/endif

/include qcpylesrc/sirouterp


//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSIMS01_Payload like(tSIROUTER_Payload) template;

//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr SIMS01 extpgm('SIMS01');
  PayloadIn like(tSIMS01_Payload) options(*varsize);
  PayloadOut like(tSIMS01_Payload) options(*varsize);
end-pr;
