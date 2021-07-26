**FREE

/if not defined(Rreadfp)
  /define Rreadfp
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

dcl-s tRreadf_Size int(10) template;
dcl-s tRreadf_Opts int(10) template;
dcl-ds tRreadf_Return likeds(tRECIO_RIOFB) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rreadf()  Read the First Record

dcl-pr Rreadf pointer extproc('_Rreadf');
  fp pointer value;
  buf pointer value;
  size like(tRreadf_Size) value;
  opts like(tRreadf_Opts) value;
end-pr;
