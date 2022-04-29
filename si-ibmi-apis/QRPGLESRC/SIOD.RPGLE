**FREE

//******************************************************************************************
//
//
// Programname    : SIOD
// Programautor   : Sranko Informatik
// Created on     : 27.04.2019
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See QCLLESRC,makesiiia
//
//==========================================================================================

ctl-opt NoMain bnddir('$(LIBRARY)/SIIIA');

//==========================================================================================
// Templates
//==========================================================================================

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

/define SIOD
/include qcpylesrc/siodp

/include qcpylesrc/sixcpp
/include qcpylesrc/siobjtypp

//==========================================================================================
// Procedures
//==========================================================================================

dcl-proc SIOD_new export;
dcl-pi SIOD_new like(tSIOD) extproc(*dclcase);
  Library like(tSIOD_Library) const;
  Object like(tSIOD_Object) const;
  Type like(tSIOD_Type) const;
end-pi;
dcl-ds dsSIOD likeds(tSIOD_Def) inz;

  select;
  when Library = '*CURLIB';
  when Library = '*LIBL';
  when %scan('*':Library) > 0;
    SIXCP_throwWithMessage(Library + ' not valid.');
  other;
  endsl;

  if not isTypeValid(Type);
    SIXCP_throwWithMessage(Type + ' not valid.');
  endif;
  clear dsSIOD;

  dsSIOD.Library = Library;
  dsSIOD.Object = Object;
  dsSIOD.Type = Type;

  getData(dsSIOD:1);

return dsSIOD;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIOD_getCreationDateAndTime export;
dcl-pi SIOD_getCreationDateAndTime like(tSIOD_CreationDateAndTime) extproc(*dclcase);
   SIOD like(tSIOD);
end-pi;
dcl-ds dsSIOD likeds(tSIOD_Def) based(pSIOD);

  pSIOD = %addr(SIOD);

  getData(dsSIOD:1);
return dsSIOD.Data.CreationDateAndTime;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIOD_exist export;
dcl-pi SIOD_exist ind extproc(*dclcase);
  SIOD like(tSIOD);
end-pi;
dcl-ds dsSIOD likeds(tSIOD_Def) based(pSIOD);

  pSIOD = %addr(SIOD);

return dsSIOD.exist;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIOD_getReturnLibrary export;
dcl-pi SIOD_getReturnLibrary like(tSIOD_ReturnLibrary) extproc(*dclcase);
  SIOD like(tSIOD);
end-pi;
dcl-ds dsSIOD likeds(tSIOD_Def) based(pSIOD);

  pSIOD = %addr(SIOD);

return %trim(dsSIOD.Data.ReturnLibrary);
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIOD_getObjectType export;
dcl-pi SIOD_getObjectType like(tSIOD_ObjectType) extproc(*dclcase);
  SIOD like(tSIOD);
end-pi;
dcl-ds dsSIOD likeds(tSIOD_Def) based(pSIOD);

  pSIOD = %addr(SIOD);

return %trim(dsSIOD.Data.ObjectType);
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isTypeValid;
dcl-pi isTypeValid ind;
   Type like(tSIOD_Type) const;
end-pi;

  if %trim(Type) = cOBJECTTYPE_AlertTable
  or %trim(Type) = cOBJECTTYPE_AuthorizationList
  or %trim(Type) = cOBJECTTYPE_BlockSpecialFile
  or %trim(Type) = cOBJECTTYPE_BindingDirectory
  or %trim(Type) = cOBJECTTYPE_ConfigurationList
  or %trim(Type) = cOBJECTTYPE_CharacterSpecialFile
  or %trim(Type) = cOBJECTTYPE_ChartFormat
  or %trim(Type) = cOBJECTTYPE_C400LocaleDescription
  or %trim(Type) = cOBJECTTYPE_Class
  or %trim(Type) = cOBJECTTYPE_Command
  or %trim(Type) = cOBJECTTYPE_ConnectionList
  or %trim(Type) = cOBJECTTYPE_ClassOfServiceDescription
  or %trim(Type) = cOBJECTTYPE_ClusterResourceGroup
  or %trim(Type) = cOBJECTTYPE_ChangeRequestDescription
  or %trim(Type) = cOBJECTTYPE_CommunicationsSideInformation
  or %trim(Type) = cOBJECTTYPE_CrossSystemProductMap
  or %trim(Type) = cOBJECTTYPE_CrossSystemProductTable
  or %trim(Type) = cOBJECTTYPE_ControllerDescription
  or %trim(Type) = cOBJECTTYPE_DistributedFileDirectory
  or %trim(Type) = cOBJECTTYPE_DeviceDescription
  or %trim(Type) = cOBJECTTYPE_Directory
  or %trim(Type) = cOBJECTTYPE_Document
  or %trim(Type) = cOBJECTTYPE_DistributedStreamFile
  or %trim(Type) = cOBJECTTYPE_DataArea
  or %trim(Type) = cOBJECTTYPE_DataDictionary
  or %trim(Type) = cOBJECTTYPE_DataQueue
  or %trim(Type) = cOBJECTTYPE_EditDescription
  or %trim(Type) = cOBJECTTYPE_ExitRegistration
  or %trim(Type) = cOBJECTTYPE_FormsControlTable
  or %trim(Type) = cOBJECTTYPE_FirstInFirstOutSpecialFile
  or %trim(Type) = cOBJECTTYPE_File
  or %trim(Type) = cOBJECTTYPE_Folder
  or %trim(Type) = cOBJECTTYPE_FontResources
  or %trim(Type) = cOBJECTTYPE_FontMappingTable
  or %trim(Type) = cOBJECTTYPE_FormDefinition
  or %trim(Type) = cOBJECTTYPE_Filter
  or %trim(Type) = cOBJECTTYPE_GraphicsSymbolSet
  or %trim(Type) = cOBJECTTYPE_DbcsConversionDictionary
  or %trim(Type) = cOBJECTTYPE_DbcsSortTable
  or %trim(Type) = cOBJECTTYPE_DbcsFontTable
  or %trim(Type) = cOBJECTTYPE_ImageCatalog
  or %trim(Type) = cOBJECTTYPE_InternetworkPacketExchangeDescription
  or %trim(Type) = cOBJECTTYPE_JobDescription
  or %trim(Type) = cOBJECTTYPE_JobQueue
  or %trim(Type) = cOBJECTTYPE_JobSchedule
  or %trim(Type) = cOBJECTTYPE_Journal
  or %trim(Type) = cOBJECTTYPE_JournalReceiver
  or %trim(Type) = cOBJECTTYPE_Library
  or %trim(Type) = cOBJECTTYPE_LineDescription
  or %trim(Type) = cOBJECTTYPE_Locale
  or %trim(Type) = cOBJECTTYPE_MediaDefinition
  or %trim(Type) = cOBJECTTYPE_MenuDescription
  or %trim(Type) = cOBJECTTYPE_ManagementCollection
  or %trim(Type) = cOBJECTTYPE_ModeDescription
  or %trim(Type) = cOBJECTTYPE_CompilerUnit
  or %trim(Type) = cOBJECTTYPE_MessageFile
  or %trim(Type) = cOBJECTTYPE_MessageQueue
  or %trim(Type) = cOBJECTTYPE_As400Advanced36Machine
  or %trim(Type) = cOBJECTTYPE_As400Advanced36MachineConfiguration
  or %trim(Type) = cOBJECTTYPE_NodeGroup
  or %trim(Type) = cOBJECTTYPE_NodeList
  or %trim(Type) = cOBJECTTYPE_NetbiosDescription
  or %trim(Type) = cOBJECTTYPE_NetworkInterfaceDescription
  or %trim(Type) = cOBJECTTYPE_NetworkServerConfiguration
  or %trim(Type) = cOBJECTTYPE_NetworkServerDescription
  or %trim(Type) = cOBJECTTYPE_OutputQueue
  or %trim(Type) = cOBJECTTYPE_Overlay
  or %trim(Type) = cOBJECTTYPE_PageDefinition
  or %trim(Type) = cOBJECTTYPE_PageSegment
  or %trim(Type) = cOBJECTTYPE_PortableDocumentFormatMap
  or %trim(Type) = cOBJECTTYPE_PrintDescriptorGroup
  or %trim(Type) = cOBJECTTYPE_Program
  or %trim(Type) = cOBJECTTYPE_PanelGroupDefinition
  or %trim(Type) = cOBJECTTYPE_ProductAvailability
  or %trim(Type) = cOBJECTTYPE_ProductDefinition
  or %trim(Type) = cOBJECTTYPE_ProductLoad
  or %trim(Type) = cOBJECTTYPE_PrintServicesFacilityConfiguration
  or %trim(Type) = cOBJECTTYPE_QueryManagementForm
  or %trim(Type) = cOBJECTTYPE_QueryManagementQuery
  or %trim(Type) = cOBJECTTYPE_QueryDefinition
  or %trim(Type) = cOBJECTTYPE_ReferenceCodeTranslateTable
  or %trim(Type) = cOBJECTTYPE_SubsystemDescription
  or %trim(Type) = cOBJECTTYPE_SearchIndex
  or %trim(Type) = cOBJECTTYPE_LocalSocket
  or %trim(Type) = cOBJECTTYPE_SpellingAidDictionary
  or %trim(Type) = cOBJECTTYPE_StructuredQueryLanguagePackage
  or %trim(Type) = cOBJECTTYPE_UserDefinedSqlType
  or %trim(Type) = cOBJECTTYPE_SqlXmlSchemaRepository
  or %trim(Type) = cOBJECTTYPE_ServiceProgram
  or %trim(Type) = cOBJECTTYPE_SessionDescription
  or %trim(Type) = cOBJECTTYPE_BytestreamFile
  or %trim(Type) = cOBJECTTYPE_ServerStorageSpace
  or %trim(Type) = cOBJECTTYPE_SymbolicLink
  or %trim(Type) = cOBJECTTYPE_System36MachineDescription
  or %trim(Type) = cOBJECTTYPE_Table
  or %trim(Type) = cOBJECTTYPE_TimeZoneDescription
  or %trim(Type) = cOBJECTTYPE_UserIndex
  or %trim(Type) = cOBJECTTYPE_UserProfile
  or %trim(Type) = cOBJECTTYPE_UserQueue
  or %trim(Type) = cOBJECTTYPE_UserSpace
  or %trim(Type) = cOBJECTTYPE_ValidationList
  or %trim(Type) = cOBJECTTYPE_WorkstationUserCustomizationObject;
    return *on;
  else;
    return *off;
  endif;

end-proc;

//------------------------------------------------------------------------------------------

dcl-proc getData;
dcl-pi getData;
  dsSIOD likeds(tSIOD_Def);
  FormatNumber like(tSIOD_FormatNubmer) const;
end-pi;
dcl-s rv like(tQUSROBJD_ReceiverVariable);
dcl-s rvl like(tQUSROBJD_LengthOfReceiverVariable) inz(%size(rv));
dcl-s fn like(tQUSROBJD_FormatName);
dcl-ds ErrorCode likeds(tQUSEC);

  select;
  when FormatNumber <= dsSIOD.lastFormat;
    return;
  when FormatNumber > dsSIOD.lastFormat;
    select;
    when FormatNumber = 1;
      fn = cQUSROBJD_FORMAT_BasicInformation;
      rvl = %size(tQUSROBJD_OBJD0100);
    when FormatNumber = 2;
      fn = cQUSROBJD_FORMAT_PDMInformation;
      rvl = %size(tQUSROBJD_OBJD0200);
    when FormatNumber = 3;
      fn = cQUSROBJD_FORMAT_ServiceInformation;
      rvl = %size(tQUSROBJD_OBJD0300);
    when FormatNumber = 4;
      fn = cQUSROBJD_FORMAT_FullInformation;
      rvl = %size(tQUSROBJD_OBJD0400);
    endsl;
  endsl;

  RetrieveObjectDescription(rv
                           :rvl
                           :fn
                           :dsSIOD.Object + dsSIOD.Library
                           :dsSIOD.Type
                           :ErrorCode
                           );
  if ErrorCode .ExceptionId <> *blanks;
    select;
    when ErrorCode.ExceptionID = 'CPF9801'
      or ErrorCode.ExceptionID = 'CPF9810'
      or ErrorCode.ExceptionID = 'CPF9811'
      or ErrorCode.ExceptionID = 'CPF9812'
      or ErrorCode.ExceptionID = 'CPF9814';
      dsSIOD.exist = *off;
    endsl;
  else;
    dsSIOD.exist = *on;
  endif;

  dsSIOD.Data = %subst(rv:1:rvl);

return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIOD_close export;
dcl-pi SIOD_close extproc(*dclcase);
  SIOD like(tSIOD);
end-pi;
dcl-ds dsSIOD likeds(tSIOD_Def) based(pSIOD);

  pSIOD = %addr(SIOD);
  clear dsSIOD;

return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIOD_getTextDescription export;
dcl-pi SIOD_getTextDescription like(tSIOD_TextDescription) extproc(*dclcase);
  SIOD like(tSIOD);
end-pi;
dcl-ds dsSIOD likeds(tSIOD_Def) based(pSIOD);

  pSIOD = %addr(SIOD);

  getData(dsSIOD:2);
  return %trim(dsSIOD.Data.TextDescription);
end-proc;
