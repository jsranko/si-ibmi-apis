**FREE

/if not defined(RECIOP)
  /define RECIOP
/else
  /eof
/endif

//==========================================================================================
// Constants
//==========================================================================================

//
dcl-c cRECIO_EOF const(-1);

// Default to __KEY_EQ and lock the record for update if the file is open for updating.
dcl-c cRECIO_DFT const(x'0B000100');

// Positions to just after the last record in a file. There is no record that is associated with this position.
dcl-c cRECIO_END const(x'02000004');

// Positions to just after the last record in a file. All buffered changes are made permanent. There is no record that is associated with this position.
dcl-c cRECIO_END_FRC const(x'04000004');

// Positions to the first record in the access path that is currently being used by fp. The key parameter is ignored.
dcl-c cRECIO_FIRST const(x'01000300');

// Positions to the first record with the specified key.
dcl-c cRECIO_KEY_EQ const(x'0B000100');

// Positions to the first record that has a key greater than or equal to the specified key.
dcl-c cRECIO_KEY_GE const(x'0C000100');

// Positions to the first record that has a key greater than the specified key.
dcl-c cRECIO_KEY_GT const(x'0D000100');

// Positions to the first record that has a key less than or equal to the specified key.
dcl-c cRECIO_KEY_LE const(x'0A000100');

// Positions to the first record that has a key less than the specified key.
dcl-c cRECIO_KEY_LT const(x'09000100');

// Positions to the next record that has a key equal to the key value with a length of klen_rrn, at the current position. The key parameter is ignored.
dcl-c cRECIO_KEY_NEXTEQ const(x'0E000100');

// Positions to the next record with a unique key from the current position in the access path. The key parameter is ignored.
dcl-c cRECIO_KEY_NEXTUNQ const(x'05000100');

// Positions to the previous record with a key equal to the key value with a length of klen_rrn, at the current position. The key parameter is ignored.
dcl-c cRECIO_KEY_PREVEQ const(x'0F000100');

// Positions to the previous record with a unique key from the current position in the access path. The key parameter is ignored.
dcl-c cRECIO_KEY_PREVUNQ const(x'06000100');

// Positions to the last record in the access path that is currently being used by fp. The key parameter is ignored.
dcl-c cRECIO_LAST const(x'02000300');

// Positions to the next record in the access path that is currently being used by fp. The key parameter is ignored.
dcl-c cRECIO_NEXT const(x'03000300');

// Positions to the previous record in the access path that is currently being used by fp. The key parameter is ignored.
dcl-c cRECIO_PREVIOUS const(x'04000300');

// Positions to the record that has the relative record number specified on the klen_rrn parameter.
dcl-c cRECIO_RRN_EQ const(x'08000300');

// Positions to just before the first record in the file. There is no record that is associated with this position.
dcl-c cRECIO_START const(x'01000004');

// Positions to just before the first record in a file. There is no record that is associated with this position. All buffered changes are made permanent.
dcl-c cRECIO_START_FRC const(x'03000004');

// Positions to data records only. Deleted records will be ignored.
dcl-c cRECIO_DATA_ONLY const(x'00000002');

// The NULL key map is to be considered when locating to a record by key.
dcl-c cRECIO_KEY_NULL_MAP const(x'00000008');

// The record that is positioned will not be locked.
dcl-c cRECIO_NO_LOCK const(x'00000001');

// The position of the file is not changed, but the located record will be locked if the file is open for update.
dcl-c cRECIO_NO_POSITION const(x'00100000');

// Positions to just before the requested record.
dcl-c cRECIO_PRIOR const(x'00001000');

// Open an existing file for reading records.
dcl-c cRECIO_READ_ONLY const('rr');

// Open an existing file for writing records. If the file contains data, the content is cleared unless the file is a logical file.
dcl-c cRECIO_CLEAR_AND_WRITE const('wr');

// Open an existing file for writing records to the end of the file (append).
dcl-c cRECIO_WRITE_AND_APPEND const('ar');

// Open an existing file for reading, writing or updating records.
dcl-c cRECIO_READ_WRITE_AND_UPDATE const('rr+');

// Open an existing file for reading, writing or updating records. If the file contains data, the content is cleared unless the file is a logical file.
dcl-c cRECIO_CLAER_READ_WRITE_AND_UPDATE const('wr+');

// Open an existing file for reading and writing records. All data is written to the end of the file.
dcl-c cRECIO_READ_WRITE_AND_APPEND const('ar+');

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tRECIO_SYSindara char(99) template;

dcl-ds tRECIO_XXIOPFB qualified template;
  file_dep_fb_offset int(5);
  write_count int(10);
  read_count int(10);
  write_read_count int(10);
  other_io_count int(10);
  reserved1 char(1);
  cur_operation char(1);
  rec_format char(10);
  dev_class char(2);
  dev_name char(10);
  last_io_rec_len int(10);
  reserved2 char(80);
  num_recs_retrieved int(5);
  last_io_rec_len2 int(5);
  reserved3 char(2);
  cur_blk_count int(10);
  reserved4 char(8);
end-ds;

dcl-ds tRECIO_XXIOFB_DB qualified template;
  db_fdbk_size uns(10);
  join_default_flags char(4);
  reserved1 char(2);
  num_locked_recs int(5);
  fields_in_fmt int(5);
  reserved2 char(4);
  reserved3 char(1);
  deleted_rec_ind char(1);
  num_key_fields int(5);
  reserved4 char(4);
  key_len int(5);
  data_mbr_num int(5);
  data_mbr_RRN uns(10);
  key_value char(32768);
end-ds;

dcl-ds tRECIO_RIOFB qualified template;
  key pointer;
  sysparm pointer;
  rrn uns(10);
  num_bytes int(10);
  blkCount int(5);
  blkFilledBy char(1);
  dupKey char(1);
  reserved2 char(20);
end-ds;

dcl-ds tRECIO_RFile qualified template;
  reserved1 pointer;
  in_buf pointer;
  out_buf pointer;
  reserved2 pointer;
end-ds;

