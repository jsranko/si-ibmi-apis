**FREE

/if not defined(Rwritep)
  /define Rwritep
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

dcl-s tRwrite_Size uns(10) template;
dcl-ds tRwrite_Return likeds(tRECIO_RIOFB) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rwrite()  Write the Next Record

dcl-pr Rwrite pointer extproc('_Rwrite');
  fp pointer value;
  buf pointer value;
  size like(tRwrite_Size) value;
end-pr;
