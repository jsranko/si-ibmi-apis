**FREE
         /if not defined(QUSRJOBIP)
         /define QUSRJOBIP
         /else
         /eof
         /endif

         /include qcpylesrc/qusecp

        //==========================================================================================
        // Constants
        //==========================================================================================

         dcl-c cQUSRJOBI_FORMAT_BasicPerformanceInformation const('JOBI0100');
         dcl-c cQUSRJOBI_FORMAT_AdditionalPerformanceInformation const('JOBI0150');
         dcl-c cQUSRJOBI_FORMAT_JobAttributeInformation const('JOBI0400');

        //==========================================================================================
        // Tempaltes
        //==========================================================================================

         dcl-s tQUSRJOBI_ReceiverVariable char(32767) template;
         dcl-s tQUSRJOBI_LengthOfReceiverVariable int(10) template;
         dcl-s tQUSRJOBI_FormatName char(8) template;
         dcl-s tQUSRJOBI_QualifiedJobName char(26) template;

         dcl-s tQUSRJOBI_BytesReturned int(10) template;
         dcl-s tQUSRJOBI_BytesAvailable int(10) template;
         dcl-s tQUSRJOBI_JobName char(10) template;
         dcl-s tQUSRJOBI_UserName char(10) template;
         dcl-s tQUSRJOBI_JobNumber char(6) template;
         dcl-s tQUSRJOBI_InternalJobIdentifier char(16) template;
         dcl-s tQUSRJOBI_JobStatus char(10) template;
         dcl-s tQUSRJOBI_JobType char(1) template;
         dcl-s tQUSRJOBI_JobSubtype char(1) template;
         dcl-s tQUSRJOBI_Reserved char(2) template;
         dcl-s tQUSRJOBI_RunPriority int(10) template;
         dcl-s tQUSRJOBI_TimeSlice int(10) template;
         dcl-s tQUSRJOBI_DefaultWait int(10) template;
         dcl-s tQUSRJOBI_Purge char(10) template;
         dcl-s tQUSRJOBI_TimesliceEndPool char(10) template;
         dcl-s tQUSRJOBI_ProcessingUnitTime1 int(10) template;
         dcl-s tQUSRJOBI_SystemPoolIdentifier int(10) template;
         dcl-s tQUSRJOBI_MaximumProcessingUnitTimeAllowed int(10) template;
         dcl-s tQUSRJOBI_TemporaryStorageUsed1 int(10) template;
         dcl-s tQUSRJOBI_MaximumTemporaryStorageAllowed1 int(10) template;
         dcl-s tQUSRJOBI_ThreadCount int(10) template;
         dcl-s tQUSRJOBI_MaximumThreads int(10) template;
         dcl-s tQUSRJOBI_TemporaryStorageUsed uns(10) template;
         dcl-s tQUSRJOBI_MaximumTemporaryStorage int(10) template;
         dcl-s tQUSRJOBI_PeakTemporaryStorageUsed uns(10) template;
         dcl-s tQUSRJOBI_ProcessingUnitTimeUsed uns(20) template;
         dcl-s tQUSRJOBI_DateAndTimeJobEnteredSystem char(13) template;
         dcl-s tQUSRJOBI_JobAccountingCode char(15) template;
         dcl-s tQUSRJOBI_JobDescriptionName char(10) template;
         dcl-s tQUSRJOBI_JobDescriptionLibraryName char(10) template;
         dcl-s tQUSRJOBI_UnitOfWorkID char(24) template;
         dcl-s tQUSRJOBI_ModeName char(8) template;
         dcl-s tQUSRJOBI_InquiryMessageReply char(10) template;
         dcl-s tQUSRJOBI_LoggingOfCLPrograms char(10) template;
         dcl-s tQUSRJOBI_BreakMessageHandling char(10) template;
         dcl-s tQUSRJOBI_StatusMessageHandling char(10) template;
         dcl-s tQUSRJOBI_DeviceRecoveryAction char(13) template;
         dcl-s tQUSRJOBI_DDMConversationHandling char(10) template;
         dcl-s tQUSRJOBI_DateSeparator char(1) template;
         dcl-s tQUSRJOBI_DateFormat char(4) template;
         dcl-s tQUSRJOBI_PrintText char(30) template;
         dcl-s tQUSRJOBI_SubmittersJobName char(10) template;
         dcl-s tQUSRJOBI_SubmittersUserName char(10) template;
         dcl-s tQUSRJOBI_SubmittersJobNumber char(6) template;
         dcl-s tQUSRJOBI_SubmittersMessageQueueName char(10) template;
         dcl-s tQUSRJOBI_SubmittersMessageQueueLibraryName char(10) template;
         dcl-s tQUSRJOBI_TimeSeparator char(1) template;
         dcl-s tQUSRJOBI_CodedCharacterSetID int(10) template;
         dcl-s tQUSRJOBI_DateAndTimeJobIsScheduledToRun char(8) template;
         dcl-s tQUSRJOBI_PrintKeyFormat char(10) template;
         dcl-s tQUSRJOBI_SortSequenceTableName char(10) template;
         dcl-s tQUSRJOBI_SortSequenceLibrary char(10) template;
         dcl-s tQUSRJOBI_LanguageID char(3) template;
         dcl-s tQUSRJOBI_CountryOrRegionID char(2) template;
         dcl-s tQUSRJOBI_CompletionStatus char(1) template;
         dcl-s tQUSRJOBI_SignedOnJob char(1) template;
         dcl-s tQUSRJOBI_JobSwitches char(8) template;
         dcl-s tQUSRJOBI_JobMessageQueueFullAction char(10) template;
         dcl-s tQUSRJOBI_Reserved1 char(1) template;
         dcl-s tQUSRJOBI_JobMessageQueueMaximumSize int(10) template;
         dcl-s tQUSRJOBI_DefaultCodedCharacterSetIdentifier int(10) template;
         dcl-s tQUSRJOBI_RoutingData char(80) template;
         dcl-s tQUSRJOBI_DecimalFormat char(1) template;
         dcl-s tQUSRJOBI_CharacterIdentifierControl char(10) template;
         dcl-s tQUSRJOBI_ServerType char(30) template;
         dcl-s tQUSRJOBI_AllowMultipleThreads char(1) template;
         dcl-s tQUSRJOBI_JobLogPending char(1) template;
         dcl-s tQUSRJOBI_JobEndReason int(10) template;
         dcl-s tQUSRJOBI_DateAndTimeJobEnded char(13) template;
         dcl-s tQUSRJOBI_SpooledFileAction char(10) template;
         dcl-s tQUSRJOBI_OffsetToASPGroupInformation int(10) template;
         dcl-s tQUSRJOBI_NumberOfEntriesInASPGroupInformation int(10) template;
         dcl-s tQUSRJOBI_LengthOfOneASPGroupInformationEntry int(10) template;
         dcl-s tQUSRJOBI_TimeZoneDescriptionName char(10) template;
         dcl-s tQUSRJOBI_JobLogOutput char(10) template;
         dcl-s tQUSRJOBI_JobDescriptionLibraryASPDeviceName char(10) template;
         dcl-s tQUSRJOBI_ASPGroupInformationEntry char(3000) template;
         dcl-s tQUSRJOBI_DateAndTimeJobBecameActive char(13) template;
         dcl-s tQUSRJOBI_JobTypeEnhanced int(10) template;

         dcl-ds tQUSRJOBI_JOBI0100 qualified template;
           BytesReturned  like(tQUSRJOBI_BytesReturned);
           BytesAvailable  like(tQUSRJOBI_BytesAvailable);
           JobName like(tQUSRJOBI_JobName);
           UserName like(tQUSRJOBI_UserName);
           JobNumber like(tQUSRJOBI_JobNumber);
           InternalJobIdentifier like(tQUSRJOBI_InternalJobIdentifier);
           JobStatus like(tQUSRJOBI_JobStatus);
           JobType like(tQUSRJOBI_JobType);
           JobSubtype like(tQUSRJOBI_JobSubtype);
           Reserved like(tQUSRJOBI_Reserved);
           RunPriority like(tQUSRJOBI_RunPriority);
           TimeSlice like(tQUSRJOBI_TimeSlice);
           DefaultWait like(tQUSRJOBI_DefaultWait);
           Purge like(tQUSRJOBI_Purge);
         end-ds;

         dcl-ds tQUSRJOBI_JOBI0150 qualified template;
           BytesReturned  like(tQUSRJOBI_BytesReturned);
           BytesAvailable  like(tQUSRJOBI_BytesAvailable);
           JobName like(tQUSRJOBI_JobName);
           UserName like(tQUSRJOBI_UserName);
           JobNumber like(tQUSRJOBI_JobNumber);
           InternalJobIdentifier like(tQUSRJOBI_InternalJobIdentifier);
           JobStatus like(tQUSRJOBI_JobStatus);
           JobType like(tQUSRJOBI_JobType);
           JobSubtype like(tQUSRJOBI_JobSubtype);
           Reserved like(tQUSRJOBI_Reserved);
           RunPriority like(tQUSRJOBI_RunPriority);
           TimeSlice like(tQUSRJOBI_TimeSlice);
           DefaultWait like(tQUSRJOBI_DefaultWait);
           Purge like(tQUSRJOBI_Purge);
           TimesliceEndPool like(tQUSRJOBI_TimesliceEndPool);
           ProcessingUnitTime1 like(tQUSRJOBI_ProcessingUnitTime1);
           SystemPoolIdentifier like(tQUSRJOBI_SystemPoolIdentifier);
           MaximumProcessingUnitTimeAllowed
                                like(tQUSRJOBI_MaximumProcessingUnitTimeAllowed);
           TemporaryStorageUsed1 like(tQUSRJOBI_TemporaryStorageUsed1);
           MaximumTemporaryStorageAllowed1
                                like(tQUSRJOBI_MaximumTemporaryStorageAllowed1);
           ThreadCount like(tQUSRJOBI_ThreadCount);
           MaximumThreads like(tQUSRJOBI_MaximumThreads);
           TemporaryStorageUsed like(tQUSRJOBI_TemporaryStorageUsed);
           MaximumTemporaryStorage like(tQUSRJOBI_MaximumTemporaryStorage);
           PeakTemporaryStorageUsed like(tQUSRJOBI_PeakTemporaryStorageUsed);
           ProcessingUnitTimeUsed like(tQUSRJOBI_ProcessingUnitTimeUsed);
         end-ds;

         dcl-ds tQUSRJOBI_JOBI0400 qualified template;
           BytesReturned like(tQUSRJOBI_BytesReturned);
           BytesAvailable like(tQUSRJOBI_BytesAvailable);
           JobName like(tQUSRJOBI_JobName);
           UserName like(tQUSRJOBI_UserName);
           JobNumber like(tQUSRJOBI_JobNumber);
           InternalJobIdentifier like(tQUSRJOBI_InternalJobIdentifier);
           JobStatus like(tQUSRJOBI_JobStatus);
           JobType like(tQUSRJOBI_JobType);
           JobSubtype like(tQUSRJOBI_JobSubtype);
           DateAndTimeJobEnteredSystem like(tQUSRJOBI_DateAndTimeJobEnteredSystem);
           DateAndTimeJobBecameActive like(tQUSRJOBI_DateAndTimeJobBecameActive);
           JobAccountingCode like(tQUSRJOBI_JobAccountingCode);
           JobDescriptionName like(tQUSRJOBI_JobDescriptionName);
           JobDescriptionLibraryName like(tQUSRJOBI_JobDescriptionLibraryName);
           UnitOfWorkID like(tQUSRJOBI_UnitOfWorkID);
           ModeName like(tQUSRJOBI_ModeName);
           InquiryMessageReply like(tQUSRJOBI_InquiryMessageReply);
           LoggingOfCLPrograms like(tQUSRJOBI_LoggingOfCLPrograms);
           BreakMessageHandling like(tQUSRJOBI_BreakMessageHandling);
           StatusMessageHandling like(tQUSRJOBI_StatusMessageHandling);
           DeviceRecoveryAction like(tQUSRJOBI_DeviceRecoveryAction);
           DDMConversationHandling like(tQUSRJOBI_DDMConversationHandling);
           DateSeparator like(tQUSRJOBI_DateSeparator);
           DateFormat like(tQUSRJOBI_DateFormat);
           PrintText like(tQUSRJOBI_PrintText);
           SubmittersJobName like(tQUSRJOBI_SubmittersJobName);
           SubmittersUserName like(tQUSRJOBI_SubmittersUserName);
           SubmittersJobNumber like(tQUSRJOBI_SubmittersJobNumber);
           SubmittersMessageQueueName like(tQUSRJOBI_SubmittersMessageQueueName);
           SubmittersMessageQueueLibraryName
                               like(tQUSRJOBI_SubmittersMessageQueueLibraryName);
           TimeSeparator like(tQUSRJOBI_TimeSeparator);
           CodedCharacterSetID like(tQUSRJOBI_CodedCharacterSetID);
           DateAndTimeJobIsScheduledToRun like(tQUSRJOBI_DateAndTimeJobIsScheduledToRun);
           PrintKeyFormat like(tQUSRJOBI_PrintKeyFormat);
           SortSequenceTableName like(tQUSRJOBI_SortSequenceTableName);
           SortSequenceLibrary like(tQUSRJOBI_SortSequenceLibrary);
           LanguageID like(tQUSRJOBI_LanguageID);
           CountryOrRegionID like(tQUSRJOBI_CountryOrRegionID);
           CompletionStatus like(tQUSRJOBI_CompletionStatus);
           SignedOnJob like(tQUSRJOBI_SignedOnJob);
           JobSwitches like(tQUSRJOBI_JobSwitches);
           JobMessageQueueFullAction like(tQUSRJOBI_JobMessageQueueFullAction);
           Reserved like(tQUSRJOBI_Reserved1);
           JobMessageQueueMaximumSize like(tQUSRJOBI_JobMessageQueueMaximumSize);
           DefaultCodedCharacterSetIdentifier
                                    like(tQUSRJOBI_DefaultCodedCharacterSetIdentifier);
           RoutingData like(tQUSRJOBI_RoutingData);
           DecimalFormat like(tQUSRJOBI_DecimalFormat);
           CharacterIdentifierControl like(tQUSRJOBI_CharacterIdentifierControl);
           ServerType like(tQUSRJOBI_ServerType);
           AllowMultipleThreads like(tQUSRJOBI_AllowMultipleThreads);
           JobLogPending like(tQUSRJOBI_JobLogPending);
           Reserved2 like(tQUSRJOBI_Reserved1);
           JobEndReason like(tQUSRJOBI_JobEndReason);
           JobTypeEnhanced like(tQUSRJOBI_JobTypeEnhanced);
           DateAndTimeJobEnded like(tQUSRJOBI_DateAndTimeJobEnded);
           Reserved3 like(tQUSRJOBI_Reserved1);
           SpooledFileAction like(tQUSRJOBI_SpooledFileAction);
           OffsetToASPGroupInformation like(tQUSRJOBI_OffsetToASPGroupInformation);
           NumberOfEntriesInASPGroupInformation
                                    like(tQUSRJOBI_NumberOfEntriesInASPGroupInformation);
           LengthOfOneASPGroupInformationEntry
                                    like(tQUSRJOBI_LengthOfOneASPGroupInformationEntry);
           TimeZoneDescriptionName like(tQUSRJOBI_TimeZoneDescriptionName);
           JobLogOutput like(tQUSRJOBI_JobLogOutput);
           JobDescriptionLibraryASPDeviceName
                                    like(tQUSRJOBI_JobDescriptionLibraryASPDeviceName);
           ASPGroupInformationEntry like(tQUSRJOBI_ASPGroupInformationEntry);
         end-ds;

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr RetrieveJobInformation extpgm('QUSRJOBI');
           ReceiverVariable like(tQUSRJOBI_ReceiverVariable) const;
           LengthOfReceiverVariable like(tQUSRJOBI_LengthOfReceiverVariable) const;
           IFormatName like(tQUSRJOBI_FormatName) const;
           QualifiedJobName like(tQUSRJOBI_QualifiedJobName) const;
           InternalJobIdentifier like(tQUSRJOBI_InternalJobIdentifier) const;
           ErrorCode likeds(tQUSEC);
         end-pr;

