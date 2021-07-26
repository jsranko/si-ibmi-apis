**FREE

/if not defined(SIOBJTYPP)
  /define SIOBJTYPP
/else
  /eof
/endif

//==========================================================================================
//             Constants
//==========================================================================================

dcl-c cOBJECTTYPE_AlertTable const('*ALRTBL');
dcl-c cOBJECTTYPE_AuthorizationList const('*AUTL');
dcl-c cOBJECTTYPE_BlockSpecialFile const('*BLKSF');
dcl-c cOBJECTTYPE_BindingDirectory const('*BNDDIR');
dcl-c cOBJECTTYPE_ConfigurationList const('*CFGL');
dcl-c cOBJECTTYPE_CharacterSpecialFile const('*CHRSF');
dcl-c cOBJECTTYPE_ChartFormat const('*CHTFMT');
dcl-c cOBJECTTYPE_C400LocaleDescription const('*CLD');
dcl-c cOBJECTTYPE_Class const('*CLS');
dcl-c cOBJECTTYPE_Command const('*CMD');
dcl-c cOBJECTTYPE_ConnectionList const('*CNNL');
dcl-c cOBJECTTYPE_ClassOfServiceDescription const('*COSD');
dcl-c cOBJECTTYPE_ClusterResourceGroup const('*CRG');
dcl-c cOBJECTTYPE_ChangeRequestDescription const('*CRQD');
dcl-c cOBJECTTYPE_CommunicationsSideInformation const('*CSI');
dcl-c cOBJECTTYPE_CrossSystemProductMap const('*CSPMAP');
dcl-c cOBJECTTYPE_CrossSystemProductTable const('*CSPTBL');
dcl-c cOBJECTTYPE_ControllerDescription const('*CTLD');
dcl-c cOBJECTTYPE_DistributedFileDirectory const('*DDIR');
dcl-c cOBJECTTYPE_DeviceDescription const('*DEVD');
dcl-c cOBJECTTYPE_Directory const('*DIR');
dcl-c cOBJECTTYPE_Document const('*DOC');
dcl-c cOBJECTTYPE_DistributedStreamFile const('*DSTMF');
dcl-c cOBJECTTYPE_DataArea const('*DTAARA');
dcl-c cOBJECTTYPE_DataDictionary const('*DTADCT');
dcl-c cOBJECTTYPE_DataQueue const('*DTAQ');
dcl-c cOBJECTTYPE_EditDescription const('*EDTD');
dcl-c cOBJECTTYPE_ExitRegistration const('*EXITRG');
dcl-c cOBJECTTYPE_FormsControlTable const('*FCT');
dcl-c cOBJECTTYPE_FirstInFirstOutSpecialFile const('*FIFO');
dcl-c cOBJECTTYPE_File const('*FILE');
dcl-c cOBJECTTYPE_Folder const('*FLR');
dcl-c cOBJECTTYPE_FontResources const('*FNTRSC');
dcl-c cOBJECTTYPE_FontMappingTable const('*FNTTBL');
dcl-c cOBJECTTYPE_FormDefinition const('*FORMDF');
dcl-c cOBJECTTYPE_Filter const('*FTR');
dcl-c cOBJECTTYPE_GraphicsSymbolSet const('*GSS');
dcl-c cOBJECTTYPE_DbcsConversionDictionary const('*IGCDCT');
dcl-c cOBJECTTYPE_DbcsSortTable const('*IGCSRT');
dcl-c cOBJECTTYPE_DbcsFontTable const('*IGCTBL');
dcl-c cOBJECTTYPE_ImageCatalog const('*IMGCLG');
dcl-c cOBJECTTYPE_InternetworkPacketExchangeDescription const('*IPXD');
dcl-c cOBJECTTYPE_JobDescription const('*JOBD');
dcl-c cOBJECTTYPE_JobQueue const('*JOBQ');
dcl-c cOBJECTTYPE_JobSchedule const('*JOBSCD');
dcl-c cOBJECTTYPE_Journal const('*JRN');
dcl-c cOBJECTTYPE_JournalReceiver const('*JRNRCV');
dcl-c cOBJECTTYPE_Library const('*LIB');
dcl-c cOBJECTTYPE_LineDescription const('*LIND');
dcl-c cOBJECTTYPE_Locale const('*LOCALE');
dcl-c cOBJECTTYPE_MediaDefinition const('*MEDDFN');
dcl-c cOBJECTTYPE_MenuDescription const('*MENU');
dcl-c cOBJECTTYPE_ManagementCollection const('*MGTCOL');
dcl-c cOBJECTTYPE_ModeDescription const('*MODD');
dcl-c cOBJECTTYPE_CompilerUnit const('*MODULE');
dcl-c cOBJECTTYPE_MessageFile const('*MSGF');
dcl-c cOBJECTTYPE_MessageQueue const('*MSGQ');
dcl-c cOBJECTTYPE_As400Advanced36Machine const('*M36');
dcl-c cOBJECTTYPE_As400Advanced36MachineConfiguration const('*M36CFG');
dcl-c cOBJECTTYPE_NodeGroup const('*NODGRP');
dcl-c cOBJECTTYPE_NodeList const('*NODL');
dcl-c cOBJECTTYPE_NetbiosDescription const('*NTBD');
dcl-c cOBJECTTYPE_NetworkInterfaceDescription const('*NWID');
dcl-c cOBJECTTYPE_NetworkServerConfiguration const('*NWSCFG');
dcl-c cOBJECTTYPE_NetworkServerDescription const('*NWSD');
dcl-c cOBJECTTYPE_OutputQueue const('*OUTQ');
dcl-c cOBJECTTYPE_Overlay const('*OVL');
dcl-c cOBJECTTYPE_PageDefinition const('*PAGDFN');
dcl-c cOBJECTTYPE_PageSegment const('*PAGSEG');
dcl-c cOBJECTTYPE_PortableDocumentFormatMap const('*PDFMAP');
dcl-c cOBJECTTYPE_PrintDescriptorGroup const('*PDG');
dcl-c cOBJECTTYPE_Program const('*PGM');
dcl-c cOBJECTTYPE_PanelGroupDefinition const('*PNLGRP');
dcl-c cOBJECTTYPE_ProductAvailability const('*PRDAVL');
dcl-c cOBJECTTYPE_ProductDefinition const('*PRDDFN');
dcl-c cOBJECTTYPE_ProductLoad const('*PRDLOD');
dcl-c cOBJECTTYPE_PrintServicesFacilityConfiguration const('*PSFCFG');
dcl-c cOBJECTTYPE_QueryManagementForm const('*QMFORM');
dcl-c cOBJECTTYPE_QueryManagementQuery const('*QMQRY');
dcl-c cOBJECTTYPE_QueryDefinition const('*QRYDFN');
dcl-c cOBJECTTYPE_ReferenceCodeTranslateTable const('*RCT');
dcl-c cOBJECTTYPE_SubsystemDescription const('*SBSD');
dcl-c cOBJECTTYPE_SearchIndex const('*SCHIDX');
dcl-c cOBJECTTYPE_LocalSocket const('*SOCKET');
dcl-c cOBJECTTYPE_SpellingAidDictionary const('*SPADCT');
dcl-c cOBJECTTYPE_StructuredQueryLanguagePackage const('*SQLPKG');
dcl-c cOBJECTTYPE_UserDefinedSqlType const('*SQLUDT');
dcl-c cOBJECTTYPE_SqlXmlSchemaRepository const('*SQLXSR');
dcl-c cOBJECTTYPE_ServiceProgram const('*SRVPGM');
dcl-c cOBJECTTYPE_SessionDescription const('*SSND');
dcl-c cOBJECTTYPE_BytestreamFile const('*STMF');
dcl-c cOBJECTTYPE_ServerStorageSpace const('*SVRSTG');
dcl-c cOBJECTTYPE_SymbolicLink const('*SYMLNK');
dcl-c cOBJECTTYPE_System36MachineDescription const('*S36');
dcl-c cOBJECTTYPE_Table const('*TBL');
dcl-c cOBJECTTYPE_TimeZoneDescription const('*TIMZON');
dcl-c cOBJECTTYPE_UserIndex const('*USRIDX');
dcl-c cOBJECTTYPE_UserProfile const('*USRPRF');
dcl-c cOBJECTTYPE_UserQueue const('*USRQ');
dcl-c cOBJECTTYPE_UserSpace const('*USRSPC');
dcl-c cOBJECTTYPE_ValidationList const('*VLDL');
dcl-c cOBJECTTYPE_WorkstationUserCustomizationObject const('*WSCST');

