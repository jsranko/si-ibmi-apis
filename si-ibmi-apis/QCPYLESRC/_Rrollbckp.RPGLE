**FREE

/if not defined(Rrollbckp)
  /define Rrollbckp
/else
  /eof
/endif

/include qcpylesrc/reciop

//==========================================================================================
// Constants
//==========================================================================================

dcl-c tRrollbck_Successful const(1);
dcl-c tRrollbck_Unsuccessful const(0);

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tRrollbck_Return int(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rrollbck()  Roll Back Commitment Control Changes

dcl-pr Rrollbck like(tRrollbck_Return) extproc('_Rrollbck');
end-pr;
