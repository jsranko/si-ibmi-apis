**FREE
         /if not defined(QSYRUSRIP)
         /define QSYRUSRIP
         /else
         /eof
         /endif

         /include qcpylesrc/qusecp

        //==========================================================================================
        // Constants
        //==========================================================================================

         dcl-c cQSYRUSRI_NumberOfSupplementalGroups const(3276);

        //==========================================================================================
        //             Templates
        //==========================================================================================


        dcl-s tQSYRUSRI_BytesReturned int(10) template;
        dcl-s tQSYRUSRI_BytesAvailable int(10) template;
        dcl-s tQSYRUSRI_ReceiverVariable char(32756) template;
        dcl-s tQSYRUSRI_ReceiverVariableLength int(10) template;
        dcl-s tQSYRUSRI_FormatName char(8) template;
        dcl-s tQSYRUSRI_UserProfileName char(10) template;
        dcl-s tQSYRUSRI_PreviousSignOnDateTime char(13) template;
        dcl-s tQSYRUSRI_Reserved1 char(1) template;
        dcl-s tQSYRUSRI_SignOnAttemptsNotValid int(10) template;
        dcl-s tQSYRUSRI_Status char(10) template;
        dcl-s tQSYRUSRI_PasswordChangeDate char(8) template;
        dcl-s tQSYRUSRI_NoPasswordIndicator char(1) template;
        dcl-s tQSYRUSRI_PasswordExpirationInterval int(10) template;
        dcl-s tQSYRUSRI_DatePasswordExpires char(8) template;
        dcl-s tQSYRUSRI_SetPasswordToExpire char(1) template;
        dcl-s tQSYRUSRI_DisplaySignOnInformation char(10) template;
        dcl-s tQSYRUSRI_LocalPasswordManagement char(1) template;
        dcl-s tQSYRUSRI_BlockPasswordChange char(10) template;
        dcl-s tQSYRUSRI_UserClassName char(10) template;
        dcl-s tQSYRUSRI_SpecialAuthorities char(15) template;
        dcl-s tQSYRUSRI_GroupProfileName char(10) template;
        dcl-s tQSYRUSRI_Owner char(10) template;
        dcl-s tQSYRUSRI_GroupAuthority char(10) template;
        dcl-s tQSYRUSRI_LimitCapabilities char(10) template;
        dcl-s tQSYRUSRI_GroupAuthorityType char(10) template;
        dcl-s tQSYRUSRI_Reserved3 char(3) template;
        dcl-s tQSYRUSRI_OffsetToArrayOfSupplementalGroups int(10) template;
        dcl-s tQSYRUSRI_NumberOfSupplementalGroups int(10) template;
        dcl-s tQSYRUSRI_SupplementalGroups char(10) dim(cQSYRUSRI_NumberOfSupplementalGroups) template;
        dcl-s tQSYRUSRI_AssistanceLevel char(10) template;
        dcl-s tQSYRUSRI_CurrentLibraryName char(10) template;
        dcl-s tQSYRUSRI_InitialMenuName char(10) template;
        dcl-s tQSYRUSRI_InitialMenuLibraryName char(10) template;
        dcl-s tQSYRUSRI_InitialProgramName char(10) template;
        dcl-s tQSYRUSRI_InitialProgramLibraryName char(10) template;
        dcl-s tQSYRUSRI_TextDescription char(50) template;
        dcl-s tQSYRUSRI_LimitDeviceSessions char(10) template;
        dcl-s tQSYRUSRI_KeyboardBuffering char(10) template;
        dcl-s tQSYRUSRI_Reserved2 char(2) template;
        dcl-s tQSYRUSRI_MaximumAllowedStorage int(10) template;
        dcl-s tQSYRUSRI_StorageUsed int(10) template;
        dcl-s tQSYRUSRI_HighestSchedulingPriority char(1) template;
        dcl-s tQSYRUSRI_JobDescriptionName char(10) template;
        dcl-s tQSYRUSRI_JobDescriptionLibraryName char(10) template;
        dcl-s tQSYRUSRI_AccountingCode char(15) template;
        dcl-s tQSYRUSRI_MessageQueueName char(10) template;
        dcl-s tQSYRUSRI_MessageQueueLibraryName char(10) template;
        dcl-s tQSYRUSRI_MessageQueueDeliveryMethod char(10) template;
        dcl-s tQSYRUSRI_MessageQueueSeverity int(10) template;
        dcl-s tQSYRUSRI_OutputQueueName char(10) template;
        dcl-s tQSYRUSRI_OutputQueueLibraryName char(10) template;
        dcl-s tQSYRUSRI_PrintDevice char(10) template;
        dcl-s tQSYRUSRI_SpecialEnvironment char(10) template;
        dcl-s tQSYRUSRI_AttentionKeyHandlingProgramName char(10) template;
        dcl-s tQSYRUSRI_AttentionKeyHandlingProgramLibraryName char(10) template;
        dcl-s tQSYRUSRI_LanguageID char(10) template;
        dcl-s tQSYRUSRI_LanguageID3 char(3) template;
        dcl-s tQSYRUSRI_CountryOrRegionID char(10) template;
        dcl-s tQSYRUSRI_CharacterCodeSetID int(10) template;
        dcl-s tQSYRUSRI_UserOptions char(36) template;
        dcl-s tQSYRUSRI_SortSequenceTableName char(10) template;
        dcl-s tQSYRUSRI_SortSequenceTableLibraryName char(10) template;
        dcl-s tQSYRUSRI_UserActionAuditLevel char(64) template;
        dcl-s tQSYRUSRI_UserIDNumber int(10) template;
        dcl-s tQSYRUSRI_GroupIDNumber int(10) template;
        dcl-s tQSYRUSRI_OffsetToHomeDirectory int(10) template;
        dcl-s tQSYRUSRI_LengthOfHomeDirectory int(10) template;
        dcl-s tQSYRUSRI_LocaleJobAttributes char(16) template;
        dcl-s tQSYRUSRI_OffsetToLocalePathName int(10) template;
        dcl-s tQSYRUSRI_LengthOfLocalePathName int(10) template;
        dcl-s tQSYRUSRI_GroupMemberIndicator char(1) template;
        dcl-s tQSYRUSRI_DigitalCertificateIndicator char(1) template;
        dcl-s tQSYRUSRI_CharacterIdentifierControl char(10) template;
        dcl-s tQSYRUSRI_OffsetToArrayOfIndependentASPStorageUsageDescriptors int(10) template;
        dcl-s tQSYRUSRI_NumberOfIndependentASPStorageUsageDescriptors int(10) template;
        dcl-s tQSYRUSRI_NumberOfIndependentASPStorageUsageDescriptorsReturned int(10) template;
        dcl-s tQSYRUSRI_LengthOfAnIndependentASPStorageUsageDescriptor int(10) template;
        dcl-s tQSYRUSRI_UserEntitlementRequired char(1) template;
        dcl-s tQSYRUSRI_UserExpirationInterval int(10) template;
        dcl-s tQSYRUSRI_UserExpirationDate char(8) template;
        dcl-s tQSYRUSRI_UserExpirationAction char(10) template;
        dcl-s tQSYRUSRI_MaximumAllowedStorageLong uns(20) template;
        dcl-s tQSYRUSRI_StorageUsedLong uns(20) template;
        dcl-s tQSYRUSRI_USRI0200_Data char(32767) template;
        dcl-s tQSYRUSRI_CCSIDOfTheReturnedHomeDirectory int(10) template;
        dcl-s tQSYRUSRI_CountryOrRegionID2 char(2) template;
        dcl-s tQSYRUSRI_Flags int(10) template;
        dcl-s tQSYRUSRI_NumberOfBytesInTheHomeDirectoryName int(10) template;
        dcl-s tQSYRUSRI_HomeDirectoryDelimiter char(2) template;
        dcl-s tQSYRUSRI_HomeDirectoryNameValue char(512) template;
        dcl-s tQSYRUSRI_DaysUntilPasswordExpires int(10) template;
        dcl-s tQSYRUSRI_ObjectAuditingValue char(10) template;
        dcl-s tQSYRUSRI_Reserved10 char(10) template;

        dcl-ds tQSYRUSRI_USRI0100 qualified template;
           BytesReturned  like(tQSYRUSRI_BytesReturned);
           BytesAvailable  like(tQSYRUSRI_BytesAvailable);
           UserProfileName like(tQSYRUSRI_UserProfileName);
           PreviousSignOnDateTime like(tQSYRUSRI_PreviousSignOnDateTime);
           Reserved1 like(tQSYRUSRI_Reserved1);
           SignOnAttemptsNotValid like(tQSYRUSRI_SignOnAttemptsNotValid);
           Status like(tQSYRUSRI_Status);
           PasswordChangeDate like(tQSYRUSRI_PasswordChangeDate);
           NoPasswordIndicator like(tQSYRUSRI_NoPasswordIndicator);
           Reserved2 like(tQSYRUSRI_Reserved1);
           PasswordExpirationInterval like(tQSYRUSRI_PasswordExpirationInterval);
           DatePasswordExpires like(tQSYRUSRI_DatePasswordExpires);
           DaysUntilPasswordExpires like(tQSYRUSRI_DaysUntilPasswordExpires);
           SetPasswordToExpire like(tQSYRUSRI_SetPasswordToExpire);
           DisplaySignOnInformation like(tQSYRUSRI_DisplaySignOnInformation);
           LocalPasswordManagement like(tQSYRUSRI_LocalPasswordManagement);
           BlockPasswordChange like(tQSYRUSRI_BlockPasswordChange);
         end-ds;

         dcl-ds tQSYRUSRI_USRI0200 qualified template;
           BytesReturned  like(tQSYRUSRI_BytesReturned);
           BytesAvailable  like(tQSYRUSRI_BytesAvailable);
           UserProfileName like(tQSYRUSRI_UserProfileName);
           UserClassName like(tQSYRUSRI_UserClassName);
           SpecialAuthorities like(tQSYRUSRI_SpecialAuthorities);
           GroupProfileName like(tQSYRUSRI_GroupProfileName);
           Owner like(tQSYRUSRI_Owner);
           GroupAuthority like(tQSYRUSRI_GroupAuthority);
           LimitCapabilities like(tQSYRUSRI_LimitCapabilities);
           GroupAuthorityType like(tQSYRUSRI_GroupAuthorityType);
           Reserved like(tQSYRUSRI_Reserved3);
           OffsetToArrayOfSupplementalGroups like(tQSYRUSRI_OffsetToArrayOfSupplementalGroups);
           NumberOfSupplementalGroups like(tQSYRUSRI_NumberOfSupplementalGroups);
           SupplementalGroups like(tQSYRUSRI_SupplementalGroups);
         end-ds;

         dcl-ds tQSYRUSRI_USRI0300 qualified template;
           BytesReturned  like(tQSYRUSRI_BytesReturned);
           BytesAvailable  like(tQSYRUSRI_BytesAvailable);
           UserProfileName like(tQSYRUSRI_UserProfileName);
           PreviousSignOnDateTime like(tQSYRUSRI_PreviousSignOnDateTime);
           Reserved like(tQSYRUSRI_Reserved1);
           SignOnAttemptsNotValid like(tQSYRUSRI_SignOnAttemptsNotValid);
           Status like(tQSYRUSRI_Status);
           PasswordChangeDate like(tQSYRUSRI_PasswordChangeDate);
           NoPasswordIndicator like(tQSYRUSRI_NoPasswordIndicator);
           Reserved2 like(tQSYRUSRI_Reserved1);
           PasswordExpirationInterval like(tQSYRUSRI_PasswordExpirationInterval);
           DatePasswordExpires like(tQSYRUSRI_DatePasswordExpires);
           DaysUntilPasswordExpires like(tQSYRUSRI_DaysUntilPasswordExpires);
           SetPasswordToExpire like(tQSYRUSRI_SetPasswordToExpire);
           UserClassName like(tQSYRUSRI_UserClassName);
           SpecialAuthorities like(tQSYRUSRI_SpecialAuthorities);
           GroupProfileName like(tQSYRUSRI_GroupProfileName);
           Owner like(tQSYRUSRI_Owner);
           GroupAuthority like(tQSYRUSRI_GroupAuthority);
           AssistanceLevel like(tQSYRUSRI_AssistanceLevel);
           CurrentLibraryName like(tQSYRUSRI_CurrentLibraryName);
           InitialMenuName like(tQSYRUSRI_InitialMenuName);
           InitialMenuLibraryName like(tQSYRUSRI_InitialMenuLibraryName);
           InitialProgramName like(tQSYRUSRI_InitialProgramName);
           InitialProgramLibraryName like(tQSYRUSRI_InitialProgramLibraryName);
           LimitCapabilities like(tQSYRUSRI_LimitCapabilities);
           TextDescription like(tQSYRUSRI_TextDescription);
           DisplaySignOnInformation like(tQSYRUSRI_DisplaySignOnInformation);
           LimitDeviceSessions like(tQSYRUSRI_LimitDeviceSessions);
           KeyboardBuffering like(tQSYRUSRI_KeyboardBuffering);
           Reserved3 like(tQSYRUSRI_Reserved2);
           MaximumAllowedStorage like(tQSYRUSRI_MaximumAllowedStorage);
           StorageUsed like(tQSYRUSRI_StorageUsed);
           HighestSchedulingPriority like(tQSYRUSRI_HighestSchedulingPriority);
           JobDescriptionName like(tQSYRUSRI_JobDescriptionName);
           JobDescriptionLibraryName like(tQSYRUSRI_JobDescriptionLibraryName);
           AccountingCode like(tQSYRUSRI_AccountingCode);
           MessageQueueName like(tQSYRUSRI_MessageQueueName);
           MessageQueueLibraryName like(tQSYRUSRI_MessageQueueLibraryName);
           MessageQueueDeliveryMethod like(tQSYRUSRI_MessageQueueDeliveryMethod);
           Reserved4 like(tQSYRUSRI_Reserved2);
           MessageQueueSeverity like(tQSYRUSRI_MessageQueueSeverity);
           OutputQueueName like(tQSYRUSRI_OutputQueueName);
           OutputQueueLibraryName like(tQSYRUSRI_OutputQueueLibraryName);
           PrintDevice like(tQSYRUSRI_PrintDevice);
           SpecialEnvironment like(tQSYRUSRI_SpecialEnvironment);
           AttentionKeyHandlingProgramName like(tQSYRUSRI_AttentionKeyHandlingProgramName);
           AttentionKeyHandlingProgramLibraryName like(tQSYRUSRI_AttentionKeyHandlingProgramLibraryName);
           LanguageID like(tQSYRUSRI_LanguageID);
           CountryOrRegionID like(tQSYRUSRI_CountryOrRegionID);
           CharacterCodeSetID like(tQSYRUSRI_CharacterCodeSetID);
           UserOptions like(tQSYRUSRI_UserOptions);
           SortSequenceTableName like(tQSYRUSRI_SortSequenceTableName);
           SortSequenceTableLibraryName like(tQSYRUSRI_SortSequenceTableLibraryName);
           ObjectAuditingValue like(tQSYRUSRI_ObjectAuditingValue);
           UserActionAuditLevel like(tQSYRUSRI_UserActionAuditLevel);
           GroupAuthorityType like(tQSYRUSRI_GroupAuthorityType);
           OffsetToArrayOfSupplementalGroups like(tQSYRUSRI_OffsetToArrayOfSupplementalGroups);
           NumberOfSupplementalGroups like(tQSYRUSRI_NumberOfSupplementalGroups);
           UserIDNumber like(tQSYRUSRI_UserIDNumber);
           GroupIDNumber like(tQSYRUSRI_GroupIDNumber);
           OffsetToHomeDirectory like(tQSYRUSRI_OffsetToHomeDirectory);
           LengthOfHomeDirectory like(tQSYRUSRI_LengthOfHomeDirectory);
           LocaleJobAttributes like(tQSYRUSRI_LocaleJobAttributes);
           OffsetToLocalePathName like(tQSYRUSRI_OffsetToLocalePathName);
           LengthOfLocalePathName like(tQSYRUSRI_LengthOfLocalePathName);
           GroupMemberIndicator like(tQSYRUSRI_GroupMemberIndicator);
           DigitalCertificateIndicator like(tQSYRUSRI_DigitalCertificateIndicator);
           CharacterIdentifierControl like(tQSYRUSRI_CharacterIdentifierControl);
           OffsetToArrayOfIndependentASPStorageUsageDescriptors like(tQSYRUSRI_OffsetToArrayOfIndependentASPStorageUsageDescriptors);
           NumberOfIndependentASPStorageUsageDescriptors like(tQSYRUSRI_NumberOfIndependentASPStorageUsageDescriptors);
           NumberOfIndependentASPStorageUsageDescriptorsReturned like(tQSYRUSRI_NumberOfIndependentASPStorageUsageDescriptorsReturned);
           LengthOfAnIndependentASPStorageUsageDescriptor like(tQSYRUSRI_LengthOfAnIndependentASPStorageUsageDescriptor);
           LocalPasswordManagement like(tQSYRUSRI_LocalPasswordManagement);
           BlockPasswordChange like(tQSYRUSRI_BlockPasswordChange);
           UserEntitlementRequired like(tQSYRUSRI_UserEntitlementRequired);
           UserExpirationInterval like(tQSYRUSRI_UserExpirationInterval);
           UserExpirationDate like(tQSYRUSRI_UserExpirationDate);
           UserExpirationAction like(tQSYRUSRI_UserExpirationAction);
           Reserved5 like(tQSYRUSRI_Reserved2);
           MaximumAllowedStorageLong like(tQSYRUSRI_MaximumAllowedStorageLong);
           StorageUsedLong like(tQSYRUSRI_StorageUsedLong);
           USRI0200_Data like(tQSYRUSRI_USRI0200_Data);
         end-ds;

         dcl-ds tQSYRUSRI_HomeDirectory qualified template;
           CCSIDOfTheReturnedHomeDirectory like(tQSYRUSRI_CCSIDOfTheReturnedHomeDirectory);
           CountryOrRegionID like(tQSYRUSRI_CountryOrRegionID2);
           LanguageID like(tQSYRUSRI_LanguageID3);
           Reserved like(tQSYRUSRI_Reserved3);
           Flags like(tQSYRUSRI_Flags);
           NumberOfBytesInTheHomeDirectoryName like(tQSYRUSRI_NumberOfBytesInTheHomeDirectoryName);
           HomeDirectoryDelimiter like(tQSYRUSRI_HomeDirectoryDelimiter);
           Reserved2 like(tQSYRUSRI_Reserved10);
           HomeDirectoryNameValue like(tQSYRUSRI_HomeDirectoryNameValue);
         end-ds;

        //==========================================================================================
        //             Prototypes
        //==========================================================================================

        dcl-pr RetrieveUserInformation extpgm('QSYRUSRI');
           ReceiverVariable like(tQSYRUSRI_ReceiverVariable) options(*varsize);
           ReceiverVariableLength like(tQSYRUSRI_ReceiverVariableLength) const;
           FormatName like(tQSYRUSRI_FormatName) const;
           UserProfileName like(tQSYRUSRI_UserProfileName) const;
           ErrorCode likeds(tQUSEC);
        end-pr;
