**FREE

/if not defined(FIDSP)
  /define FIDSP
/else
  /eof
/endif

//==========================================================================================
// Templates
//==========================================================================================

// File Feedback Information

dcl-ds tFIDS_FileFeedback qualified template;
  Filename char(8) pos(1); // File name
  FileOpen ind pos(9); // File open?
  FileAtEOF ind pos(10); // File at eof?
  StatusCode zoned(5:0) pos(11); // Status code
  LastOPCode char(6) pos(16); // Last opcode
  RPGRoutine char(8) pos(22); // RPG Routine
  ListingLine char(8) pos(30); // Listing line
  SpecialStatus zoned(5) pos(38); // SPECIAL status
  RecordName char(8) pos(38); // Record name
  ErrorMSGID char(7) pos(46); // Error MSGID
  ScreenSize zoned(4:0) pos(67); // Screen size
  NLSInput zoned(2:0) pos(71); // NLS Input?
  NLSOutput zoned(2:0) pos(73); // NLS Output?
  NLSMode zoned(2:0) pos(75); // NLS Mode?
  SourceId int(5) pos(77);  // Source Id matching the statement number from positions
end-ds;

// Open Feedback Information

dcl-ds tFIDS_OpenFeedback qualified template;
  ODPType char(2) pos(81);
  Filename char(10) pos(83);
  Libraryname char(10) pos(93);
  SpoolFileName char(10) pos(103);
  SpoolFileLib char(10) pos(113);
  SpoolFileNumber int(5) pos(123);
  MaxRecordLength int(5) pos(125);
  MaxKeyLength int(5) pos(127);
  MemberName char(10) pos(129);
  FileType int(5) pos(147);
  NumberRows int(5) pos(152); // Num PRT/DSP rows
  NumberColumns int(5) pos(154); // Num PRT/DSP cols
  NumberOfRecords int(10) pos(156);
  SpoolNumber int(10) pos(160);    // 6 digit Spool Nbr
  AccessType char(2) pos(160);
  DuplicateKey char(1) pos(162); // Duplicate key?
  SourceFile char(1) pos(163);
  VolumeLabelOffset int(5) pos(184);
  MaxRecordsInBlok int(5) pos(186);
  OverflowLine int(5) pos(188);
  BlockIncrement int(5) pos(190);
  MiscFlags char(1) pos(196);
  RequesterName char(10) pos(197);
  OpenCount int(5) pos(207);
  NumberBasedMembers int(5) pos(211);
  MiscFlags2 char(1) pos(213);
  OpenIdentifier char(2) pos(214);
  MaxRecordFormatLength int(5) pos(216);
  DatabaseCCSID int(5) pos(218);
  MiscFlags3 char(1) pos(220);
  NumberDevicesDefined int(5) pos(227);
end-ds;

// Input/Output Feedback Information

dcl-ds tFIDS_InputOutputFeedback qualified template;
  WriteCount uns(10) pos(243);
  ReadCount uns(10) pos(247);
  WriteReadCount uns(10) pos(251);
  OtherIOCount int(10) pos(255);
  CurrentOperation char(1) pos(260);
  RecordFormatName char(10) pos(261);
  DeviceClass char(2) pos(271);
  ProgramDeviceName char(10) pos(273);
  RecordLengthOfIO int(10) pos(283);
end-ds;

// Printer Specific Feedback Information

dcl-ds tFIDS_PrinterFeedback qualified template;
  CurrentLineNumber int(5) pos(367);
  CurrentPage int(10) pos(369); // Current page cnt
  // If the first bit of PRT_FLAGS is on, the spooled file has been
  // deleted.  Use TESTB X'80' or TESTB '0' to test this bit.
  PrintFlags char(1) pos(373);
  MajorReturnCode char(2) pos(401);
  MinorReturnCode char(2) pos(403);
end-ds;

// Database Specific Feedback Information

dcl-ds tFIDS_DatabaseFeedback qualified template;
  CurrentLineNumber int(10) pos(367);
  JFILEBits int(10) pos(371);
  NumberLockedRecords int(5) pos(377);
  FilePosBits char(1) pos(385);
  RecordDeletedBits char(1) pos(384);
  NumberKeys int(5) pos(387);
  KeyLength int(5) pos(393);
  MemberNumber int(5) pos(395);
  RelativeRecordNumber int(10) pos(397);
  KeyValue char(2000) pos(401);
end-ds;

// ICF Specific Feedback Information

dcl-ds tFIDS_ICFFeedback qualified template;
  AIDByte char(1) pos(369);
  ActualDataLength int(10) pos(372);
  MajorReturnCode char(2) pos(401);
  MinorReturnCode char(2) pos(403);
  SNASenseReturnCode char(8) pos(405);
  SafeIndicator char(1) pos(413);
  RequestWrite char(1) pos(415);
  RemoteRecordFormat char(10) pos(416);
  ModeName char(8) pos(430);
end-ds;

// Display Specific Feedback Information

dcl-ds tFIDS_DisplayFeedback qualified template;
  DisplayFlags char(2) pos(367);
  AIDByte char(1) pos(369);
  CursorLocation char(2) pos(370);
  ActualDataLength int(10) pos(372);
  SubfileRRN int(5) pos(376);
  SubfileMinRRN int(5) pos(378);
  SubfileNumberRecords int(5) pos(380);
  ActiveWindowCursorLocation char(2) pos(382);
  MajorReturnCode char(2) pos(401);
  MinorReturnCode char(2) pos(403);
end-ds;

// Display file Get Attributes Feedback Information

dcl-ds tFIDS_DisplayAttributesFeedback qualified template;
  ProgramDevice char(10) pos(241);
  DeviceDesc char(10) pos(251);
  UserID char(10) pos(261);
  DeviceClass char(1) pos(271);
  DeviceType char(6) pos(272);
  Requester char(1) pos(278);
  AcquireStatus char(1) pos(279);
  InviteStatus char(1) pos(280);
  DataAvailable char(1) pos(281);
  NumberOfRows int(5) pos(282);
  NumberOfColumns int(5) pos(284);
  AllowBlink char(1) pos(286);
  OnlineOffline char(1) pos(287);
  DisplayLocation char(1) pos(288);
  DisplayType char(1) pos(289);
  KeyboardType char(1) pos(290);
  ControllerInfo char(1) pos(342);
  ColorCapable char(1)  pos(343);
  GridLineDisplay char(1) pos(344);
  // The following fields apply to ISDN.
  ISDNLength int(5) pos(385); // Rmt number len
  ISDNType char(2) pos(387); // Rmt number type
  ISDNPlan char(2) pos(389); // Rmt number plan
  ISDNNumber char(40) pos(391); // Rmt number
  ISDNSubAddressLength int(5) pos(435);
  ISDNSubAddressType char(2) pos(437);
  ISDNSubAddress char(40) pos(439);
  ISDNConnection char(1) pos(480);
  ISDNAddressLength int(5) pos(481);
  ISDNAddress char(32) pos(483);
  ISDNExtensionLength int(5) pos(519);
  ISDNExtensionType char(1) pos(521);
  ISDNNumber2 char(40) pos(522);
  ISDNX25CallType char(1) pos(566);
end-ds;
