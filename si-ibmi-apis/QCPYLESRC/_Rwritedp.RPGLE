**FREE

/if not defined(Rwritedp)
  /define Rwritedp
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

dcl-s tRwrited_Size int(10) template;
dcl-s tRwrited_Rrn uns(10) template;
dcl-ds tRwrited_Return likeds(tRECIO_RIOFB) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rwrited()  Write the Next Record

dcl-pr Rwrited pointer extproc('_Rwrited');
  fp pointer value;
  buf pointer value;
  size like(tRwrited_Size) value;
  rrn like(tRwrited_Rrn) value;
end-pr;
