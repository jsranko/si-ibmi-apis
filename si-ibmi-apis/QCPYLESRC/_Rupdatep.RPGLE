**FREE

/if not defined(Rupdatep)
  /define Rupdatep
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

dcl-s tRupdate_Size int(10) template;
dcl-ds tRupdate_Return likeds(tRECIO_RIOFB) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rupdate()  Update a Record

dcl-pr Rupdate pointer extproc('_Rupdate');
  fp pointer value;
  buf pointer value;
  size like(tRupdate_Size) value;
end-pr;
