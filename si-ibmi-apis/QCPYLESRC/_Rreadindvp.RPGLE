**FREE

/if not defined(Rreadindvp)
  /define Rreadindvp
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

dcl-s tRreadindv_Size int(10) template;
dcl-s tRreadindv_Opts int(10) template;
dcl-ds tRreadindv_Return likeds(tRECIO_RIOFB) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rreadindv()  Read from an Invited Device

dcl-pr Rreadindv pointer extproc('_Rreadindv');
  fp pointer value;
  buf pointer value;
  size like(tRreadindv_Size) value;
  opts like(tRreadindv_Opts) value;
end-pr;
