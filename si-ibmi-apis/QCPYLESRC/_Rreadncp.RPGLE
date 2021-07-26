**FREE

/if not defined(Rreadncp)
  /define Rreadncp
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

dcl-s tRreadnc_Size int(10) template;
dcl-s tRreadnc_Opts int(10) template;
dcl-ds tRreadnc_Return likeds(tRECIO_RIOFB) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rreadnc()  Read the Next Changed Record in a Subfile

dcl-pr Rreadnc pointer extproc('_Rreadnc');
  fp pointer value;
  buf pointer value;
  size like(tRreadnc_Size) value;
  opts like(tRreadnc_Opts) value;
end-pr;
