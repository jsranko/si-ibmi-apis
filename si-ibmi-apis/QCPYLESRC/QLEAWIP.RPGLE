**FREE
/if not defined(QLEAWIP)
  /define QLEAWIP
/else
  /eof
/endif

/include qcpylesrc/qusecp

//==========================================================================================
//             Constants
//==========================================================================================

dcl-c cQLEAWI_Use_export_name const(0);
dcl-c cQLEAWI_Export_name_is_a_null_terminated const(0);
dcl-c cQLEAWI_Export_was_not_found const(0);
dcl-c cQLEAWI_Export_is_a_procedure const(1);
dcl-c cQLEAWI_Export_is_data const(2);
dcl-c cQLEAWI_Export_is_not_accessible const(3);

//==========================================================================================
//             Templates
//==========================================================================================

dcl-s tQLEAWI_ActivationMark int(10) template;
dcl-s tQLEAWI_AuthorityToBeSet char(2) template;
dcl-ds tQLEAWI_ActivationInformation qualified template;
  BytesReturned int(10);
  BytesAvailable int(10);
  Reserverd8 char(8);
  ActivationGroupMark int(10);
  ActivationMark int(10);
  Reserved7 char(7);
  Flags char(1);
  Reserved16 char(16);
end-ds;
dcl-s tQLEAWI_LengthOfActivationInformation int(10) template;
dcl-s tQLEAWI_ExportNumber int(10) template;
dcl-s tQLEAWI_ExportNameLength int(10) template;
dcl-s tQLEAWI_ExportName char(32767) template;
dcl-s tQLEAWI_ExportItem pointer(*proc) template;
dcl-s tQLEAWI_TypeOfExportItem int(10) template;

//==========================================================================================
//             Prototypes
//==========================================================================================

dcl-pr ActivateBoundProgram like(tQLEAWI_ActivationMark) extproc('QleActBndPgm');
  PointerToBoundProgram pointer(*proc) const;
  ActivationMark like(tQLEAWI_ActivationMark) options(*omit);
  ActivationInformation likeds(tQLEAWI_ActivationInformation) options(*omit);
  LengthOfActivationInformation like(tQLEAWI_LengthOfActivationInformation) const options(*omit);
  ErrorCode likeds(tQUSEC);
end-pr;

dcl-pr GetExport pointer extproc('QleGetExp');
  ActivationMark like(tQLEAWI_ActivationMark) const;
  ExportNumber like(tQLEAWI_ExportNumber) const;
  ExportNameLength like(tQLEAWI_ExportNameLength) const;
  ExportName like(tQLEAWI_ExportName) const options(*varsize);
  ExportedItem like(tQLEAWI_ExportItem);
  TypeOfExportItem like(tQLEAWI_TypeOfExportItem);
  ErrorCode likeds(tQUSEC);
end-pr;

