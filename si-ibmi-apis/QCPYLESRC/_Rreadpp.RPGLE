**FREE

/if not defined(Rreadpp)
  /define Rreadpp
/else
  /eof
/endif

/include qcpylesrc/reciop

//==========================================================================================
// Constants
//==========================================================================================


//==========================================================================================
// Templates
//==========================================================================================

dcl-s tRreadp_Size int(10) template;
dcl-s tRreadp_Opts int(10) template;
dcl-ds tRreadp_Return likeds(tRECIO_RIOFB) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rreadp()  Read the Previous Record

dcl-pr Rreadp pointer extproc('_Rreadp');
  fp pointer value;
  buf pointer value;
  size like(tRreadp_Size) value;
  opts like(tRreadp_Opts) value;
end-pr;
