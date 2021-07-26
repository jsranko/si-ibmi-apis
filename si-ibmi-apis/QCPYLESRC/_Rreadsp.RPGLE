**FREE

/if not defined(Rreadsp)
  /define Rreadsp
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

dcl-s tRreads_Size int(10) template;
dcl-s tRreads_Opts int(10) template;
dcl-ds tRreads_Return likeds(tRECIO_RIOFB) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rreads()  Read the Same Record

dcl-pr Rreads pointer extproc('_Rreads');
  fp pointer value;
  buf pointer value;
  size like(tRreads_Size) value;
  opts like(tRreads_Opts) value;
end-pr;
