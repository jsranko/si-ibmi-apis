**FREE
/if not defined(QSNDDTAQP)
  /define QSNDDTAQP
/else
  /eof
/endif

//==========================================================================================
// Constant
//==========================================================================================

dcl-c cQSNDDTAQ_Max_Entry_Len const(64512);

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tQSNDDTAQ_DataQueueName char(10) template;
dcl-s tQSNDDTAQ_LibraryName char(10) template;
dcl-s tQSNDDTAQ_LengthOfData packed(5:0) template;
dcl-s tQSNDDTAQ_Data char(cQSNDDTAQ_Max_Entry_Len) template;
dcl-s tQSNDDTAQ_LengthOfKeyData packed(3:0) template;
dcl-s tQSNDDTAQ_KeyData char(cQSNDDTAQ_Max_Entry_Len) template;
dcl-s tQSNDDTAQ_AsynchronousRequest char(10) template;
dcl-s tQSNDDTAQ_DataIsFromAJournalEntry char(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr SendDataQueue extpgm('QSNDDTAQ');
  DataQueueName like(tQSNDDTAQ_DataQueueName) const;
  LibraryName like(tQSNDDTAQ_LibraryName) const;
  LengthOfData like(tQSNDDTAQ_LengthOfData) const;
  Data like(tQSNDDTAQ_Data) const;
  LengthOfKeyData like(tQSNDDTAQ_LengthOfKeyData) const options(*nopass);
  KeyData like(tQSNDDTAQ_KeyData) const options(*nopass);
  AsynchronousRequest like(tQSNDDTAQ_AsynchronousRequest) const options(*nopass);
  DataIsFromAJournalEntry like(tQSNDDTAQ_DataIsFromAJournalEntry) const options(*nopass);
end-pr;
