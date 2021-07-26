**FREE

/if not defined(Rreadlp)
  /define Rreadlp
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

dcl-s tRreadl_Size int(10) template;
dcl-s tRreadl_Opts int(10) template;
dcl-ds tRreadl_Return likeds(tRECIO_RIOFB) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rreadl()  Read the Last Record

dcl-pr Rreadl pointer extproc('_Rreadl');
  fp pointer value;
  buf pointer value;
  size like(tRreadl_Size) value;
  opts like(tRreadl_Opts) value;
end-pr;
