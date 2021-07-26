**FREE
         /if not defined(QUSROBJDP)
         /define QUSROBJDP
         /else
         /eof
         /endif

         /include qcpylesrc/qusecp

        //==========================================================================================
        // Constants
        //==========================================================================================

         dcl-c cQUSROBJD_FORMAT_BasicInformation const('OBJD0100');
         dcl-c cQUSROBJD_FORMAT_PDMInformation const('OBJD0200');
         dcl-c cQUSROBJD_FORMAT_ServiceInformation const('OBJD0300');
         dcl-c cQUSROBJD_FORMAT_FullInformation const('OBJD0400');

        //==========================================================================================
        // Tempaltes
        //==========================================================================================

         dcl-s tQUSROBJD_ReceiverVariable char(32767) template;
         dcl-s tQUSROBJD_LengthOfReceiverVariable int(10) template;
         dcl-s tQUSROBJD_FormatName char(8) template;
         dcl-s tQUSROBJD_ObjectNameAndLibraryName char(20) template;

         dcl-s tQUSROBJD_BytesReturned int(10) template;
         dcl-s tQUSROBJD_BytesAvailable int(10) template;
         dcl-s tQUSROBJD_ObjectName char(10) template;
         dcl-s tQUSROBJD_ObjectLibraryName char(10) template;
         dcl-s tQUSROBJD_ObjectType char(10) template;
         dcl-s tQUSROBJD_ReturnLibrary char(10) template;
         dcl-s tQUSROBJD_ObjectAuxiliaryStoragePoolAspNumber int(10) template;
         dcl-s tQUSROBJD_ObjectOwner char(10) template;
         dcl-s tQUSROBJD_ObjectDomain char(2) template;
         dcl-s tQUSROBJD_CreationDateAndTime char(13) template;
         dcl-s tQUSROBJD_ObjectChangeDateAndTime char(13) template;
         dcl-s tQUSROBJD_ExtendedObjectAttribute char(10) template;
         dcl-s tQUSROBJD_TextDescription char(50) template;
         dcl-s tQUSROBJD_SourceFileName char(10) template;
         dcl-s tQUSROBJD_SourceFileLibraryName char(10) template;
         dcl-s tQUSROBJD_SourceFileMemberName char(10) template;
         dcl-s tQUSROBJD_SourceFileUpdatedDateAndTime char(13) template;
         dcl-s tQUSROBJD_ObjectSavedDateAndTime char(13) template;
         dcl-s tQUSROBJD_ObjectRestoredDateAndTime char(13) template;
         dcl-s tQUSROBJD_CreatorsUserProfile char(10) template;
         dcl-s tQUSROBJD_SystemWhereObjectWasCreated char(8) template;
         dcl-s tQUSROBJD_ResetDate char(7) template;
         dcl-s tQUSROBJD_SavedSize int(10) template;
         dcl-s tQUSROBJD_SaveSequenceNumber int(10) template;
         dcl-s tQUSROBJD_Storage char(10) template;
         dcl-s tQUSROBJD_SaveCommand char(10) template;
         dcl-s tQUSROBJD_SaveVolumeId char(71) template;
         dcl-s tQUSROBJD_SaveDevice char(10) template;
         dcl-s tQUSROBJD_SaveFileName char(10) template;
         dcl-s tQUSROBJD_SaveFileLibraryName char(10) template;
         dcl-s tQUSROBJD_SaveLabel char(17) template;
         dcl-s tQUSROBJD_SystemLevel char(9) template;
         dcl-s tQUSROBJD_Compiler char(16) template;
         dcl-s tQUSROBJD_ObjectLevel char(8) template;
         dcl-s tQUSROBJD_UserChanged char(1) template;
         dcl-s tQUSROBJD_LicensedProgram char(16) template;
         dcl-s tQUSROBJD_ProgramTemporaryFixPtf char(10) template;
         dcl-s tQUSROBJD_AuthorizedProgramAnalysisReportApar char(10) template;
         dcl-s tQUSROBJD_LastUsedDate char(7) template;
         dcl-s tQUSROBJD_UsageInformationUpdated char(1) template;
         dcl-s tQUSROBJD_DaysUsedCount int(10) template;
         dcl-s tQUSROBJD_ObjectSize int(10) template;
         dcl-s tQUSROBJD_ObjectSizeMultiplier int(10) template;
         dcl-s tQUSROBJD_ObjectCompressionStatus char(1) template;
         dcl-s tQUSROBJD_AllowChangeByProgram char(1) template;
         dcl-s tQUSROBJD_ChangedByProgram char(1) template;
         dcl-s tQUSROBJD_UserDefinedAttribute char(10) template;
         dcl-s tQUSROBJD_ObjectOverflowedAuxiliaryStoragePoolAspIndicator char(1) template;
         dcl-s tQUSROBJD_SaveActiveDateAndTime char(13) template;
         dcl-s tQUSROBJD_ObjectAuditingValue char(10) template;
         dcl-s tQUSROBJD_PrimaryGroup char(10) template;
         dcl-s tQUSROBJD_JournalStatus char(1) template;
         dcl-s tQUSROBJD_JournalName char(10) template;
         dcl-s tQUSROBJD_JournalLibraryName char(10) template;
         dcl-s tQUSROBJD_JournalImages char(1) template;
         dcl-s tQUSROBJD_JournalEntriesToBeOmitted char(1) template;
         dcl-s tQUSROBJD_JournalStartDateAndTime char(13) template;
         dcl-s tQUSROBJD_DigitallySigned char(1) template;
         dcl-s tQUSROBJD_SavedSizeInUnits int(10) template;
         dcl-s tQUSROBJD_SavedSizeMultiplier int(10) template;
         dcl-s tQUSROBJD_LibraryAuxiliaryStoragePoolAspNumber int(10) template;
         dcl-s tQUSROBJD_ObjectAuxiliaryStoragePoolAspDeviceName char(10) template;
         dcl-s tQUSROBJD_LibraryAuxiliaryStoragePoolAspDeviceName char(10) template;
         dcl-s tQUSROBJD_DigitallySignedBySystemTrustedSource char(1) template;
         dcl-s tQUSROBJD_DigitallySignedMoreThanOnce char(1) template;
         dcl-s tQUSROBJD_Reserved1 char(2) template;
         dcl-s tQUSROBJD_PrimaryAssociatedSpaceSize int(10) template;
         dcl-s tQUSROBJD_OptimumSpaceAlignment char(1) template;
         dcl-s tQUSROBJD_ObjectAuxiliaryStoragePoolAspGroupName char(10) template;
         dcl-s tQUSROBJD_LibraryAuxiliaryStoragePoolAspGroupName char(10) template;
         dcl-s tQUSROBJD_StartingJournalReceiverNameForApply char(10) template;
         dcl-s tQUSROBJD_StartingJournalReceiverLibraryName char(10) template;
         dcl-s tQUSROBJD_StartingJournalReceiverLibraryAuxiliaryStoragePoolAspDeviceName char(10) template;
         dcl-s tQUSROBJD_StartingJournalReceiverLibraryAuxiliaryStoragePoolAspGroupName char(10) template;
         dcl-s tQUSROBJD_RemoteJournalFilter char(1) template;
         dcl-s tQUSROBJD_Reserved2 char(1) template;

         dcl-ds tQUSROBJD_OBJD0100 qualified template;
           BytesReturned  like(tQUSROBJD_BytesReturned);
           BytesAvailable  like(tQUSROBJD_BytesAvailable);
           ObjectName  like(tQUSROBJD_ObjectName);
           ObjectLibraryName  like(tQUSROBJD_ObjectLibraryName);
           ObjectType  like(tQUSROBJD_ObjectType);
           ReturnLibrary  like(tQUSROBJD_ReturnLibrary);
           ObjectAuxiliaryStoragePoolAspNumber  like(tQUSROBJD_ObjectAuxiliaryStoragePoolAspNumber);
           ObjectOwner  like(tQUSROBJD_ObjectOwner);
           ObjectDomain  like(tQUSROBJD_ObjectDomain);
           CreationDateAndTime  like(tQUSROBJD_CreationDateAndTime);
           ObjectChangeDateAndTime  like(tQUSROBJD_ObjectChangeDateAndTime);
         end-ds;

         dcl-ds tQUSROBJD_OBJD0200 qualified template;
           BytesReturned  like(tQUSROBJD_BytesReturned);
           BytesAvailable  like(tQUSROBJD_BytesAvailable);
           ObjectName  like(tQUSROBJD_ObjectName);
           ObjectLibraryName  like(tQUSROBJD_ObjectLibraryName);
           ObjectType  like(tQUSROBJD_ObjectType);
           ReturnLibrary  like(tQUSROBJD_ReturnLibrary);
           ObjectAuxiliaryStoragePoolAspNumber  like(tQUSROBJD_ObjectAuxiliaryStoragePoolAspNumber);
           ObjectOwner  like(tQUSROBJD_ObjectOwner);
           ObjectDomain  like(tQUSROBJD_ObjectDomain);
           CreationDateAndTime  like(tQUSROBJD_CreationDateAndTime);
           ObjectChangeDateAndTime  like(tQUSROBJD_ObjectChangeDateAndTime);
           ExtendedObjectAttribute  like(tQUSROBJD_ExtendedObjectAttribute);
           TextDescription  like(tQUSROBJD_TextDescription);
           SourceFileName  like(tQUSROBJD_SourceFileName);
           SourceFileLibraryName  like(tQUSROBJD_SourceFileLibraryName);
           SourceFileMemberName  like(tQUSROBJD_SourceFileMemberName);
         end-ds;

         dcl-ds tQUSROBJD_OBJD0300 qualified template;
           BytesReturned  like(tQUSROBJD_BytesReturned);
           BytesAvailable  like(tQUSROBJD_BytesAvailable);
           ObjectName  like(tQUSROBJD_ObjectName);
           ObjectLibraryName  like(tQUSROBJD_ObjectLibraryName);
           ObjectType  like(tQUSROBJD_ObjectType);
           ReturnLibrary  like(tQUSROBJD_ReturnLibrary);
           ObjectAuxiliaryStoragePoolAspNumber  like(tQUSROBJD_ObjectAuxiliaryStoragePoolAspNumber);
           ObjectOwner  like(tQUSROBJD_ObjectOwner);
           ObjectDomain  like(tQUSROBJD_ObjectDomain);
           CreationDateAndTime  like(tQUSROBJD_CreationDateAndTime);
           ObjectChangeDateAndTime  like(tQUSROBJD_ObjectChangeDateAndTime);
           ExtendedObjectAttribute  like(tQUSROBJD_ExtendedObjectAttribute);
           TextDescription  like(tQUSROBJD_TextDescription);
           SourceFileName  like(tQUSROBJD_SourceFileName);
           SourceFileLibraryName  like(tQUSROBJD_SourceFileLibraryName);
           SourceFileMemberName  like(tQUSROBJD_SourceFileMemberName);
           SourceFileUpdatedDateAndTime  like(tQUSROBJD_SourceFileUpdatedDateAndTime);
           ObjectSavedDateAndTime  like(tQUSROBJD_ObjectSavedDateAndTime);
           ObjectRestoredDateAndTime  like(tQUSROBJD_ObjectRestoredDateAndTime);
           CreatorsUserProfile  like(tQUSROBJD_CreatorsUserProfile);
           SystemWhereObjectWasCreated  like(tQUSROBJD_SystemWhereObjectWasCreated);
           ResetDate  like(tQUSROBJD_ResetDate);
           SavedSize  like(tQUSROBJD_SavedSize);
           SaveSequenceNumber  like(tQUSROBJD_SaveSequenceNumber);
           Storage  like(tQUSROBJD_Storage);
           SaveCommand  like(tQUSROBJD_SaveCommand);
           SaveVolumeId  like(tQUSROBJD_SaveVolumeId);
           SaveDevice  like(tQUSROBJD_SaveDevice);
           SaveFileName  like(tQUSROBJD_SaveFileName);
           SaveFileLibraryName  like(tQUSROBJD_SaveFileLibraryName);
           SaveLabel  like(tQUSROBJD_SaveLabel);
           SystemLevel  like(tQUSROBJD_SystemLevel);
           Compiler  like(tQUSROBJD_Compiler);
           ObjectLevel  like(tQUSROBJD_ObjectLevel);
           UserChanged  like(tQUSROBJD_UserChanged);
           LicensedProgram  like(tQUSROBJD_LicensedProgram);
           ProgramTemporaryFixPtf  like(tQUSROBJD_ProgramTemporaryFixPtf);
           AuthorizedProgramAnalysisReportApar  like(tQUSROBJD_AuthorizedProgramAnalysisReportApar);
         end-ds;

         dcl-ds tQUSROBJD_OBJD0400 qualified template;
           BytesReturned  like(tQUSROBJD_BytesReturned);
           BytesAvailable  like(tQUSROBJD_BytesAvailable);
           ObjectName  like(tQUSROBJD_ObjectName);
           ObjectLibraryName  like(tQUSROBJD_ObjectLibraryName);
           ObjectType  like(tQUSROBJD_ObjectType);
           ReturnLibrary  like(tQUSROBJD_ReturnLibrary);
           ObjectAuxiliaryStoragePoolAspNumber  like(tQUSROBJD_ObjectAuxiliaryStoragePoolAspNumber);
           ObjectOwner  like(tQUSROBJD_ObjectOwner);
           ObjectDomain  like(tQUSROBJD_ObjectDomain);
           CreationDateAndTime  like(tQUSROBJD_CreationDateAndTime);
           ObjectChangeDateAndTime  like(tQUSROBJD_ObjectChangeDateAndTime);
           ExtendedObjectAttribute  like(tQUSROBJD_ExtendedObjectAttribute);
           TextDescription  like(tQUSROBJD_TextDescription);
           SourceFileName  like(tQUSROBJD_SourceFileName);
           SourceFileLibraryName  like(tQUSROBJD_SourceFileLibraryName);
           SourceFileMemberName  like(tQUSROBJD_SourceFileMemberName);
           SourceFileUpdatedDateAndTime  like(tQUSROBJD_SourceFileUpdatedDateAndTime);
           ObjectSavedDateAndTime  like(tQUSROBJD_ObjectSavedDateAndTime);
           ObjectRestoredDateAndTime  like(tQUSROBJD_ObjectRestoredDateAndTime);
           CreatorsUserProfile  like(tQUSROBJD_CreatorsUserProfile);
           SystemWhereObjectWasCreated  like(tQUSROBJD_SystemWhereObjectWasCreated);
           ResetDate  like(tQUSROBJD_ResetDate);
           SavedSize  like(tQUSROBJD_SavedSize);
           SaveSequenceNumber  like(tQUSROBJD_SaveSequenceNumber);
           Storage  like(tQUSROBJD_Storage);
           SaveCommand  like(tQUSROBJD_SaveCommand);
           SaveVolumeId  like(tQUSROBJD_SaveVolumeId);
           SaveDevice  like(tQUSROBJD_SaveDevice);
           SaveFileName  like(tQUSROBJD_SaveFileName);
           SaveFileLibraryName  like(tQUSROBJD_SaveFileLibraryName);
           SaveLabel  like(tQUSROBJD_SaveLabel);
           SystemLevel  like(tQUSROBJD_SystemLevel);
           Compiler  like(tQUSROBJD_Compiler);
           ObjectLevel  like(tQUSROBJD_ObjectLevel);
           UserChanged  like(tQUSROBJD_UserChanged);
           LicensedProgram  like(tQUSROBJD_LicensedProgram);
           ProgramTemporaryFixPtf  like(tQUSROBJD_ProgramTemporaryFixPtf);
           AuthorizedProgramAnalysisReportApar  like(tQUSROBJD_AuthorizedProgramAnalysisReportApar);
           LastUsedDate  like(tQUSROBJD_LastUsedDate);
           UsageInformationUpdated  like(tQUSROBJD_UsageInformationUpdated);
           DaysUsedCount  like(tQUSROBJD_DaysUsedCount);
           ObjectSize  like(tQUSROBJD_ObjectSize);
           ObjectSizeMultiplier  like(tQUSROBJD_ObjectSizeMultiplier);
           ObjectCompressionStatus  like(tQUSROBJD_ObjectCompressionStatus);
           AllowChangeByProgram  like(tQUSROBJD_AllowChangeByProgram);
           ChangedByProgram  like(tQUSROBJD_ChangedByProgram);
           UserDefinedAttribute  like(tQUSROBJD_UserDefinedAttribute);
           ObjectOverflowedAuxiliaryStoragePoolAspIndicator  like(tQUSROBJD_ObjectOverflowedAuxiliaryStoragePoolAspIndicator);
           SaveActiveDateAndTime  like(tQUSROBJD_SaveActiveDateAndTime);
           ObjectAuditingValue  like(tQUSROBJD_ObjectAuditingValue);
           PrimaryGroup  like(tQUSROBJD_PrimaryGroup);
           JournalStatus  like(tQUSROBJD_JournalStatus);
           JournalName  like(tQUSROBJD_JournalName);
           JournalLibraryName  like(tQUSROBJD_JournalLibraryName);
           JournalImages  like(tQUSROBJD_JournalImages);
           JournalEntriesToBeOmitted  like(tQUSROBJD_JournalEntriesToBeOmitted);
           JournalStartDateAndTime  like(tQUSROBJD_JournalStartDateAndTime);
           DigitallySigned  like(tQUSROBJD_DigitallySigned);
           SavedSizeInUnits  like(tQUSROBJD_SavedSizeInUnits);
           SavedSizeMultiplier  like(tQUSROBJD_SavedSizeMultiplier);
           LibraryAuxiliaryStoragePoolAspNumber  like(tQUSROBJD_LibraryAuxiliaryStoragePoolAspNumber);
           ObjectAuxiliaryStoragePoolAspDeviceName  like(tQUSROBJD_ObjectAuxiliaryStoragePoolAspDeviceName);
           LibraryAuxiliaryStoragePoolAspDeviceName  like(tQUSROBJD_LibraryAuxiliaryStoragePoolAspDeviceName);
           DigitallySignedBySystemTrustedSource  like(tQUSROBJD_DigitallySignedBySystemTrustedSource);
           DigitallySignedMoreThanOnce  like(tQUSROBJD_DigitallySignedMoreThanOnce);
           Reserved1  like(tQUSROBJD_Reserved1);
           PrimaryAssociatedSpaceSize  like(tQUSROBJD_PrimaryAssociatedSpaceSize);
           OptimumSpaceAlignment  like(tQUSROBJD_OptimumSpaceAlignment);
           ObjectAuxiliaryStoragePoolAspGroupName  like(tQUSROBJD_ObjectAuxiliaryStoragePoolAspGroupName);
           LibraryAuxiliaryStoragePoolAspGroupName  like(tQUSROBJD_LibraryAuxiliaryStoragePoolAspGroupName);
           StartingJournalReceiverNameForApply  like(tQUSROBJD_StartingJournalReceiverNameForApply);
           StartingJournalReceiverLibraryName  like(tQUSROBJD_StartingJournalReceiverLibraryName);
           StartingJournalReceiverLibraryAuxiliaryStoragePoolAspDeviceName  like(tQUSROBJD_StartingJournalReceiverLibraryAuxiliaryStoragePoolAspDeviceName);
           StartingJournalReceiverLibraryAuxiliaryStoragePoolAspGroupName  like(tQUSROBJD_StartingJournalReceiverLibraryAuxiliaryStoragePoolAspGroupName);
           RemoteJournalFilter  like(tQUSROBJD_RemoteJournalFilter);
           Reserved2  like(tQUSROBJD_Reserved2);
         end-ds;

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr RetrieveObjectDescription extpgm('QUSROBJD');
           ReceiverVariable like(tQUSROBJD_ReceiverVariable) const;
           LengthOfReceiverVariable like(tQUSROBJD_LengthOfReceiverVariable) const;
           FormatName like(tQUSROBJD_FormatName) const;
           ObjectAndLibraryName like(tQUSROBJD_ObjectNameAndLibraryName) const;
           ObjectType like(tQUSROBJD_ObjectType) const;
           ErrorCode likeds(tQUSEC);
         end-pr;

