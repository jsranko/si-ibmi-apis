**FREE

/if not defined(ECARTCMDP)
  /define ECARTCMDP
/else
  /eof
/endif

//==========================================================================================
//             Constants
//==========================================================================================

dcl-c cECARTCMD_SUCCESSFUL const(0);

//==========================================================================================
//             Templates
//==========================================================================================
dcl-s tECARTCMD_ExitPointName char(20) template;
dcl-s tECARTCMD_ExitPointFormatName char(8) template;
dcl-s tECARTCMD_CommandName char(10) template;
dcl-s tECARTCMD_LibraryName char(10) template;
dcl-s tECARTCMD_Reserved2 char(2) template;
dcl-s tECARTCMD_Reserved1 char(1) template;
dcl-s tECARTCMD_BeforeOrAfterIndicator char(1) template;
dcl-s tECARTCMD_OffsetToOriginalCommandString int(10) template;
dcl-s tECARTCMD_LengthOfOriginalCommandString int(10) template;
dcl-s tECARTCMD_OffsetToReplacementCommandString int(10) template;
dcl-s tECARTCMD_LengthOfReplacementCommandString int(10) template;
dcl-s tECARTCMD_OffsetToProxyChain int(10) template;
dcl-s tECARTCMD_NumberOfEntriesInProxyChain int(10) template;
dcl-s tECARTCMD_Data char(32000) template;

dcl-ds tECARTCMD_RTVC0100 qualified template;
  ExitPointName like(tECARTCMD_ExitPointName);
  ExitPointFormatName like(tECARTCMD_ExitPointFormatName);
  CommandName like(tECARTCMD_CommandName);
  LibraryName like(tECARTCMD_LibraryName);
  Reserved2 like(tECARTCMD_Reserved2);
  BeforeOrAfterIndicator like(tECARTCMD_BeforeOrAfterIndicator);
  Reserved1 like(tECARTCMD_Reserved1);
  OffsetToOriginalCommandString like(tECARTCMD_OffsetToOriginalCommandString);
  LengthOfOriginalCommandString like(tECARTCMD_LengthOfOriginalCommandString);
  OffsetToReplacementCommandString like(tECARTCMD_OffsetToReplacementCommandString);
  LengthOfReplacementCommandString like(tECARTCMD_LengthOfReplacementCommandString);
  OffsetToProxyChain like(tECARTCMD_OffsetToProxyChain);
  NumberOfEntriesInProxyChain like(tECARTCMD_NumberOfEntriesInProxyChain);
  Data like(tECARTCMD_Data);
end-ds;


