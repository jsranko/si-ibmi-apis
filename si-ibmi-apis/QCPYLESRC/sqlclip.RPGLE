**FREE

/if not defined(SQLCLIP)
  /define SQLCLIP
/else
  /eof
/endif

//==========================================================================================
// Constants
//==========================================================================================


//==========================================================================================
// Templates
//==========================================================================================

dcl-s tRwrread_Size int(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

//
// General purpose constants
//
dcl-c SQL_FALSE const(0);
dcl-c SQL_TRUE const(1);
dcl-c SQL_NTS const(-3);
dcl-c SQL_SQLSTATE_SIZE const(5);
dcl-c SQL_MAX_MESSAGE_LENGTH const(512);
dcl-c SQL_MAX_OPTION_STRING_LENGTH const(128);

//
// return values
//
dcl-c SQL_SUCCESS const(0);
dcl-c SQL_SUCCESS_WITH_INFO const(1);
dcl-c SQL_NO_DATA_FOUND const(100);
dcl-c SQL_NEED_DATA const(99);
dcl-c SQL_NO_DATA const(100);
dcl-c SQL_ERROR const(-1);
dcl-c SQL_INVALID_HANDLE const(-2);
dcl-c SQL_STILL_EXECUTING const(2);
dcl-c SQL_ROW_SUCCESS const(0);
dcl-c SQL_ROW_NOROW const(-1);

//
// values for SQLFreeStmt
//
dcl-c SQL_CLOSE const(0);
dcl-c SQL_DROP  const(1);
dcl-c SQL_UNBIND const(2);
dcl-c SQL_RESET_PARAMS const(3);

//
//  SQLSetParam defines
//
dcl-c SQL_C_DEFAULT const(99);

//
// SqlEndTran option values
//
dcl-c SQL_COMMIT const(0);
dcl-c SQL_ROLLBACK const(1);
dcl-c SQL_COMMIT_HOLD const(2);
dcl-c SQL_ROLLBACK_HOLD const(3);
dcl-c SQL_SAVEPOINT_NAME_RELEASE const(4);
dcl-c SQL_SAVEPOINT_NAME_ROLLBACK const(5);

//
// SQLDriverConnect option values
//
dcl-c SQL_DRIVER_COMPLETE const(1);
dcl-c SQL_DRIVER_COMPLETE_REQUIRED const(1);
dcl-c SQL_DRIVER_NOPROMPT const(1);
dcl-c SQL_DRIVER_PROMPT const(0);

//
// Valid option codes for GetInfo procedure
//
dcl-c SQL_ACTIVE_CONNECTIONS const(0);
dcl-c SQL_MAX_DRIVER_CONNECTIONS const(0);
dcl-c SQL_MAX_CONCURRENT_ACTIVITIES const(1);
dcl-c SQL_ACTIVE_STATEMENTS const(1);
dcl-c SQL_PROCEDURES const(2);
dcl-c SQL_DRIVER_NAME const(6);
dcl-c SQL_ODBC_API_CONFORMANCE const(9);
dcl-c SQL_ODBC_SQL_CONFORMANCE const(10);
dcl-c SQL_DBMS_NAME const(17);
dcl-c SQL_DBMS_VER const(18);
dcl-c SQL_DRIVER_VER const(18);
dcl-c SQL_IDENTIFIER_CASE const(28);
dcl-c SQL_IDENTIFIER_QUOTE_CHAR const(29);
dcl-c SQL_MAX_COLUMN_NAME_LEN const(30);
dcl-c SQL_MAX_CURSOR_NAME_LEN const(31);
dcl-c SQL_MAX_OWNER_NAME_LEN const(32);
dcl-c SQL_MAX_SCHEMA_NAME_LEN const(33);
dcl-c SQL_MAX_TABLE_NAME_LEN const(35);
dcl-c SQL_MAX_COLUMNS_IN_GROUP_BY const(36);
dcl-c SQL_MAX_COLUMNS_IN_ORDER_BY const(37);
dcl-c SQL_MAX_COLUMNS_IN_SELECT const(38);
dcl-c SQL_MAX_COLUMNS_IN_TABLE const(39);
dcl-c SQL_MAX_TABLES_IN_SELECT const(40);
dcl-c SQL_COLUMN_ALIAS const(41);
dcl-c SQL_DATA_SOURCE_NAME const(42);
dcl-c SQL_DATABASE_NAME const(42);
dcl-c SQL_MAX_COLUMNS_IN_INDEX const(43);
dcl-c SQL_PROCEDURE_TERM const(44);
dcl-c SQL_QUALIFIER_TERM const(45);
dcl-c SQL_TXN_CAPABLE const(46);
dcl-c SQL_OWNER_TERM const(47);
dcl-c SQL_DATA_SOURCE_READ_ONLY const(48);
dcl-c SQL_DEFAULT_TXN_ISOLATION const(49);
dcl-c SQL_MULTIPLE_ACTIVE_TXN const(55);
dcl-c SQL_QUALIFIER_NAME_SEPARATOR const(65);
dcl-c SQL_CORRELATION_NAME const(74);
dcl-c SQL_NON_NULLABLE_COLUMNS const(75);
dcl-c SQL_DRIVER_ODBC_VER const(77);
dcl-c SQL_GROUP_BY const(88);
dcl-c SQL_ORDER_BY_COLUMNS_IN_SELECT const(90);
dcl-c SQL_OWNER_USAGE const(91);
dcl-c SQL_QUALIFIER_USAGE const(92);
dcl-c SQL_QUOTED_IDENTIFIER_CASE const(93);
dcl-c SQL_MAX_ROW_SIZE const(104);
dcl-c SQL_QUALIFIER_LOCATION const(114);
dcl-c SQL_MAX_CATALOG_NAME_LEN const(115);
dcl-c SQL_MAX_STATEMENT_LEN const(116);
dcl-c SQL_SEARCH_PATTERN_ESCAPE const(117);
dcl-c SQL_OUTER_JOINS const(118);
dcl-c SQL_LIKE_ESCAPE_CLAUSE const(119);
dcl-c SQL_CATALOG_NAME const(120);
dcl-c SQL_DESCRIBE_PARAMETER const(121);
dcl-c SQL_STRING_FUNCTIONS const(50);
dcl-c SQL_NUMERIC_FUNCTIONS const(51);
dcl-c SQL_CONVERT_FUNCTIONS const(52);
dcl-c SQL_TIMEDATE_FUNCTIONS const(53);
dcl-c SQL_SQL92_PREDICATES const(160);
dcl-c SQL_SQL92_VALUE_EXPRESSIONS const(165);
dcl-c SQL_AGGREGATE_FUNCTIONS const(169);
dcl-c SQL_SQL_CONFORMANCE const(170);
dcl-c SQL_CONVERT_CHAR const(171);
dcl-c SQL_CONVERT_NUMERIC const(172);
dcl-c SQL_CONVERT_DECIMAL const(173);
dcl-c SQL_CONVERT_INTEGER const(174);
dcl-c SQL_CONVERT_SMALLINT const(175);
dcl-c SQL_CONVERT_FLOAT const(176);
dcl-c SQL_CONVERT_REAL const(177);
dcl-c SQL_CONVERT_DOUBLE const(178);
dcl-c SQL_CONVERT_VARCHAR const(179);
dcl-c SQL_CONVERT_LONGVARCHAR const(180);
dcl-c SQL_CONVERT_BINARY const(181);
dcl-c SQL_CONVERT_VARBINARY const(182);
dcl-c SQL_CONVERT_BIT const(183);
dcl-c SQL_CONVERT_TINYINT const(184);
dcl-c SQL_CONVERT_BIGINT const(185);
dcl-c SQL_CONVERT_DATE const(186);
dcl-c SQL_CONVERT_TIME const(187);
dcl-c SQL_CONVERT_TIMESTAMP const(188);
dcl-c SQL_CONVERT_LONGVARBINARY const(189);
dcl-c SQL_CONVERT_INTERVAL_YEAR_MONTH const(190);
dcl-c SQL_CONVERT_INTERVAL_DAY_TIME const(191);
dcl-c SQL_CONVERT_WCHAR const(192);
dcl-c SQL_CONVERT_WLONGVARCHAR const(193);
dcl-c SQL_CONVERT_WVARCHAR const(194);
dcl-c SQL_CONVERT_BLOB const(195);
dcl-c SQL_CONVERT_CLOB const(196);
dcl-c SQL_CONVERT_DBCLOB const(197);
dcl-c SQL_CURSOR_COMMIT_BEHAVIOR const(198);
dcl-c SQL_CURSOR_ROLLBACK_BEHAVIOR const(199);
dcl-c SQL_POSITIONED_STATEMENTS const(200);
dcl-c SQL_KEYWORDS const(201);
dcl-c SQL_CONNECTION_JOB_NAME const(202);

//
// Aliased option codes (ODBC 3.0)
//
dcl-c SQL_SCHEMA_TERM const(47);
dcl-c SQL_SCHEMA_USAGE const(91);
dcl-c SQL_CATALOG_LOCATION const(114);
dcl-c SQL_CATALOG_TERM const(45);
dcl-c SQL_CATALOG_USAGE const(92);
dcl-c SQL_CATALOG_NAME_SEPARATOR const(65);

//
// Output values for SQL_ODBC_API_CONFORMANCE
// info type in SQLGetInfo
//
dcl-c SQL_OAC_NONE const(0);
dcl-c SQL_OAC_LEVEL1 const(1);
dcl-c SQL_OAC_LEVEL2 const(2);

//
// Output values for SQL_ODBC_SQL_CONFORMANCE
// info type in SQLGetInfo
//
dcl-c SQL_OSC_MINIMUM const(0);
dcl-c SQL_OSC_CORE const(1);
dcl-c SQL_OSC_EXTENDED const(2);

//
// Output values for SQL_QUALIFIER_USAGE
// info type in SQLGetInfo
//
dcl-c SQL_QU_NOT_SUPPORTED const(x'00000000');
dcl-c SQL_QU_DML_STATEMENTS const(x'00000001');
dcl-c SQL_QU_PROCEDURE_INVOCATION const(x'00000002');
dcl-c SQL_QU_TABLE_DEFINITION const(x'00000004');
dcl-c SQL_QU_INDEX_DEFINITION const(x'00000008');
dcl-c SQL_QU_PRIVILEGE_DEFINITION const(x'00000010');

//
// Output values for SQL_QUALIFIER_LOCATION
// info type in SQLGetInfo
//
dcl-c SQL_QL_START const(1);
dcl-c SQL_QL_END const(2);

//
// Output values for SQL_OWNER_USAGE
// info type in SQLGetInfo
//
dcl-c SQL_OU_DML_STATEMENTS const(x'00000001');
dcl-c SQL_OU_PROCEDURE_INVOCATION const(x'00000002');
dcl-c SQL_OU_TABLE_DEFINITION const(x'00000004');
dcl-c SQL_OU_INDEX_DEFINITION const(x'00000008');
dcl-c SQL_OU_PRIVILEGE_DEFINITION const( x'00000010');

//
// Output values for SQL_TXN_CAPABLE
// info type in SQLGetInfo
//
dcl-c SQL_TC_NONE const(0);
dcl-c SQL_TC_DML const(1);
dcl-c SQL_TC_ALL const(2);
dcl-c SQL_TC_DDL_COMMIT const(3);
dcl-c SQL_TC_DDL_IGNORE const(4);

//
// Output values for SQL_DEFAULT_TXN_ISOLATION
// info type in SQLGetInfo
//
dcl-c SQL_TXN_READ_UNCOMMITTED_MASK const(x'00000001');
dcl-c SQL_TXN_READ_COMMITTED_MASK const(x'00000002');
dcl-c SQL_TXN_REPEATABLE_READ_MASK const(x'00000004');
dcl-c SQL_TXN_SERIALIZABLE_MASK const(x'00000008');

//
// Output values for SQL_STRING_FUNCTIONS
// info type in SQLGetInfo
//
dcl-c SQL_FN_STR_CONCAT const(x'00000001');
dcl-c SQL_FN_STR_UCASE const(x'00000002');
dcl-c SQL_FN_STR_LCASE const(x'00000004');
dcl-c SQL_FN_STR_SUBSTRING const(x'00000008');
dcl-c SQL_FN_STR_LENGTH const(x'00000010');
dcl-c SQL_FN_STR_POSITION const(x'00000020');
dcl-c SQL_FN_STR_LTRIM const(x'00000040');
dcl-c SQL_FN_STR_RTRIM const(x'00000080');

//
// Output values for SQL_NUMERIC_FUNCTIONS
// info type in SQLGetInfo
//
dcl-c SQL_FN_NUM_ABS const(x'00000001');
dcl-c SQL_FN_NUM_ACOS const(x'00000002');
dcl-c SQL_FN_NUM_ASIN const(x'00000004' );
dcl-c SQL_FN_NUM_ATAN const(x'00000008');
dcl-c SQL_FN_NUM_ATAN2 const(x'00000010');
dcl-c SQL_FN_NUM_CEILING const(x'00000020');
dcl-c SQL_FN_NUM_COS const(x'00000040');
dcl-c SQL_FN_NUM_COT const(x'00000080');
dcl-c SQL_FN_NUM_EXP const(x'00000100');
dcl-c SQL_FN_NUM_FLOOR const(x'00000200');
dcl-c SQL_FN_NUM_LOG const(x'00000400');
dcl-c SQL_FN_NUM_MOD const(x'00000800');
dcl-c SQL_FN_NUM_SIGN const(x'00001000');
dcl-c SQL_FN_NUM_SIN const(x'00002000');
dcl-c SQL_FN_NUM_SQRT const(x'00004000');
dcl-c SQL_FN_NUM_TAN const(x'00008000');
dcl-c SQL_FN_NUM_PI const(x'00010000');
dcl-c SQL_FN_NUM_RAND const(x'00020000');
dcl-c SQL_FN_NUM_DEGREES const(x'00040000');
dcl-c SQL_FN_NUM_LOG10 const(x'00080000');
dcl-c SQL_FN_NUM_POWER const(x'00100000');
dcl-c SQL_FN_NUM_RADIANS const(x'00200000');
dcl-c SQL_FN_NUM_ROUND const(x'00400000');
dcl-c SQL_FN_NUM_TRUNCATE const(x'00800000');

//
// SQL_SQL92_VALUE_EXPRESSIONS bitmasks
//
dcl-c SQL_SVE_CASE const(x'00000001');
dcl-c SQL_SVE_CAST const(x'00000002');
dcl-c SQL_SVE_COALESCE const(x'00000004');
dcl-c SQL_SVE_NULLIF const(x'00000008');

//
// SQL_SQL92_PREDICATES bitmasks
//
dcl-c SQL_SP_EXISTS const(x'00000001');
dcl-c SQL_SP_ISNOTNULL const(x'00000002');
dcl-c SQL_SP_ISNULL const(x'00000004');
dcl-c SQL_SP_MATCH_FULL const(x'00000008');
dcl-c SQL_SP_MATCH_PARTIAL const(x'00000010');
dcl-c SQL_SP_MATCH_UNIQUE_FULL const(x'00000020');
dcl-c SQL_SP_MATCH_UNIQUE_PARTIAL const(x'00000040');
dcl-c SQL_SP_OVERLAPS const(x'00000080');
dcl-c SQL_SP_UNIQUE const(x'00000100');
dcl-c SQL_SP_LIKE const(x'00000200');
dcl-c SQL_SP_IN const(x'00000400');
dcl-c SQL_SP_BETWEEN const(x'00000800');
dcl-c SQL_SP_COMPARISON const(x'00001000');
dcl-c SQL_SP_QUANTIFIED_COMPARISON const(x'00002000');

//
// SQL_SQL92_AGGREGATE_FUNCTIONS bitmasks
//
dcl-c SQL_AF_AVG const(x'00000001');
dcl-c SQL_AF_COUNT const(x'00000002');
dcl-c SQL_AF_MAX const(x'00000004');
dcl-c SQL_AF_MIN const(x'00000008');
dcl-c SQL_AF_SUM const(x'00000010');
dcl-c SQL_AF_DISTINCT const(x'00000020');
dcl-c SQL_AF_ALL const(x'00000040');

//
// SQL_SQL_CONFORMANCE bitmasks
//
dcl-c SQL_SC_SQL92_ENTRY const(x'00000001');
dcl-c SQL_SC_FIPS127_2_TRANSITIONAL const(x'00000002');
dcl-c SQL_SC_SQL92_INTERMEDIATE const(x'00000004');
dcl-c SQL_SC_SQL92_FULL const(x'00000008');

//
// SQL_CONVERT_FUNCTIONS bitmasks
//
dcl-c SQL_FN_CVT_CONVERT const(x'00000001');
dcl-c SQL_FN_CVT_CAST const(x'00000002');

//
// SQL_POSITIONED_STATEMENTS bitmasks
//
dcl-c SQL_PS_POSITIONED_DELETE const(x'00000001');
dcl-c SQL_PS_POSITIONED_UPDATE const(x'00000002');
dcl-c SQL_PS_SELECT_FOR_UPDATE const(x'00000004');

//
// SQL supported conversion bitmasks
//
dcl-c SQL_CVT_CHAR const(x'00000001');
dcl-c SQL_CVT_NUMERIC const(x'00000002');
dcl-c SQL_CVT_DECIMAL const(x'00000004');
dcl-c SQL_CVT_INTEGER const(x'00000008');
dcl-c SQL_CVT_SMALLINT const(x'00000010');
dcl-c SQL_CVT_FLOAT const(x'00000020');
dcl-c SQL_CVT_REAL const(x'00000040');
dcl-c SQL_CVT_DOUBLE const(x'00000080');
dcl-c SQL_CVT_VARCHAR const(x'00000100');
dcl-c SQL_CVT_LONGVARCHAR const(x'00000200');
dcl-c SQL_CVT_BINARY const(x'00000400');
dcl-c SQL_CVT_VARBINARY const(x'00000800');
dcl-c SQL_CVT_BIT const(x'00001000');
dcl-c SQL_CVT_TINYINT const(x'00002000');
dcl-c SQL_CVT_BIGINT const(x'00004000');
dcl-c SQL_CVT_DATE const(x'00008000');
dcl-c SQL_CVT_TIME const(x'00010000');
dcl-c SQL_CVT_TIMESTAMP const(x'00020000');
dcl-c SQL_CVT_LONGVARBINARY const(x'00040000');
dcl-c SQL_CVT_INTERVAL_YEAR_MONTH const(x'00080000');
dcl-c SQL_CVT_INTERVAL_DAY_TIME const(x'00100000');
dcl-c SQL_CVT_WCHAR const(x'00200000');
dcl-c SQL_CVT_WLONGVARCHAR const(x'00400000');
dcl-c SQL_CVT_WVARCHAR const(x'00800000');
dcl-c SQL_CVT_BLOB const(x'01000000');
dcl-c SQL_CVT_CLOB const(x'02000000');
dcl-c SQL_CVT_DBCLOB const(x'04000000');

//
// SQL_TIMEDATE_FUNCTIONS bitmasks
//
dcl-c SQL_FN_TD_NOW const(x'00000001');
dcl-c SQL_FN_TD_CURDATE const(x'00000002');
dcl-c SQL_FN_TD_DAYOFMONTH const(x'00000004');
dcl-c SQL_FN_TD_DAYOFWEEK const(x'00000008');
dcl-c SQL_FN_TD_DAYOFYEAR const(x'00000010');
dcl-c SQL_FN_TD_MONTH const(x'00000020');
dcl-c SQL_FN_TD_QUARTER const(x'00000040');
dcl-c SQL_FN_TD_WEEK const(x'00000080');
dcl-c SQL_FN_TD_YEAR const(x'00000100');
dcl-c SQL_FN_TD_CURTIME const(x'00000200');
dcl-c SQL_FN_TD_HOUR const(x'00000400');
dcl-c SQL_FN_TD_MINUTE const(x'00000800');
dcl-c SQL_FN_TD_SECOND const(x'00001000');
dcl-c SQL_FN_TD_TIMESTAMPADD const(x'00002000');
dcl-c SQL_FN_TD_TIMESTAMPDIFF const(x'00004000');
dcl-c SQL_FN_TD_DAYNAME const(x'00008000');
dcl-c SQL_FN_TD_MONTHNAME const(x'00010000');
dcl-c SQL_FN_TD_CURRENT_DATE const(x'00020000');
dcl-c SQL_FN_TD_CURRENT_TIME const(x'00040000');
dcl-c SQL_FN_TD_CURRENT_TIMESTAMP const(x'00080000');
dcl-c SQL_FN_TD_EXTRACT const(x'00100000');

//
// Output values for SQL_CORRELATION_NAME
// info type in SQLGetInfo
//
dcl-c SQL_CN_NONE const(0);
dcl-c SQL_CN_DIFFERENT const(1);
dcl-c SQL_CN_ANY const(2);

//
// Output values for SQL_IDENTIFIER_CASE
// info type in SQLGetInfo
//
dcl-c SQL_IC_UPPER const(1);
dcl-c SQL_IC_LOWER const(2);
dcl-c SQL_IC_SENSITIVE const(3);
dcl-c SQL_IC_MIXED const(4);

//
// Output values for SQL_NON_NULLABLE_COLUMNS
// info type in SQLGetInfo
//
dcl-c SQL_NNC_NULL const(0);
dcl-c SQL_NNC_NON_NULL const(1);

//
// Output values for SQL_GROUP_BY
// info type in SQLGetInfo
//
dcl-c SQL_GB_NO_RELATION const(0);
dcl-c SQL_GB_NOT_SUPPORTED const(1);
dcl-c SQL_GB_GROUP_BY_EQUALS_SELECT const(2);
dcl-c SQL_GB_GROUP_BY_CONTAINS_SELECT const(3);

//
// Standard SQL data types
//
dcl-c SQL_CHAR     const(1);
dcl-c SQL_NUMERIC  const(2);
dcl-c SQL_DECIMAL  const(3);
dcl-c SQL_INTEGER  const(4);
dcl-c SQL_SMALLINT const(5);
dcl-c SQL_FLOAT    const(6);
dcl-c SQL_REAL     const(7);
dcl-c SQL_DOUBLE   const(8);
dcl-c SQL_DATETIME const(9);
dcl-c SQL_VARCHAR  const(12);
dcl-c SQL_BLOB     const(13);
dcl-c SQL_CLOB     const(14);
dcl-c SQL_DBCLOB   const(15);
dcl-c SQL_DATALINK const(16);
dcl-c SQL_WCHAR    const(17);
dcl-c SQL_WUARCHAR const(18);
dcl-c SQL_BIGINT   const(19);
dcl-c SQL_BLOB_LOCATOR const(20);
dcl-c SQL_CLOB_LOCATOR const(21);
dcl-c SQL_DBCLOB_LOCATOR const(22);
dcl-c SQL_UTF8_CHAR const(23);
dcl-c SQL_GRAPHIC  const(95);
dcl-c SQL_VARGRAPHIC const(96);
dcl-c SQL_BINARY   const(97);
dcl-c SQL_VARBINARY const(98);
dcl-c SQL_DATE     const(91);
dcl-c SQL_TYPE_DATE const(91);
dcl-c SQL_TIME     const(92);
dcl-c SQL_TYPE_TIME const(92);
dcl-c SQL_TIMESTAMP const(93);
dcl-c SQL_TYPE_TIMESTAMP const(93);
dcl-c SQL_ALL_TYPES const(0);
//
// Output values for cursor behavior
//
dcl-c SQL_CB_DELETE const(1);
dcl-c SQL_CB_CLOSE const(2);
dcl-c SQL_CB_PRESERVE const(3);

//
// Templates for SQL data types
//
dcl-s SQLSMALLINT int(5) template;
dcl-s SQLUSMALLINT uns(5) template;
dcl-s SQLUINTEGER uns(10) template;
dcl-s SQLDOUBLE float(8) template;
dcl-s SQLREAL float(4) template;
dcl-s SQLINTEGER int(10) template;
dcl-s SQLHENV int(10) template;
dcl-s SQLHDBC  int(10) template;
dcl-s SQLHSTMT int(10) template;
dcl-s SQLHDESC int(10) template;
dcl-s SQLHANDLE int(10) template;
dcl-s SQLRETURN like(SQLINTEGER) template;
dcl-s SFLOAT float(4) template;
dcl-s SQLPOINTER pointer template;
dcl-s SQLHWND pointer template;

//
// Handle types
//
dcl-c SQL_UNUSED const(0);
dcl-c SQL_HANDLE_ENV const(1);
dcl-c SQL_HANDLE_DBC const(2);
dcl-c SQL_HANDLE_STMT const(3);
dcl-c SQL_HANDLE_DESC const(4);
dcl-c SQL_NULL_HANDLE const(0);
dcl-c SQL_HANDLE_DBC_UNICODE const(100);

//
// NULL status constants; these are used in SQLColAttributes,
//  SQLDescribeCol, to describe the nullability of a column
//  in a table.
//
dcl-c SQL_NO_NULLS const(0);
dcl-c SQL_NULLABLE const(1);
dcl-c SQL_NULLABLE_UNKNOWN const(2);

//
// Special length values
//
dcl-c SQL_NO_TOTAL const(0);
dcl-c SQL_NULL_DATA const(-1);
dcl-c SQL_DATA_AT_EXEC const(-2);
dcl-c SQL_BIGINT_PREC const(19);
dcl-c SQL_INTEGER_PREC const(10);
dcl-c SQL_SMALLINT_PREC const(5);

//
// SQLColAttributes constants
//
dcl-c SQL_ATTR_READONLY const(0);
dcl-c SQL_ATTR_WRITE const(1);
dcl-c SQL_ATTR_READWRITE_UNKNOWN const(2);

//
// Valid concurrency values
//
dcl-c SQL_CONCUR_LOCK const(0);
dcl-c SQL_CONCUR_READ_ONLY const(1);
dcl-c SQL_CONCUR_ROWVER const(3);
dcl-c SQL_CONCUR_VALUES const(4);

//
// Valid environment attributes
//
dcl-c SQL_ATTR_OUTPUT_NTS const(10001);
dcl-c SQL_ATTR_SYS_NAMING const(10002);
dcl-c SQL_ATTR_DEFAULT_LIB const(10003);
dcl-c SQL_ATTR_SERVER_MODE const(10004);
dcl-c SQL_ATTR_JOB_SORT_SEQUENCE const(10005);
dcl-c SQL_ATTR_ENVHNDL_COUNTER const(10009);
dcl-c SQL_ATTR_ESCAPE_CHAR const(10010);
dcl-c SQL_ATTR_INCLUDE_NULL_IN_LEN const(10031);
dcl-c SQL_ATTR_UTF8 const(10032);
dcl-c SQL_ATTR_SYSCAP const(10033);
dcl-c SQL_ATTR_REQUIRE_PROFILE const(10034);
dcl-c SQL_ATTR_UCS2 const(10035);
dcl-c SQL_ATTR_TRUNCATION_RTNC const(10036);

//
// Valid environment/connection attributes
//
dcl-c SQL_ATTR_EXTENDED_COL_INFO const(10019);
dcl-c SQL_ATTR_DATE_FMT const(10020);
dcl-c SQL_ATTR_DATE_SEP const(10021);
dcl-c SQL_ATTR_TIME_FMT const(10022);
dcl-c SQL_ATTR_TIME_SEP const(10023);
dcl-c SQL_ATTR_DECIMAL_SEP const(10024);
dcl-c SQL_ATTR_TXN_INFO const(10025);
dcl-c SQL_ATTR_TXN_EXTERNAL const(10026);
dcl-c SQL_ATTR_2ND_LEVEL_TEXT const(10027);
dcl-c SQL_ATTR_SAVEPOINT_NAME const(10028);
dcl-c SQL_ATTR_TRACE const(10029);
dcl-c SQL_ATTR_MAX_PRECISION const(10040);
dcl-c SQL_ATTR_MAX_SCALE const(10041);
dcl-c SQL_ATTR_MIN_DIVIDE_SCALE const(10042);
dcl-c SQL_ATTR_HEX_LITERALS const(10043);
dcl-c SQL_ATTR_CORRELATOR const(10044);

//
// Valid transaction info operations
//
dcl-c SQL_TXN_FIND const(1);
dcl-c SQL_TXN_CREATE const( 2);
dcl-c SQL_TXN_CLEAR const(3);
dcl-c SQL_TXN_END const(4);
dcl-c SQL_TXN_HOLD const(5);

//
// Valid environment/connection values
//
dcl-c SQL_FMT_ISO const(1);
dcl-c SQL_FMT_USA const(2);
dcl-c SQL_FMT_EUR const(3);
dcl-c SQL_FMT_JIS const(4);
dcl-c SQL_FMT_MDY const(5);
dcl-c SQL_FMT_DMY const(6);
dcl-c SQL_FMT_YMD const(7);
dcl-c SQL_FMT_JUL const(8);
dcl-c SQL_FMT_HMS const(9);
dcl-c SQL_FMT_JOB const(10);
dcl-c SQL_SEP_SLASH const(1);
dcl-c SQL_SEP_DASH const(2);
dcl-c SQL_SEP_PERIOD const(3);
dcl-c SQL_SEP_COMMA const(4);
dcl-c SQL_SEP_BLANK const(5);
dcl-c SQL_SEP_COLON const(6);
dcl-c SQL_SEP_JOB const(7);
dcl-c SQL_HEX_IS_CHAR const(1);
dcl-c SQL_HEX_IS_BINARY const(2);

//
// Valid values for type in GetCol
//
dcl-c SQL_DEFAULT const(99);
dcl-c SQL_ARD_TYPE const(-99);

//
// Valid values for UPDATE_RULE and DELETE_RULE in SQLForeignKeys
//
dcl-c SQL_CASCADE const(1);
dcl-c SQL_RESTRICT const(2);
dcl-c SQL_NO_ACTION const(3);
dcl-c SQL_SET_NULL const(4);
dcl-c SQL_SET_DEFAULT const(5);

//
// Valid values for COLUMN_TYPE in SQLProcedureColumns
//
dcl-c SQL_PARAM_INPUT const(1);
dcl-c SQL_PARAM_OUTPUT const(2);
dcl-c SQL_PARAM_INPUT_OUTPUT const(3);

//
// Statement attributes
//
dcl-c SQL_ATTR_APP_ROW_DESC const(10010);
dcl-c SQL_ATTR_APP_PARAM_DESC const(10011);
dcl-c SQL_ATTR_IMP_ROW_DESC const(10012);
dcl-c SQL_ATTR_IMP_PARAM_DESC const(10013);
dcl-c SQL_ATTR_FOR_FETCH_ONLY const(10014);
dcl-c SQL_ATTR_CONCURRENCY const(10014);
dcl-c SQL_CONCURRENCY const(10014);
dcl-c SQL_ATTR_CURSOR_SCROLLABLE const(10015);
dcl-c SQL_ATTR_ROWSET_SIZE const(10016);
dcl-c SQL_ROWSET_SIZE const(10016);
dcl-c SQL_ATTR_ROW_ARRAY_SIZE const(10016);
dcl-c SQL_ATTR_CURSOR_HOLD const(10017);
dcl-c SQL_ATTR_FULL_OPEN const(10018);
dcl-c SQL_ATTR_BIND_TYPE const(10049);
dcl-c SQL_BIND_TYPE const(10049);
dcl-c SQL_ATTR_CURSOR_TYPE const(10050);
dcl-c SQL_CURSOR_TYPE const(10050);
dcl-c SQL_ATTR_CURSOR_SENSITIVITY const(10051);
dcl-c SQL_CURSOR_SENSITIVE const(10051);

//
// Values for setting statement attributes
//
dcl-c SQL_BIND_BY_ROW const(0);
dcl-c SQL_BIND_BY_COLUMN const(1);
dcl-c SQL_CURSOR_FORWARD_ONLY const(0);
dcl-c SQL_CURSOR_STATIC const(1);
dcl-c SQL_CURSOR_DYNAMIC const(2);
dcl-c SQL_CURSOR_KEYSET_DRIVEN const(3);
dcl-c SQL_UNSPECIFIED const(0);
dcl-c SQL_INSENSITIVE const(1);
dcl-c SQL_SENSITIVE const(2);

//
// Codes used in SQLFetchScroll and SQLExtendedFetch
//
dcl-c SQL_FETCH_NEXT const(1);
dcl-c SQL_FETCH_FIRST const(2);
dcl-c SQL_FETCH_LAST const(3);
dcl-c SQL_FETCH_PRIOR const(4);
dcl-c SQL_FETCH_ABSOLUTE const(5);
dcl-c SQL_FETCH_RELATIVE const(6);

//
// SQLColAttributes constants
//
dcl-c SQL_DESC_COUNT const(1);
dcl-c SQL_DESC_TYPE const(2);
dcl-c SQL_DESC_LENGTH const(3);
dcl-c SQL_DESC_LENGTH_PTR const(4);
dcl-c SQL_DESC_PRECISION const(5);
dcl-c SQL_DESC_SCALE const(6);
dcl-c SQL_DESC_DATETIME_INTERVAL_CODE const(7);
dcl-c SQL_DESC_NULLABLE const(8);
dcl-c SQL_DESC_INDICATOR_PTR const(9);
dcl-c SQL_DESC_DATA_PTR const(10);
dcl-c SQL_DESC_NAME const(11);
dcl-c SQL_DESC_UNNAMED const(12);
dcl-c SQL_DESC_DISPLAY_SIZE const(13);
dcl-c SQL_DESC_AUTO_INCREMENT const(14);
dcl-c SQL_DESC_SEARCHABLE const(15);
dcl-c SQL_DESC_UPDATABLE const(16);
dcl-c SQL_DESC_BASE_COLUMN const(17);
dcl-c SQL_DESC_BASE_TABLE const(18);
dcl-c SQL_DESC_BASE_SCHEMA const(19);
dcl-c SQL_DESC_LABEL const(20);
dcl-c SQL_DESC_MONEY const(21);
dcl-c SQL_DESC_ALLOC_TYPE const(99);
dcl-c SQL_DESC_ALLOC_AUTO const(1);
dcl-c SQL_DESC_ALLOC_USER const(2);

dcl-c SQL_COLUMN_COUNT const(1);
dcl-c SQL_COLUMN_TYPE const(2);
dcl-c SQL_COLUMN_LENGTH const(3);
dcl-c SQL_COLUMN_LENGTH_PTR const(4);
dcl-c SQL_COLUMN_PRECISION const(5);
dcl-c SQL_COLUMN_SCALE const(6);
dcl-c SQL_COLUMN_DATETIME_INTERVAL_CODE const(7);
dcl-c SQL_COLUMN_NULLABLE const(8);
dcl-c SQL_COLUMN_INDICATOR_PTR const(9);
dcl-c SQL_COLUMN_DATA_PTR const(10);
dcl-c SQL_COLUMN_NAME const(11);
dcl-c SQL_COLUMN_UNNAMED const(12);
dcl-c SQL_COLUMN_DISPLAY_SIZE const(13);
dcl-c SQL_COLUMN_AUTO_INCREMENT const(14);
dcl-c SQL_COLUMN_SEARCHABLE const(15);
dcl-c SQL_COLUMN_UPDATABLE const(16);
dcl-c SQL_COLUMN_BASE_COLUMN const(17);
dcl-c SQL_COLUMN_BASE_TABLE const(18);
dcl-c SQL_COLUMN_BASE_SCHEMA const(19);
dcl-c SQL_COLUMN_LABEL const(20);
dcl-c SQL_COLUMN_MONEY const(21);
dcl-c SQL_COLUMN_ALLOC_TYPE const(99);
dcl-c SQL_COLUMN_ALLOC_AUTO const(1);
dcl-c SQL_COLUMN_ALLOC_USER const(2);

//
// Valid codes for SpecialColumns procedure
//
dcl-c SQL_SCOPE_CURROW const(0);
dcl-c SQL_SCOPE_TRANSACTION const(1);
dcl-c SQL_SCOPE_SESSION const(2);
dcl-c SQL_PC_UNKNOWN const(0);
dcl-c SQL_PC_NOT_PSEUDO const(1);
dcl-c SQL_PC_PSEUDO const(2);

//
// Valid values for connect attribute
//
dcl-c SQL_ATTR_AUTO_IPD const( 10001);
dcl-c SQL_ATTR_ACCESS_MODE const( 10002 );
dcl-c SQL_ACCESS_MODE const( 10002);
dcl-c SQL_ATTR_AUTOCOMMIT const( 10003);
dcl-c SQL_AUTOCOMMIT const( 10003);
dcl-c SQL_ATTR_DBC_SYS_NAMING const( 10004);
dcl-c SQL_ATTR_DBC_DEFAULT_LIB const( 10005);
dcl-c SQL_ATTR_ADOPT_OWNER_AUTH const( 10006);
dcl-c SQL_ATTR_SYSBAS_CMT const( 10007);
dcl-c SQL_ATTR_COMMIT const( 0);
dcl-c SQL_MODE_READ_ONLY const( 0);
dcl-c SQL_MODE_READ_WRITE const( 1);
dcl-c SQL_MODE_DEFAULT const( 1);
dcl-c SQL_AUTOCOMMIT_OFF const( 0);
dcl-c SQL_AUTOCOMMIT_ON const( 1);
dcl-c SQL_TXN_ISOLATION const( 0);
dcl-c SQL_ATTR_TXN_ISOLATION const( 0);
dcl-c SQL_COMMIT_NONE const( 1);
dcl-c SQL_TXN_NO_COMMIT const( 1);
dcl-c SQL_TXN_NOCOMMIT const( 1);
dcl-c SQL_COMMIT_CHG const( 2);
dcl-c SQL_COMMIT_UR const( 2);
dcl-c SQL_TXN_READ_UNCOMMITTED const( 2);
dcl-c SQL_COMMIT_CS const(3);
dcl-c SQL_TXN_READ_COMMITTED const(3);
dcl-c SQL_COMMIT_ALL const(4);
dcl-c SQL_COMMIT_RS const(4);
dcl-c SQL_TXN_REPEATABLE_READ const(4);
dcl-c SQL_COMMIT_RR const(5);
dcl-c SQL_TXN_SERIALIZABLE const(5);

//
// Valid index flags
//
dcl-c SQL_INDEX_UNIQUE const( 0);
dcl-c SQL_INDEX_ALL const( 1);
dcl-c SQL_INDEX_OTHER const( 3);
dcl-c SQL_TABLE_STAT const( 0);
dcl-c SQL_ENSURE const( 1);
dcl-c SQL_QUICK const( 0);

//
// Valid trace values
//
dcl-c SQL_ATTR_TRACE_CLI const( 1);
dcl-c SQL_ATTR_TRACE_DBMON const( 2);
dcl-c SQL_ATTR_TRACE_DEBUG const( 4);
dcl-c SQL_ATTR_TRACE_JOBLOG const( 8);
dcl-c SQL_ATTR_TRACE_STRTRC const( 16);

//
// Valid file options
//
dcl-c SQL_FILE_READ const( 2);
dcl-c SQL_FILE_CREATE const( 8);
dcl-c SQL_FILE_OVERWRITE const( 16);
dcl-c SQL_FILE_APPEND const( 32);
dcl-c SQL_DIAG_RETURNCODE const( 1);
dcl-c SQL_DIAG_NUMBER const( 2);

//
// Valid types for GetDiagField
//
dcl-c SQL_DIAG_ROW_COUNT const( 3);
dcl-c SQL_DIAG_SQLSTATE const( 4);
dcl-c SQL_DIAG_NATIVE const( 5);
dcl-c SQL_DIAG_MESSAGE_TEXT const( 6);
dcl-c SQL_DIAG_DYNAMIC_FUNCTION const( 7);
dcl-c SQL_DIAG_CLASS_ORIGIN const( 8);
dcl-c SQL_DIAG_SUBCLASS_ORIGIN const( 9);
dcl-c SQL_DIAG_CONNECTION_NAME const( 10);
dcl-c SQL_DIAG_SERVER_NAME const( 11);
dcl-c SQL_DIAG_MESSAGE_TOKENS const( 12);
dcl-c SQL_DIAG_AUTOGEN_KEY const( 14);

//
// SQLColAttributes constants
// These are also used by SQLGetInfo
//
dcl-c SQL_UNSEARCHABLE const( 0);
dcl-c SQL_LIKE_ONLY const( 1);
dcl-c SQL_ALL_EXCEPT_LIKE const( 2);
dcl-c SQL_SEARCHABLE const( 3);

//
// GetFunctions() values to identify CLI functions
//
dcl-c SQL_API_SQLALLOCCONNECT const( 1);
dcl-c SQL_API_SQLALLOCENV const( 2);
dcl-c SQL_API_SQLALLOCHANDLE const( 1001);
dcl-c SQL_API_SQLALLOCSTMT const( 3);
dcl-c SQL_API_SQLBINDCOL const( 4);
dcl-c SQL_API_SQLBINDFILETOCOL const( 2002);
dcl-c SQL_API_SQLBINDFILETOPARAM const( 2003);
dcl-c SQL_API_SQLBINDPARAM const( 1002);
dcl-c SQL_API_SQLBINDPARAMETER const( 1023);
dcl-c SQL_API_SQLCANCEL const( 5);
dcl-c SQL_API_SQLCLOSECURSOR const( 1003);
dcl-c SQL_API_SQLCOLATTRIBUTES const( 6);
dcl-c SQL_API_SQLCOLUMNPRIVILEGES const( 2010);
dcl-c SQL_API_SQLCOLUMNS const( 40);
dcl-c SQL_API_SQLCONNECT const( 7);
dcl-c SQL_API_SQLCOPYDESC const( 1004);
dcl-c SQL_API_SQLDATASOURCES const( 57);
dcl-c SQL_API_SQLDESCRIBECOL const( 8);
dcl-c SQL_API_SQLDESCRIBEPARAM const( 58);
dcl-c SQL_API_SQLDISCONNECT const( 9);
dcl-c SQL_API_SQLDRIVERCONNECT const( 68);
dcl-c SQL_API_SQLENDTRAN const( 1005);
dcl-c SQL_API_SQLERROR const( 10);
dcl-c SQL_API_SQLEXECDIRECT const( 11);
dcl-c SQL_API_SQLEXECUTE const( 12);
dcl-c SQL_API_SQLEXTENDEDFETCH const( 1022);
dcl-c SQL_API_SQLFETCH const( 13);
dcl-c SQL_API_SQLFETCHSCROLL const( 1021);
dcl-c SQL_API_SQLFOREIGNKEYS const( 60);
dcl-c SQL_API_SQLFREECONNECT const( 14);
dcl-c SQL_API_SQLFREEENV const( 15);
dcl-c SQL_API_SQLFREEHANDLE const( 1006);
dcl-c SQL_API_SQLFREESTMT const( 16);
dcl-c SQL_API_SQLGETCOL const( 43);
dcl-c SQL_API_SQLGETCONNECTATTR const( 1007);
dcl-c SQL_API_SQLGETCONNECTOPTION const( 42);
dcl-c SQL_API_SQLGETCURSORNAME const( 17);
dcl-c SQL_API_SQLGETDATA const( 43);
dcl-c SQL_API_SQLGETDESCFIELD const( 1008);
dcl-c SQL_API_SQLGETDESCREC const( 1009);
dcl-c SQL_API_SQLGETDIAGFIELD const( 1010);
dcl-c SQL_API_SQLGETDIAGREC const( 1011);
dcl-c SQL_API_SQLGETENVATTR const( 1012);
dcl-c SQL_API_SQLGETFUNCTIONS const( 44);
dcl-c SQL_API_SQLGETINFO const( 45);
dcl-c SQL_API_SQLGETLENGTH const( 2004);
dcl-c SQL_API_SQLGETPOSITION const( 2005);
dcl-c SQL_API_SQLGETSTMTATTR const( 1014);
dcl-c SQL_API_SQLGETSTMTOPTION const( 46);
dcl-c SQL_API_SQLGETSUBSTRING const( 2006);
dcl-c SQL_API_SQLGETTYPEINFO const( 47);
dcl-c SQL_API_SQLLANGUAGES const( 2001);
dcl-c SQL_API_SQLMORERESULTS const( 61);
dcl-c SQL_API_SQLNATIVESQL const( 62);
dcl-c SQL_API_SQLNEXTRESULT const( 2009);
dcl-c SQL_API_SQLNUMPARAMS const( 63);
dcl-c SQL_API_SQLNUMRESULTCOLS const( 18);
dcl-c SQL_API_SQLPARAMDATA const( 48);
dcl-c SQL_API_SQLPARAMOPTIONS const( 2007);
dcl-c SQL_API_SQLPREPARE const( 19);
dcl-c SQL_API_SQLPRIMARYKEYS const( 65);
dcl-c SQL_API_SQLPROCEDURECOLUMNS const( 66);
dcl-c SQL_API_SQLPROCEDURES const( 67);
dcl-c SQL_API_SQLPUTDATA const( 49);
dcl-c SQL_API_SQLRELEASEENV const( 1015);
dcl-c SQL_API_SQLROWCOUNT const( 20);
dcl-c SQL_API_SQLSETCONNECTATTR const( 1016);
dcl-c SQL_API_SQLSETCONNECTOPTION const( 50);
dcl-c SQL_API_SQLSETCURSORNAME const( 21);
dcl-c SQL_API_SQLSETDESCFIELD const( 1017);
dcl-c SQL_API_SQLSETDESCREC const( 1018);
dcl-c SQL_API_SQLSETENVATTR const( 1019);
dcl-c SQL_API_SQLSETPARAM const( 22);
dcl-c SQL_API_SQLSETSTMTATTR const( 1020);
dcl-c SQL_API_SQLSETSTMTOPTION const( 51);
dcl-c SQL_API_SQLSPECIALCOLUMNS const( 52);
dcl-c SQL_API_SQLSTARTTRAN const( 2008);
dcl-c SQL_API_SQLSTATISTICS const( 53);
dcl-c SQL_API_SQLTABLEPRIVILEGES const( 2011);
dcl-c SQL_API_SQLTABLES const( 54);
dcl-c SQL_API_SQLTRANSACT const( 23);

//
// NULL handle constants
//
dcl-c SQL_NULL_HENV const( 0);
dcl-c SQL_NULL_HDBC const( 0);
dcl-c SQL_NULL_HSTMT const( 0);

//
// truncated values return this sqlstate
//
dcl-c SQL_WARN_VAL_TRUNC const( '01004');

//
// date structure
//
dcl-ds DATE_STRUCT qualified template align;
  year like(SQLSMALLINT);
  month like(SQLSMALLINT);
  day like(SQLSMALLINT);
end-ds;

//
// time structure
//
dcl-ds TIME_STRUCT qualified template align;
  hour like(SQLSMALLINT);
  minute like(SQLSMALLINT);
  second like(SQLSMALLINT);
end-ds;

//
// timestamp structure
//
dcl-ds TIMESTAMP_STRUCT qualified template align;
  year like(SQLSMALLINT);
  month like(SQLSMALLINT);
  day like(SQLSMALLINT);
  hour like(SQLSMALLINT);
  minute like(SQLSMALLINT);
  second like(SQLSMALLINT);
  fraction like(SQLINTEGER);
end-ds;

//
// Transaction info structure
//
dcl-ds TXN_STRUCT qualified template align;
  operation like(SQLINTEGER);
  tminfo char(10);
  *n char(2);
  XID  pointer;
  timeoutval like(SQLINTEGER);
  locktimeout like(SQLINTEGER);
  *n char(8);
end-ds;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLAllocConnect(): Allocate a connection handle
//
//     henv = (input) environment to allocate in
//    phdbc = (output) new connection handle
//
// Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SqlAllocConnect like(SQLRETURN) ExtProc('SQLAllocConnect');
  henv like(SQLHENV) value;
  phdbc like(SQLHDBC);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLAllocEnv(): Allocate an environment for SQL and return
//an environment handle
//
//phenv = (output) environment handle
//
// Returns SQL_SUCCESS or SQL_ERROR
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SqlAllocEnv like(SQLRETURN) ExtProc('SQLAllocEnv');
  phenv like(SQLHENV);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLAllocHandle(): Allocate any type of handle
//
//type = (input) handle type
//     ihandle = (input) handle describing context
//       (i.e. is the new handle inside an env? conn?)
//     ohandle = (output) new handle returned
//
// Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SqlAllocHandle like(SQLRETURN) ExtProc('SQLAllocHandle');
  type like(SQLSMALLINT) value;
  ihandle like(SQLINTEGER) value;
  ohandle like(SQLINTEGER);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLAllocStmt(): Allocate a new SQL statement handle
//
//    hdbc = (input) handle to database connection
//  phstmt = (output) new statement handle
//
// Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLAllocStmt like(SQLRETURN) ExtProc('SQLAllocStmt');
  hdbc like(SQLHDBC) value;
  phstmt like(SQLHSTMT);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLBindCol(): Bind column to application variable
//
//      hstmt = (input) statement handle
//       icol = (input) column number to bind
//     fCType = (input) application data type for column
//   rgbValue = (output) pointer to variable where data is placed
// cbValueMax = (input) max size of variable (in bytes or DBCS chars))
//   pcbValue = (output) number of bytes returned
//
// Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLBindCol like(SQLRETURN) ExtProc('SQLBindCol');
  hstmt like(SQLHSTMT) value;
  icol like(SQLSMALLINT) value;
  fCType like(SQLSMALLINT) value;
  rgbValue like(SQLPOINTER) value;
  cbValueMax like(SQLINTEGER) value;
  pcbValue like(SQLINTEGER) options(*omit);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLBindFileToCol():  Bind LOB File Reference to LOB Column
//
// (This is used to populate an IFS stream file with the
//  contents of a LOB, or vice-versa)
//
// stmt = (input) statement handle
//     ColumnNo = (input) ordinal column number to bind
//     FileName = (input/deferred) variable that contains filename.
//this is not used immediately, but the var will
//be read when the file is actually created (so
//if you change it, you'll change the filename.)
//  FileNameLen = (input/deferred) variable that contains the
//%len of the file name in the FileName parm.
//     FileOpts = (input/deferred) variable that contains the
//option for SQL_FILE_CREATE, SQL_FILE_OVERWRITE
//or SQL_FILE_APPEND.
//  MaxFileName = (input) %size of FileName variable
//    StringLen = (output/deferred) variable to contain the length
//in bytes of the LOB returned.  This variable will
//be changed on each fetch.
//Indic = (output/deferred) variable to contain the
//indicator value for the column. This variable will
//be changed on each fetch.
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLBindFileToCol like(SQLRETURN) ExtProc('SQLBindFileToCol');
  stmt like(SQLHSTMT) value;
  ColumnNo like(SQLSMALLINT) value;
  FileName char(32767) options(*varsize);
  FileNameLen like(SQLINTEGER) options(*omit);
  FileOpts like(SQLINTEGER);
  MaxFileName like(SQLINTEGER) value;
  StringLen like(SQLINTEGER) options(*omit);
  Indic like(SQLINTEGER) options(*omit);
end-pr;

// (Same as above, but with arrays)
dcl-pr SQLBindFileToColA like(SQLRETURN) ExtProc('SQLBindFileToCol');
  stmt like(SQLHSTMT) value;
  ColumnNo like(SQLSMALLINT) value;
  FileName pointer dim(32767) options(*varsize);
  FileNameLen like(SQLINTEGER) dim(32767) options(*varsize:*omit);
  FileOpts like(SQLINTEGER) dim(32767) options(*varsize);
  MaxFileName like(SQLINTEGER) value;
  StringLen like(SQLINTEGER) dim(32767) options(*omit:*varsize);
  Indic like(SQLINTEGER) dim(32767) options(*omit:*varsize);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLBindFileToParam(): Bind LOB File reference to LOB Parm
//
//   (Associates a parameter marker for a LOB with an IFS
//    stream file.)
//
// stmt = (input) statement handle
//       ParmNo = (input) ordinal parameter number to bind
//     FileName = (input/deferred) variable that contains filename.
//this is not used immediately, but the var will
//be read when the file is actually created (so
//if you change it, you'll change the filename.)
//  FileNameLen = (input/deferred) variable that contains the
//%len of the file name in the FileName parm.
//     FileOpts = (input/deferred) variable that contains the
//option. It must be SQL_FILE_READ
//  MaxFileName = (input) %size of FileName variable
//    StringLen = (output/deferred) variable to contain the length
//in bytes of the LOB returned.  This variable will
//be changed on each fetch.
//Indic = (input/deferred) variable to contain the
//indicator value for the column. This variable will
//be changed on each fetch.
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLBindFileToParam like(SQLRETURN) ExtProc('SQLBindFileToParam');
  stmt like(SQLHSTMT) value;
  ParmNo like(SQLSMALLINT) value;
  DataType like(SQLSMALLINT) value;
  FileName char(32767) options(*varsize);
  FileNameLen like(SQLINTEGER);
  FileOpts like(SQLINTEGER);
  MaxFileName like(SQLINTEGER) value;
  Indic like(SQLINTEGER) options(*omit);
end-pr;

// (Same as above, but with arrays)
dcl-pr SQLBindFileToParamA like(SQLRETURN) ExtProc('SQLBindFileToParam');
  stmt like(SQLHSTMT) value;
  ParmNo like(SQLSMALLINT) value;
  DataType like(SQLSMALLINT) value;
  FileName pointer dim(32767) options(*varsize);
  FileNameLen like(SQLINTEGER) dim(32767) options(*varsize:*omit);
  FileOpts like(SQLINTEGER) dim(32767) options(*varsize);
  MaxFileName like(SQLINTEGER) value;
  Indic like(SQLINTEGER) dim(32767) options(*omit:*varsize);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLBindParam(): Set Parameter
//
//      hstmt = (input) statement handle
//       ipar = (input) parameter marker number to bind
//     fCType = (input) application data type for column
//   fSqlType = (input) SQL data type for column
// cbParamDef = (input) precision of corresponding param marker
//    ibScale = (input) scale of parm marker (decimal places)
//   rgbValue = (i/o)   pointer to variable for data
//or SQL_NULL_DATA if no data.
//   pcbValue = (input) length of data, or SQL_NTS, or zero
//or *OMIT if no data
//
// Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLBindParam  like(SQLRETURN) ExtProc('SQLBindParam');
  hstmt like(SQLHSTMT) value;
  ipar like(SQLSMALLINT) value;
  fCType like(SQLSMALLINT) value;
  fSqlType like(SQLSMALLINT) value;
  cbParamDef like(SQLINTEGER) value;
  ibScale  like(SQLSMALLINT) value;
  rgbValue like(SQLPOINTER) value;
  pcbValue like(SQLINTEGER) options(*omit);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLBindParameter(): Set Parameter (extended)
//
//       stmt = (input) statement handle
//     ParmNo = (input) parameter marker number to bind
//  InOutType = (input) whether parameter is input,output or both
//   DataType = (input) RPG data type of the parameter
//    SqlType = (input) SQL data type for the parameter
//    ColSize = (input) precision of corresponding param marker
//      (This is the length or number of digits)
//      Scale = (input) scale of parm marker (decimal places)
//      Value = (i/o/deferred) Variable that contains the value
//of the data (variable is used when the
//statement is executed, not when this
//procedure is called)
//can be *NULL if InOutType=SQL_PARAM_OUTPUT
//and you don't want the data.
//  BufferLen = (input) Not used.
// Len_Or_Ind = (i/o/deferred) Variable containing the length of
//     the *data* (vs. the size of the field)
//     This variable is used when the
//     statement is executed (not when
//     SQLBindParameter is run.)
//     May contain SQL_NULL_DATA if an SQL
//     null value is desired, SQL_NTS if
//     a zero-terminated string is used,
//     or SQL_DATA_AT_EXEC if the data
//     should be supplied by SQLPutData()
//     For output fields, this will also be
//     used to return the length of the data,
//     (or SQL_NULL_DATA/SQL_NTS)
//     can be *OMIT if the InOutType parm
//     is SQL_PARAM_OUTPUT and you don't
//     want the data.
//
//  NOTE: You can *OMIT/*NULL both the 'Value' and 'Len_Or_Ind'
//parameters for an output-only parameter if you want
//to discard the data.
//
// Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLBindParameter like(SQLRETURN) ExtProc('SQLBindParameter');
  stmt like(SQLHSTMT) value;
  ParmNo like(SQLSMALLINT) value;
  inouttype like(SQLSMALLINT) value;
  datatype like(SQLSMALLINT) value;
  SqlType like(SQLSMALLINT) value;
  ColSize like(SQLINTEGER) value;
  Scale like(SQLSMALLINT) value;
  Value like(SQLPOINTER) value;
  BufferLen like(SQLINTEGER) value;
  Len_Or_Ind like(SQLINTEGER) options(*omit);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLCancel(): This doesn't do anything, it's here for
//      the sake of matching the CLI standards.
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLCancel like(SQLRETURN) ExtProc('SQLCancel');
  stmt like(SQLHSTMT) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLCloseCursor(): Close cursor
//
//       stmt = (input) statement handle
//
// Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLCloseCursor like(SQLRETURN) ExtProc('SQLCloseCursor');
  stmt like(SQLHSTMT) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLColAttribute():  Get Column Attributes
//
//          StatementHandle = (input)  statement handle
//            ColumnNumber  = (input)  ordinal column number
//          FieldIdentifier = (input)  The field in row ColumnNumber of the IRD that is to be returned
//    CharacterAttributePtr = (output) Pointer to a buffer in which to return the value
//             BufferLength = (input)  Number of SQLCHAR elements
//          StringLengthPtr = (output) Pointer to a buffer in which to return the total number of bytes
//      NumericAttributePtr = (output) Pointer to a buffer in which to return the value in the FieldIdentifier field
//
// Returns SQL_SUCCESS,
//         SQL_SUCCESS_WITH_INFO
//         SQL_ERROR
//         SQL_INVALID_HANDLE
//         SQL_NO_DATA_FOUND
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLColAttribute like(SQLRETURN) ExtProc('SQLColAttribute');
  StatementHandle like(SQLHSTMT) value;
  ColumnNumber like(SQLSMALLINT) value;
  FieldIdentifier like(SQLSMALLINT) value;
  CharacterAttributePtr pointer;
  BufferLength like(SQLSMALLINT) value;
  StringLength like(SQLINTEGER);
  NumericAttributePtr like(SQLPOINTER) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLColAttributes():  Get Column Attributes
//
//       stmt = (input)  statement handle
//      ColNo = (input)  ordinal column number
//   DescType = (input)  attribute to retrieve
//    DescBuf = (output) value of attribute (if a char string)
//   DescSize = (input)  maximum size of desc buf
//    rtnSize = (output) actual number of bytes used in desc buf
//    DescInt = (output) value of attribute (if numeric)
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// SQL_NO_DATA_FOUND
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLColAttributes like(SQLRETURN) ExtProc('SQLColAttributes');
  stmt like(SQLHSTMT) value;
  ColNo like(SQLSMALLINT) value;
  DescType like(SQLSMALLINT) value;
  DescBuf char(32767) options(*varsize: *omit);
  DescSize like(SQLINTEGER) value;
  RtnSize like(SQLINTEGER);
  DescInt like(SQLINTEGER) options(*omit);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLColumnPrivledges(): Get privleges associated with the
//columns of a table.
//
//  The result data is returned in a result set, so you should
//  use SQLBindCol() and SQLFetch() to get the results.
//
// stmt = (input) statement handle
//  CatalogName = (input) catalog qualifier of 3 part table name
//This must ALWAYS be *OMIT.
//  NameLength1 = (input) length of catalog name, ALWAYS 0
//   SchemaName = (input) Schema qualifier of table name
//  NameLength2 = (input) Length of SchemaName
//    TableName = (input) Table name
//  NameLength3 = (input) Length of TableName
//   ColumnName = (input) Column name
//  NameLength4 = (input) Length of ColumnName
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// -- data is returned in a result set --
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLColumnPrivledges like(SQLRETURN) ExtProc('SqlColumnPrivledges');
  stmt like(SQLHSTMT) value;
  CatalogName char(32767) options(*varsize:*omit);
  NameLength1 like(SQLSMALLINT) value;
  SchemaName char(32767) options(*varsize:*omit);
  NameLength2 like(SQLSMALLINT) value;
  TableName char(32767) options(*varsize:*omit);
  NameLength3 like(SQLSMALLINT) value;
  ColumnName char(32767) options(*varsize:*omit);
  NameLength4 like(SQLSMALLINT) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLColumns(): Get column information for a table
//
//  The result data is returned in a result set, so you should
//  use SQLBindCol() and SQLFetch() to get the results.
//
// stmt = (input) statement handle
//  CatalogName = (input) catalog qualifier of 3 part table name
//This must ALWAYS be *OMIT.
//  NameLength1 = (input) length of catalog name, ALWAYS 0
//   SchemaName = (input) Schema qualifier of table name
//  NameLength2 = (input) Length of SchemaName
//    TableName = (input) Table name
//  NameLength3 = (input) Length of TableName
//   ColumnName = (input) Column name
//  NameLength4 = (input) Length of ColumnName
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// -- data is returned in a result set --
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLColumns like(SQLRETURN) ExtProc('SQLColumns');
  stmt like(SQLHSTMT) value;
  CatalogName char(32767) options(*varsize:*omit);
  NameLength1 like(SQLSMALLINT) value;
  SchemaName char(32767) options(*varsize:*omit);
  NameLength2 like(SQLSMALLINT) value;
  TableName char(32767) options(*varsize:*omit);
  NameLength3 like(SQLSMALLINT) value;
  ColumnName char(32767) options(*varsize:*omit);
  NameLength4 like(SQLSMALLINT) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLConnect(): Connect to a data source
//
//       hdbc = (input) connection handle
//      szDSN = (input) Data source name to connect to
//      cbDSN = (input) length of szDSN parameter
//      szUID = (input) Autorization name (UserID)
//      cbUID = (input) Length of szUID parameter
//  szAuthStr = (input) Autorization name (UserID)
//  cbAuthStr = (input) Length of szUID parameter
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLConnect like(SQLRETURN) Extproc('SQLConnect');
  hdbc like(SQLHDBC) value;
  szDSN pointer value options(*string);
  cbDSN like(SQLSMALLINT) value;
  szUID pointer value options(*string);
  cbUID like(SQLSMALLINT) value;
  szAuthStr pointer value options(*string);
  cbAuthStr like(SQLSMALLINT) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLCopyDesc(): Copy description statement
//
//    sDesc = (input) source descriptor handle
//    tDesc = (input) target descriptor handle
//
// Returns SQL_SUCCESS,
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLCopyDesc like(SQLRETURN) ExtProc('SQLCopyDesc');
  sDesc like(SQLHDESC) value;
  tDesc like(SQLHDESC) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLDataSources(): Get List of Data Sources
//
// env = (input)  environment handle
//   direction = (input)  SQL_FETCH_FIRST or SQL_FETCH_NEXT
// used to get the first, or next, data source
//  serverName = (output) name of DSN
//  BufferLen1 = (input)  size of serverName variable
//    NameLen1 = (output) len used in serverName variable
// Description = (output) description of data source
//  BufferLen2 = (input)  size of description variable
//    NameLen2 = (output) len used in description variable
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// SQL_NO_DATA_FOUND
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLDataSources like(SQLRETURN) ExtProc('SQLDataSources');
  env like(SQLHENV) value;
  direction like(SQLSMALLINT) value;
  serverName char(513) options(*varsize:*omit);
  BufferLen1 like(SQLSMALLINT) value;
  NameLen1 like(SQLSMALLINT) options(*omit);
  Description char(513) options(*varsize:*omit);
  BufferLen2 like(SQLSMALLINT) value;
  NameLen2 like(SQLSMALLINT) options(*omit);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLDescribeCol(): Describe Column Attributes
//
// stmt = (input)  statement handle
//ColNo = (input)  ordinal column number to describe
//      ColName = (output) returned column name
//   ColNameMax = (input)  %size() of ColName parameter
//   ColNameLen = (output) returned length of ColName parameter
//  SqlDataType = (output) returned data type of column
//    Precision = (output) returned precision (length) of column
//Scale = (output) returned scale (dec pos) of numeric columns
//     Nullable = (output) returned info about null capability.
// SQL_NO_NULLS or SQL_NULLABLE
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLDescribeCol like(SQLRETURN) ExtProc('SQLDescribeCol');
  stmt like(SQLHSTMT) value;
  ColNo like(SQLSMALLINT) value;
  ColName char(513) options(*varsize: *omit);
  ColNameMax like(SQLSMALLINT) value;
  ColNameLen like(SQLSMALLINT);
  SqlDataType like(SQLSMALLINT);
  Precision like(SQLINTEGER);
  Scale like(SQLSMALLINT);
  Nullable like(SQLSMALLINT);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLDescribeParam(): Describe Parameter Marker
//
//       stmt = (input)  statement handle
//    ParamNo = (input)  ordinal parameter number to describe
//   datatype = (output) returned data type of parameter
//       size = (output) returned size of parameter
//     decpos = (output) returned decimal digits of parameter
//   nullable = (output) returned info about null capability
//   SQL_NO_NULLS, SQL_NULLABLE or SQL_NULLABLE_UNKNOWN
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// SQL_STILL_EXECUTING
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLDescribeParam like(SQLRETURN) ExtProc('SQLDescribeParam');
  stmt like(SQLHSTMT) value;
  ParamNo like(SQLSMALLINT) value;
  datatype like(SQLSMALLINT);
  size like(SQLINTEGER);
  decpos like(SQLSMALLINT);
  nullable like(SQLSMALLINT);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLDisconnect(): Disconnect from a data source
//
//  hdbc = (input) database connection handle to disconnect
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLDisconnect like(SQLRETURN) Extproc('SQLDisconnect');
  hdbc like(SQLHDBC) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLDriverConnect(): Connect to a data source (expanded)
//
//  hdbc = (input)  Connection handle
//  hwnd = (input)  Window handle (ignored on iSeries)
//    in_ConnStr = (input)  Connection string
//    in_ConnLen = (input)  length of in_ConnStr (SQL_NTS)
//   out_ConnStr = (output) completed connection string
//   out_ConnSiz = (input)  %size() of outConnStr variable
//   out_ConnRtn = (output) length of out_ConnStr used
//   drivercompl = (input)  when should DB2 prompt user?
//   SQL_DRIVER_COMPLETE, SQL_DRIVER_COMPLETE_REQUIRED
//   or SQL_DRIVER_NOPROMPT
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// SQL_NO_DATA_FOUND
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLDriverConnect like(SQLRETURN) extproc('SQLDriverConnect');
  hdbc like(SQLHDBC) value;
  hwnd like(SQLHWND) value;
  in_ConnStr pointer value options(*string);
  in_ConnLen like(SQLSMALLINT) value;
  out_ConnStr char(32767) options(*varsize:*omit);
  out_ConnSiz like(SQLSMALLINT) value;
  out_ConnRtn like(SQLSMALLINT);
  drivercompl like(SQLSMALLINT) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLEndTran(): Commit or rollback a transaction
//
//   htype = (input) type of handle:
// SQL_HANDLE_ENV or SQL_HANDLE_DBC
//  handle = (input) handle to use
//  action = (input) action to perform:
// SQL_COMMIT
// SQL_ROLLBACK
// SQL_COMMIT_HOLD
// SQL_ROLLBACK_HOLD
// SQL_SAVEPOINT_NAME_ROLLBACK
// SQL_SAVEPOINT_NAME_RELEASE
// Returns SQL_SUCCESS
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLEndTran like(SQLRETURN) extproc('SQLEndTran');
  htype like(SQLSMALLINT) value;
  handle like(SQLINTEGER) value;
  action like(SQLSMALLINT) value;
 end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLError(): Retrieve Error Information
//
//henv = (input) environment handle
//hdbc = (input) database connection handle
//       (or SQL_NULL_HDBC)
//       hstmt = (input) statement handle (or SQL_NULL_HSTMT)
//  szSqlState = (output) SQL State (null-terminated)
// pfNativeErr = (output) Native error code
//  szErrorMsg = (output) Message text of error message
// cbErrMsgMax = (input) max size of szErrorMsg parameter
// pcbErrorMsg = (output) total bytes available for err msg.
//
// Returns SQL_SUCCESS,
// SQL_NO_DATA_FOUND
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLError like(SQLRETURN) extproc('SQLError');
  henv like(SQLHENV) value;
  hdbc like(SQLHDBC) value;
  hstmt like(SQLHSTMT) value;
  szSqlState char(6);
  pfNativeErr like(SQLINTEGER);
  szErrorMsg char(513) options(*varsize);
  cbErrMsgMax like(SQLSMALLINT) value;
  pcbErrorMsg like(SQLSMALLINT);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  SQLExecDirect(): Execute an SQL Statement Directly
//
//     hstmt = (input) handle of SQL Statement
//  szSqlStr = (input) SQL statement to execute
//  cbSqlStr = (input) length of SQL statement
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// SQL_NO_DATA_FOUND
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLExecDirect like(SQLRETURN) Extproc('SQLExecDirect');
  hstmt like(SQLHSTMT) value;
  szSqlStr pointer value options(*string);
  cbSqlStr like(SQLINTEGER) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLExecute(): Execute a prepared statement
//
//     hstmt = (input) handle of prepared SQL Statement
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// SQL_NO_DATA_FOUND
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLExecute like(SQLRETURN) Extproc('SQLExecute');
  hstmt like(SQLHSTMT) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLExtendedFetch(): Fetch Array of Rows
//
// Note: Number of rows fetched is set by calling SQLSetStmtAttr()
//       and specifying SQL_ROWSET_SIZE
//
//     hstmt = (input) handle of prepared SQL Statement
//    orient = (input) fetch orientation
//     (must be SQL_FETCH_NEXT if non-scrollable)
//    offset = (input) Row offset for relative positioning
//  rowcount = (output) rows that were fetched by API
// rowstatus = (output) array of success/fail flags for
//      each row returned.  This can be
//      SQL_ROW_SUCCESS or SQL_ROW_NOROW
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// SQL_NO_DATA_FOUND  (also indicates end of result set)
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLExtendedFetch like(SQLRETURN) Extproc('SQLExtendedFetch');
  hstmt like(SQLHSTMT) value;
  orient like(SQLSMALLINT) value;
  offset like(SQLINTEGER) value;
  rowcount like(SQLINTEGER);
  rowstatus like(SQLSMALLINT) dim(32767) options(*varsize);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLFetch(): Fetch next row from result set
//
//     hstmt = (input) handle of prepared SQL Statement
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// SQL_NO_DATA_FOUND  (also indicates end of result set)
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLFetch like(SQLRETURN) Extproc('SQLFetch');
  hstmt like(SQLHSTMT) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLFetchScroll(): Fetch next row from scrollable cursor
//
//     hstmt = (input) handle of prepared SQL Statement
//    orient = (input) fetch orientation
//     (must be SQL_FETCH_NEXT if non-scrollable)
//    offset = (input) Row offset for relative positioning
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// SQL_NO_DATA_FOUND  (also indicates end of result set)
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLFetchScroll like(SQLRETURN) Extproc('SQLFetchScroll');
  hstmt like(SQLHSTMT) value;
  orient like(SQLSMALLINT) value;
  offset like(SQLINTEGER) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLForeignKeys(): Get the list of foreign key columns
//
//  NOTE: Results from this API are returned in a result set.
//To get them, use SQLFetch() and friends.
//
//  stmt = (input) statement handle
//     pkcatalog = (input) must be *OMIT
//  pkcataloglen = (input) must be 0
//      pkschema = (input) schema qualifier of primary key tbl
//   pkschemalen = (input) pkschema len, or SQL_NTS
//       pktable = (input) name of table containing primary key
//    pktablelen = (input) pktable len, or SQL_NTS
//     fkcatalog = (input) must be *OMIT
//  fkcataloglen = (input) must be 0
//      fkschema = (input) schema qualifier of foreign key tbl
//   fkschemalen = (input) fkschema len, or SQL_NTS
//       fktable = (input) name of table containing foreign key
//    fktablelen = (input) fktable len, or SQL_NTS
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// SQL_STILL_EXECUTING
// - results are returned in a result set -
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLForeignKeys like(SQLRETURN) Extproc('SQLForeignKeys');
  stmt like(SQLHSTMT) value;
  pkcatalog char(32767) const options(*varsize:*omit);
  pkcataloglen like(SQLINTEGER) value;
  pkschema pointer value options(*string);
  pkschemalen like(SQLINTEGER) value;
  pktable pointer value options(*string);
  pktablelen like(SQLINTEGER) value;
  fkcatalog char(32767) const options(*varsize:*omit);
  fkcataloglen like(SQLINTEGER) value;
  fkschema pointer value options(*string);
  fkschemalen like(SQLINTEGER) value;
  fktable pointer value options(*string);
  fktablelen like(SQLINTEGER) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLFreeConnect(): Free SQL connection handle
//
//     hdbc = (input) handle of data source connection
//   that has already been disconnected
//   by SQLDisconnect()
//
// Returns SQL_SUCCESS,
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLFreeConnect like(SQLRETURN) Extproc('SQLFreeConnect');
  hdbc like(SQLHDBC) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLFreeEnv(): Free Environment Handle
//      (SQLFreeConnect needs to be called first)
//
//     henv = (input) environment handle to free up
//
// Returns SQL_SUCCESS,
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLFreeEnv like(SQLRETURN) Extproc('SQLFreeEnv');
  henv like(SQLHENV) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLFreeHandle(): Free a Handle (any type)
//
//   htype = (input) type of handle to free
//      SQL_HANDLE_ENV, SQL_HANDLE_DBC, SQL_HANDLE_STMT
//      SQL_HANDLE_DESC
//  handle = (input) handle to free
//
// Returns SQL_SUCCESS,
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLFreeHandle like(SQLRETURN) Extproc('SQLFreeHandle');
  htype like(SQLSMALLINT) value;
  handle like(SQLINTEGER) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLFreeStmt(): Free or Reset an SQL Statement Handle
//
//    hstmt = (input) statement handle to free or reset
//  fOption = (input) option to perform, the values are:
//      SQL_CLOSE  = Close a cursor
//      SQL_DROP   = Drop a statement handle/free resources
//      SQL_UNBIND = unbind columns from variables
//      SQL_RESET_PARAMS = Reset parameters
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLFreeStmt like(SQLRETURN) Extproc('SQLFreeStmt');
  hstmt like(SQLHSTMT) value;
  fOption like(SQLSMALLINT) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLGetCol(): Gets a column from a fetched row
//
//     hstmt  = (input) statement handle of fetch
//      icol  = (input) column number to get
//    fCType  = (input) application (not database) data type
//      of column identified by icol
//      (SQL_CHAR, SQL_VARCHAR, etc const()
//   rgbValue = (input) pointer to memory (variable) where the
//      retrieved column data will be stored
// cbValueMax = (input) maximum size of data to return
//for DECIMAL or NUMERIC, this is
//(precision * 256) + scale.
//For anything else, it's bytes.
//   pcbValue = (output) size of data available in database
//or, amount remaining if fetching in pieces
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// SQL_NO_DATA_FOUND (also indicates end of result set)
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLGetCol like(SQLRETURN) ExtProc('SQLGetCol');
  hstmt like(SQLHSTMT) value;
  icol like(SQLSMALLINT) value;
  fCType like(SQLSMALLINT) value;
  rgbValue like(SQLPOINTER) value;
  cbValueMax like(SQLINTEGER) value;
  pcbValue like(SQLINTEGER) options(*omit);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLGetConnectAttr(): Get connection attribute
//
//    hdbc = (input)  connection handle
//    attr = (input)  attribute to retrieve
//  vParam = (output) returned value, can be an integer or
//      a null-terminated char string.
//    bLen = (input)  %size() of variable passed for vParam
//    sLen = (output) Length used if output is a string.
//
//  Returns SQL_SUCCESS
//  SQL_NO_DATA_FOUND
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLGetConnectAttr like(SQLRETURN) ExtProc('SQLGetConnectAttr');
  hdbc like(SQLHDBC) value;
  Attr like(SQLINTEGER) value;
  vParam like(SQLPOINTER) value;
  bLen like(SQLINTEGER) value;
  sLen like(SQLINTEGER) options(*omit);
end-pr;

dcl-pr SQLGetConnectAttrI like(SQLRETURN)  ExtProc('SQLGetConnectAttr');
  hdbc like(SQLHDBC) value;
  Attr like(SQLINTEGER) value;
  vParam like(SQLINTEGER);
  bLen like(SQLINTEGER) value;
  sLen like(SQLINTEGER) options(*omit);
end-pr;

dcl-pr SQLGetConnectAttrS like(SQLRETURN) ExtProc('SQLGetConnectAttr');
  hdbc like(SQLHDBC) value;
  Attr like(SQLINTEGER) value;
  vParam char(32767) options(*varsize:*omit);
  bLen like(SQLINTEGER) value;
  sLen like(SQLINTEGER) options(*omit);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLGetConnectOption(): Get connection attribute
//
// Deprecated: Use SQLGetConnectAttr()
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLGetConnectOption like(SQLRETURN) ExtProc('SQLGetConnectOption');
  hdbc like(SQLHDBC) value;
  fOption like(SQLINTEGER) value;
  vParam like(SQLPOINTER) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLGetCursorName():  Retrieve cursor name
//
//       stmt = (input) statement handle
//     cursor = (output) returned cursor name
//  cursormax = (input)  %size() of variable for cursor
//  cursorlen = (output) returned length of cursor name
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLGetCursorName like(SQLRETURN) ExtProc('SQLGetCursorName');
  stmt like(SQLHSTMT) value;
  cursor char(32767) options(*varsize);
  cursormax like(SQLSMALLINT) value;
  cursorlen like(SQLSMALLINT);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLGetData():  Get Data From a Column
//
//  Note: This is identical to SQLGetCol.
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLGetData like(SQLRETURN) ExtProc('SQLGetData');
  hstmt like(SQLHSTMT) value;
  icol like(SQLSMALLINT) value;
  fCType like(SQLSMALLINT) value;
  rgbValue like(SQLPOINTER) value;
  cbValueMax like(SQLINTEGER) value;
  pcbValue like(SQLINTEGER) options(*omit);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLGetDescField():  Get Descriptor Field
//
//       hdesc = (input) descriptor handle
//irec = (input) record number (column or parameter no)
//   fDescType = (input) descriptor type
//     rgbDesc = (output) pointer to buffer for result
//bLen = (input) length of rgbDesc buffer
//sLen = (output) actual number of bytes returnable
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// SQL_NO_DATA_FOUND
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLGetDescField like(SQLRETURN) ExtProc('SQLGetDescField');
  hdesc like(SQLHDESC) value;
  irec like(SQLSMALLINT) value;
  fDescType like(SQLSMALLINT) value;
  rgbDesc like(SQLPOINTER) value;
  bLen like(SQLINTEGER) value;
  sLen like(SQLINTEGER);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLGetDescRec(): Get Descriptor record
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLGetDescRec like(SQLRETURN) ExtProc('SQLGetDescRec');
  hdesc like(SQLHDESC) value;
  irec like(SQLSMALLINT) value;
  name char(513) options(*varsize:*omit);
  namelen like(SQLSMALLINT) value;
  totallen like(SQLSMALLINT);
  type like(SQLSMALLINT);
  subtype  like(SQLSMALLINT);
  length like(SQLINTEGER);
  prec like(SQLSMALLINT);
  scale like(SQLSMALLINT);
  nullable like(SQLSMALLINT);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLGetDiagField(): Get Diagnostic Info by Field
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLGetDiagField like(SQLRETURN) ExtProc('SQLGetDiagField');
  htype like(SQLSMALLINT) value;
  handle like(SQLINTEGER) value;
  recNum like(SQLSMALLINT) value;
  diagId like(SQLSMALLINT) value;
  diagInfo like(SQLPOINTER) value;
  bLen like(SQLSMALLINT) value;
  sLen like(SQLSMALLINT) options(*omit);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLGetDiagRec(): Get Diagnostic Info by Record
//
//htype = (input) handle type
//       handle = (input) handle for which diagnostics are reqd
//     SqlState = (output) SQL state (error) code
//      SqlCode = (output) IBM SQL status/error code
//     errorMsg = (output) message text for error
//  errorMsgMax = (input) %size() of errorMsg variable
//  errorMsgLen = (output) length of returned data for errorMsg
//
// Returns SQL_SUCCESS,
// SQL_ERROR
// SQL_INVALID_HANDLE
// SQL_NO_DATA_FOUND
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLGetDiagRec like(SQLRETURN) ExtProc('SQLGetDiagRec');
  htype like(SQLSMALLINT) value;
  handle like(SQLINTEGER) value;
  recNum like(SQLSMALLINT) value;
  SqlState char(6);
  SqlCode like(SQLINTEGER);
  errorMsg char(513) options(*varsize);
  errorMsgMax like(SQLSMALLINT) value;
  errorMsgLen like(SQLSMALLINT);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLGetEnvAttr(): Get environment attribute
//
//    henv = (input)  environment handle
//    attr = (input)  attribute to retrieve
//  vParam = (output) returned value, can be an integer or
//      a null-terminated char string.
//    bLen = (input)  %size() of variable passed for vParam
//    sLen = (output) Length used if output is a string.
//
//  Returns SQL_SUCCESS
//  SQL_NO_DATA_FOUND
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLGetEnvAttr like(SQLRETURN) ExtProc('SQLGetEnvAttr');
  henv like(SQLHENV) value;
  Attr like(SQLINTEGER) value;
  vParam like(SQLPOINTER) value;
  bLen like(SQLINTEGER) value;
  sLen like(SQLINTEGER) options(*omit);
end-pr;

dcl-pr SQLGetEnvAttrI like(SQLRETURN) ExtProc('SQLGetEnvAttr');
  henv like(SQLHENV) value;
  Attr like(SQLINTEGER) value;
  vParam like(SQLINTEGER);
  bLen like(SQLINTEGER) value;
  sLen like(SQLINTEGER) options(*omit);
end-pr;

dcl-pr SQLGetEnvAttrS like(SQLRETURN) ExtProc('SQLGetEnvAttr');
  henv like(SQLHENV) value;
  Attr like(SQLINTEGER) value;
  vParam char(32767) options(*varsize:*omit);
  bLen like(SQLINTEGER) value;
  sLen like(SQLINTEGER) options(*omit);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLGetFunctions(): Get functions
//
//   Checks which functions are available.
//
//hdbc = (input) connection handle
//   fFunction = (input) one of the SQL_API_xxx flags
//  fSupported = (output) SQL_TRUE if function supported,
//SQL_FALSE otherwise.
//
// Returns SQL_SUCCESS,
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLGetFunctions like(SQLRETURN) ExtProc('SQLGetFunctions');
  hdbc like(SQLHDBC) value;
  fFunction like(SQLSMALLINT) value;
  fSupported like(SQLSMALLINT);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLGetInfo(): Get general information about the DBMS
//
//  hdbc = (input) connection handle
//      InfoType = (input) type of information desired
//     InfoValue = (output) address of variable that will
//  contain returned result.
//    InfoValMax = (input) %size() of variable provided for
//  InfoValue.
//  InfoValAvail = (output) amount of data available to be
//   returned in InfoValue
//
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLGetInfo like(SQLRETURN) ExtProc('SQLGetInfo');
  hdbc like(SQLHDBC) value;
  InfoType like(SQLSMALLINT) value;
  InfoValue like(SQLPOINTER) value;
  InfoValueMax like(SQLSMALLINT) value;
  InfoValAvail like(SQLSMALLINT);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLGetLength(): Get the length of a LOB column
//
// hstmt = (input) statement handle
//   LocatorType = (input) type of locator. values are:
// SQL_C_BLOB_LOCATOR
// SQL_C_CLOB_LOCATOR
// SQL_C_DBCLOB_LOCATOR
//       Locator = (input) LOB locator to get length for
//Length = (output) returned length of LOB
// Indic = (output) always returns 0.
//
// Returns SQL_SUCCESS
// SQL_SUCCESS_WITH_INFO
// SQL_STILL_EXECUTING
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLGetLength like(SQLRETURN) ExtProc('SQLGetLength');
  hstmt like(SQLHSTMT) value;
  LocatorType like(SQLSMALLINT) value;
  Locator like(SQLINTEGER) value;
  Length like(SQLINTEGER);
  Indic like(SQLINTEGER);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLGetPosition(): Get the position of a search string in
//   a LOB column.
//
// hstmt = (input) statement handle
//   LocatorType = (input) type of locator. values are:
// SQL_C_BLOB_LOCATOR
// SQL_C_CLOB_LOCATOR
// SQL_C_DBCLOB_LOCATOR
//       Locator = (input) Source LOB locator (the LOB to be
// searched)
//   SrchLocator = (input) Search LOB locator (the LOB containing
// the string to search for -- only used
// if SearchLen = 0)
//     SearchFor = (input) String to search for, or *OMIT if
// SrchLocator should be used.
//     SearchLen = (input) Length of string to search for, or
// 0 if SrchLocator should be used.
//       FromPos = (input) position to start searching at
// (byte position for a BLOB/CLOB or
// character position for a DBCLOB)
//     LocatedAt = (output) position where matching string was
//  found.
// Indic = (output) always returns 0.
//
// Returns SQL_SUCCESS
// SQL_SUCCESS_WITH_INFO
// SQL_STILL_EXECUTING
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLGetPosition like(SQLRETURN) ExtProc('SQLGetPosition');
  hstmt like(SQLHSTMT) value;
  LocatorType like(SQLSMALLINT) value;
  Locator like(SQLINTEGER) value;
  SrchLocator like(SQLINTEGER) value;
  SearchFor char(32767) const options(*varsize:*omit);
  SearchLen like(SQLINTEGER) value;
  FromPos like(SQLINTEGER) value;
  LocatedAt like(SQLINTEGER);
  Indic like(SQLINTEGER);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLGetStmtAttr(): Get statement attribute
//
//     hstmt = (input) statement handle
//     fAttr = (input) attribute to retrieve
//   pvParam = (output) address of variable to receive value
//      bLen = (input) %size() of pvParam variable
//      sLen = (output) length of returned data
//
// Returns SQL_SUCCESS
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLGetStmtAttr like(SQLRETURN) ExtProc('SQLGetStmtAttr');
 hstmt like(SQLHSTMT) value;
 fAttr like(SQLINTEGER) value;
 pvParam like(SQLPOINTER) value;
 bLen like(SQLINTEGER) value;
 sLen like(SQLINTEGER);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLGetStmtOption(): Get statement option
//
//  Deprecated:  Use SQLGetStmtAttr()
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLGetStmtOption like(SQLRETURN) ExtProc('SQLGetStmtOption');
  hstmt like(SQLHSTMT) value;
  fAttr like(SQLINTEGER) value;
  pvParam like(SQLPOINTER) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLGetSubString(): Retrieve a portion of a LOB value
//
// hstmt = (input) statement handle
//   LocatorType = (input) type of locator. values are:
// SQL_C_BLOB_LOCATOR
// SQL_C_CLOB_LOCATOR
// SQL_C_DBCLOB_LOCATOR
//       Locator = (input) Source LOB locator
//       FromPos = (input) position of the first byte (BLOB/CLOB)
// or character (DBCLOB) to be returned
//     ForLength = (input) length of the substring
//    TargetType = (input) data type of the variable that results
// are placed into.
//       DataPtr = (output) address of the variable that results
//  are placed into
//       VarSize = (input) %size() of the variable that results
//  are placed into
//RtnLen = (output) returned length of data retrieved
// Indic = (output) always returns 0
//
// Returns SQL_SUCCESS
// SQL_SUCCESS_WITH_INFO
// SQL_STILL_EXECUTING
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLGetSubString like(SQLRETURN) ExtProc('SQLGetSubString');
  hstmt like(SQLHSTMT) value;
  LocatorType like(SQLSMALLINT) value;
  Locator like(SQLINTEGER) value;
  FromPos like(SQLINTEGER) value;
  ForLength like(SQLINTEGER) value;
  TargetType like(SQLSMALLINT) value;
  DataPtr like(SQLPOINTER) value;
  VarSize like(SQLINTEGER) value;
  RtnLen like(SQLINTEGER);
  Indic like(SQLINTEGER);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLGetTypeInfo(): Get Information About the Data Types
//   supported by the connected DBMS
//
//      hstmt = (input) statement handle
//   DataType = (input) SQL data type to query for
//
// Returns SQL_SUCCESS
// SQL_ERROR
// SQL_INVALID_HANDLE
//  -results are supplied in a result set-
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLGetTypeInfo like(SQLRETURN) ExtProc('SQLGetTypeInfo');
  hstmt like(SQLHSTMT) value;
  DataType like(SQLINTEGER) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLLanguages(): Get SQL Dialect or conformance information
//
//    hstmt = (input) statement handle
//
// Returns SQL_SUCCESS
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
//  -results are supplied in a result set-
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLLanguages like(SQLRETURN) ExtProc('SQLLanguages');
  hstmt like(SQLHSTMT) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLMoreResults(): Close the cursor to the current result
//   set and determine if there are more
//   result sets available.
//
//    hstmt = (input) statement handle
//
// Returns SQL_SUCCESS  <- when more result sets found
// SQL_SUCCESS_WITH_INFO
// SQL_STILL_EXECUTING
// SQL_ERROR
// SQL_INVALID_HANDLE
// SQL_NO_DATA_FOUND    <- when no more are found.
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLMoreResults like(SQLRETURN) ExtProc('SQLLanguages');
  hstmt like(SQLHSTMT) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLNativeSQL(): Get native SQL Text
//
// This is ostensibly provided to see the statement after any
// vendor escape clauses have been interpreted.  However, the
// iSeries doesn't use vendor escape clauses.  This function
// is still useful as an SQL statement syntax checker.
//
//       hstmt = (input) statement handle
//      inStmt = (input) SQL statement to interpret
//   inStmtLen = (input) should be SQL_NTS
//     outStmt = (output) returned statement
// outStmtSize = (i/o) variable size of output statement.
//this'll be changed to SQL_NULL_DATA if
//no output string is generated.
//
// Returns SQL_SUCCESS
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLNativeSQL like(SQLRETURN) ExtProc('SQLNativeSQL');
  hdbc like(SQLHDBC) value;
  inStmt pointer value options(*string);
  inStmtLen like(SQLINTEGER) value;
  outStmt char(32767) options(*varsize);
  outStmtSize like(SQLINTEGER);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLNextResult(): Associate Next Result Set with a
//  statement handle.
//
// This lets you move the next result set from the current
// statement handle to another one so that it can be processed
// at the same time as the current one.
//
//     hstmt = (input) Statement handle containing result sets
//  nextstmt = (input) Statement handle to move the next
//     result set to.
//
// Returns SQL_SUCCESS
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// SQL_NO_DATA_FOUND   <-- if no more result sets found
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLNextResult like(SQLRETURN) ExtProc('SQLNextResult');
  hstmt like(SQLHSTMT) value;
  nextstmt like(SQLHSTMT) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLNumParams(): Returns the number of parameter markers
// in an SQL statement.
//
//  hstmt = (input) statement handle
//  count = (output) number of parameters
//
// Returns SQL_SUCCESS
// SQL_SUCCESS_WITH_INFO
// SQL_STILL_EXECUTING
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLNumParams like(SQLRETURN) ExtProc('SQLNumParams');
  hstmt like(SQLHSTMT) value;
  count like(SQLSMALLINT);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLNumResultCols(): Returns the number of columns in the
// result set.
//
//  hstmt = (input) statement handle
//  count = (output) number of result columns
//
// Returns SQL_SUCCESS
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLNumResultCols like(SQLRETURN) ExtProc('SQLNumResultCols');
  hstmt like(SQLHSTMT) value;
  count like(SQLSMALLINT);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLParamData(): Get next parameter for which data is needed
//
// This is used when SQL_DATA_AT_EXEC is passed to SQLBindParam
// it is used to iterate through the parameters, while
// SQLPutData() is used to set the actual data values.
//
//    hstmt = (input) Statement handle
// rgbValue = (output) This is assigned by your application
// when SQLBindParam() is called.  Here it's
// returned to you.  Use it as you like.
//
// Returns SQL_SUCCESS <-- returned when all data set.
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// SQL_NEED_DATA       <-- returned to tell you to call
// SQLPutData()
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLParamData like(SQLRETURN)  ExtProc('SQLParamData');
  hstmt like(SQLHSTMT) value;
  rgbValue like(SQLINTEGER) options(*omit);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLParamOptions():  Specify an Input Array for a Parameter
//
//  Signals that multiple row INSERT statements are to be
//  used.  This statement specifies the size of the array
//  of values to be inserted, SQLBindParam() must specify
//  the array to insert from.  Parameter values must be
//  arranged in a row-wise fashion and must be contiguous.
//
//hstmt = (input) statement handle
// Crow = (input) number of values for each parameter
//(i.e. size of array.)
//  FetchOffset = (output) not used
//
// Returns SQL_SUCCESS
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLParamOptions like(SQLRETURN) ExtProc('SQLParamOptions');
  hstmt like(SQLHSTMT) value;
  Crow like(SQLINTEGER) value;
  FetchOffset like(SQLINTEGER) options(*omit);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLPrepare(): Prepare an SQL statement to be executed
//       one or more times.
//
//    hstmt = (input) statement handle to prepare into
// szSqlStr = (input) SQL Statement to prepare
// cbSqlStr = (input) length of SQL statement
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLPrepare like(SQLRETURN) Extproc('SQLPrepare');
  hstmt like(SQLHSTMT) value;
  szSqlStr pointer value options(*string);
  cbSqlStr like(SQLINTEGER) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLPrimaryKeys(): Get the list of primary key columns
//
//  NOTE: Results from this API are returned in a result set.
//To get them, use SQLFetch() and friends.
//
//  stmt = (input) statement handle
//       catalog = (input) must be *OMIT
//    cataloglen = (input) must be 0
//schema = (input) schema qualifier of table
//     schemalen = (input) schema len, or SQL_NTS
// table = (input) name of table
//      tablelen = (input) table name len, or SQL_NTS
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// SQL_STILL_EXECUTING
// - results are returned in a result set -
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLPrimaryKeys like(SQLRETURN) Extproc('SQLPrimaryKeys');
  stmt like(SQLHSTMT) value;
  catalog char(32767) const options(*varsize:*omit);
  cataloglen like(SQLINTEGER) value;
  schema pointer value options(*string);
  schemalen like(SQLINTEGER) value;
  table pointer value options(*string);
  tablelen like(SQLINTEGER) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLProcedureColumns(): Get I/O Parameter Info for a procedure
//
//stmt = (input) statement handle
//     catalog = (input) must be *OMIT
//  cataloglen = (input) must be 0
//      schema = (input) schema name (pattern)
//   schemalen = (input) length of schema (SQL_NTS)
//    procName = (input) procedure name to return
//     procLen = (input) length of procName (SQL_NTS)
//     procLen = (input) length of procName (SQL_NTS)
//  columnName = (input) pattern value for cols to return
//   columnLen = (input) length of columnName (SQL_NTS)
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// SQL_STILL_EXECUTING
// - results are returned in a result set -
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLProcedureColumns like(SQLRETURN) Extproc('SQLProcedureColumns');
  stmt like(SQLHSTMT) value;
  catalog char(32767) const options(*varsize:*omit);
  cataloglen like(SQLINTEGER) value;
  schema pointer value options(*string);
  schemalen like(SQLINTEGER) value;
  procName pointer value options(*string);
  procLen like(SQLINTEGER) value;
  columnName pointer value options(*string);
  colLen like(SQLINTEGER) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLProcedures(): Return a list of registered procedures
//
//stmt = (input) statement handle
//     catalog = (input) must be *OMIT
//  cataloglen = (input) must be 0
//      schema = (input) pattern-value of schema
//   schemalen = (input) length of schema (SQL_NTS)
//    procName = (input) pattern-value of procedure name
//     proclen = (input) length of procName (SQL_NTS)
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// SQL_STILL_EXECUTING
// - results are returned in a result set -
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLProcedures like(SQLRETURN) Extproc('SQLProcedures');
  stmt like(SQLHSTMT) value;
  catalog char(32767) const options(*varsize:*omit);
  cataloglen like(SQLINTEGER) value;
  schema pointer value options(*string);
  schemalen like(SQLINTEGER) value;
  procName pointer value options(*string);
  procLen like(SQLINTEGER) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLPutData(): Pass data values at exec time for a parameter
//
//  This procedure is always called after SQLParamData()
//  and can be called multiple times to set a large value
//  in chunks.  When finished, SQLParamData() must be
//  called again to move to the next parameter.
//
//      stmt = (input) statement handle
//      data = (input) pointer to data to place in parameter
//   datalen = (input) length of data in previous parameter
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLPutData like(SQLRETURN) Extproc('SQLPutData');
  stmt like(SQLHSTMT) value;
  data like(SQLPOINTER) value;
  datalen like(SQLINTEGER) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLReleaseEnv(): Release all SQL CLI Environment Resources
//
//     henv = (input) environment handle to blow away
//    (SQLFreeConnect must already be done.)
//
// Returns SQL_SUCCESS
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLReleaseEnv like(SQLRETURN) Extproc('SQLReleaseEnv');
  henv like(SQLHENV) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLRowCount(): Get Row Count of last SQL statement
//
//  Call this after an UPDATE, DELETE or INSERT to get a count
//  of the number of rows that were affected.
//
//    hstmt = (input) statement handle
//     crow = (output) count of rows returned by statement
//
// Returns SQL_SUCCESS
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLRowCount like(SQLRETURN) Extproc('SQLRowCount');
  hstmt like(SQLHSTMT) value;
  crow like(SQLINTEGER);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLSetConnectAttr(): Set connection attributes
//
//    hdbc = (input) connection handle to set attributes of
//   fAttr = (input) Attribute to set
//  vParam = (input) pointer to new attribute value
//    sLen = (input) length of new attribute value
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLSetConnectAttr like(SQLRETURN) Extproc('SQLSetConnectAttr');
  hdbc like(SQLHDBC) value;
  fAttr like(SQLINTEGER) value;
  vParam like(SQLPOINTER) value;
  sLen like(SQLINTEGER) value;
end-pr;

dcl-pr SQLSetConnectAttrI like(SQLRETURN) Extproc('SQLSetConnectAttr');
  hdbc like(SQLHDBC) value;
  fAttr like(SQLINTEGER) value;
  vParam like(SQLINTEGER) const;
  sLen like(SQLINTEGER) value;
end-pr;

dcl-pr SQLSetConnectAttrS like(SQLRETURN)  Extproc('SQLSetConnectAttr');
  hdbc like(SQLHDBC) value;
  fAttr like(SQLINTEGER) value;
  vParam char(32767) options(*varsize) const;
  sLen like(SQLINTEGER) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLSetConnectOption(): Set connection option
//
// DEPRECATED: Use SQLSetConnectAttr() instead.  This is the
// same function, but the API will make assuptions about the
// size of vParam.
//
//    hdbc = (input) connection handle to set attributes of
// fOption = (input) Option to set
//  vParam = (input) pointer to new attribute value
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLSetConnectOption like(SQLRETURN) Extproc('SQLSetConnectOption');
  hdbc like(SQLHDBC) value;
  fOption like(SQLINTEGER) value;
  vParam like(SQLPOINTER) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLSetCursorName(): Set a friendly name for an SQL Cursor
//
//hstmt = (input) statement handle
//   CursorName = (input) New cursor name to set (<=18 chars)
//    CursorLen = (input) Length of cursor name (SQL_NTS)
//
// Returns SQL_SUCCESS,
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLSetCursorName like(SQLRETURN) Extproc('SQLSetCursorName');
  hstmt  like(SQLHSTMT) value;
  CursorName pointer value options(*string);
  CursorLen like(SQLSMALLINT) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLSetDescField(): Set a descriptor field
//
//       hdesc = (input) descriptor handle
//irec = (input) record number
//   fDescType = (input) descriptor field to set
//      buffer = (input) pointer to buffer (value to set)
//   bufferlen = (input) length of buffer parameter
//
// Returns SQL_SUCCESS
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLSetDescField like(SQLRETURN) Extproc('SQLSetDescField');
  hdesc like(SQLHDESC) value;
  irec like(SQLSMALLINT) value;
  fDescType like(SQLSMALLINT) value;
  buffer like(SQLPOINTER) value;
  bufferlen like(SQLINTEGER) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLSetDescRec(): Set all descriptor fields
//
//       hdesc = (input) descriptor handle
//irec = (input) record number
//Type = (input) TYPE field for record
//     subtype = (input) DATETIME_INTERVAL_CODE field for
//       records where TYPE=SQL_DATETIME
//      length = (input) LENGTH field for record
//prec = (input) PRECISION field for record
//       scale = (input) SCALE field for record
//data = (input) DATA_PTR field for record
//sLen = (input) LENGTH_PTR field for record
//       indic = (input) INDICATOR_PTR field for record
//
// Returns SQL_SUCCESS
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLSetDescRec like(SQLRETURN) Extproc('SQLSetDescRec');
  hdesc like(SQLHDESC) value;
  irec like(SQLSMALLINT) value;
  type like(SQLSMALLINT) value;
  subtype like(SQLSMALLINT) value;
  length like(SQLINTEGER) value;
  prec like(SQLSMALLINT) value;
  scale like(SQLSMALLINT) value;
  data like(SQLPOINTER) value;
  sLen like(SQLINTEGER);
  indic like(SQLINTEGER);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLSetEnvAttr(): Set environment attributes
//
//    henv = (input) environment to set attributes of
//   fAttr = (input) Attribute to set
//  vParam = (input) pointer to new attribute value
//    sLen = (input) length of new attribute value
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLSetEnvAttr like(SQLRETURN) Extproc('SQLSetEnvAttr');
  henv like(SQLHENV) value;
  fAttr like(SQLINTEGER) value;
  vParam like(SQLPOINTER) value;
  sLen  like(SQLINTEGER) value;
end-pr;

dcl-pr SQLSetEnvAttrI like(SQLRETURN) Extproc('SQLSetEnvAttr');
  henv like(SQLHENV) value;
  fAttr like(SQLINTEGER) value;
  vParam like(SQLINTEGER) const;
  sLen like(SQLINTEGER) value;
end-pr;

dcl-pr SQLSetEnvAttrS like(SQLRETURN) Extproc('SQLSetEnvAttr');
  henv like(SQLHENV) value;
  fAttr like(SQLINTEGER) value;
  vParam char(32767) options(*varsize) const;
  sLen like(SQLINTEGER) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLSetParam(): Set Parameter
//
//      hstmt = (input) statement handle
//       ipar = (input) parameter marker number to bind
//     fCType = (input) application data type for column
//   fSqlType = (input) SQL data type for column
// cbParamDef = (input) precision of corresponding param marker
//    ibScale = (input) scale of parm marker (decimal places)
//   rgbValue = (i/o)   pointer to variable for data
//or SQL_NULL_DATA if no data.
//   pcbValue = (input) length of data, or SQL_NTS, or zero
//or *OMIT if no data
//
// Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLSetParam like(SQLRETURN) ExtProc('SQLSetParam');
  hstmt like(SQLHSTMT) value;
  ipar like(SQLSMALLINT) value;
  fCType like(SQLSMALLINT) value;
  fSqlType like(SQLSMALLINT) value;
  cbParamDef like(SQLINTEGER) value;
  ibScale like(SQLSMALLINT) value;
  rgbValue like(SQLPOINTER) value;
  pcbValue like(SQLINTEGER) const options(*omit);
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLSetStmtAttr(): Set statement attributes
//
//    stmt = (input) statement to set attributes of
//   fAttr = (input) Attribute to set
//  vParam = (input) pointer to new attribute value
//    sLen = (input) length of new attribute value
//
// Returns SQL_SUCCESS,
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLSetStmtAttr like(SQLRETURN) Extproc('SQLSetStmtAttr');
  stmt like(SQLHSTMT) value;
  fAttr like(SQLINTEGER) value;
  vParam like(SQLPOINTER) value;
  sLen like(SQLINTEGER) value;
end-pr;

dcl-pr SQLSetStmtAttrI like(SQLRETURN) Extproc('SQLSetStmtAttr');
  stmt like(SQLHSTMT) value;
  fAttr like(SQLINTEGER) value;
  vParam like(SQLINTEGER) const;
  sLen like(SQLINTEGER) value;
end-pr;

dcl-pr SQLSetStmtAttrS like(SQLRETURN) Extproc('SQLSetStmtAttr');
  stmt like(SQLHSTMT) value;
  fAttr like(SQLINTEGER) value;
  vParam char(32767) options(*varsize) const;
  sLen like(SQLINTEGER) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLSetStmtOption(): Set Statement Option
//
//  Deprecated:  Use SQLSetStmtAttr() instead.
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLSetStmtOption like(SQLRETURN) Extproc('SQLSetStmtOption');
  hstmt like(SQLHSTMT) value;
  fOption like(SQLINTEGER) value;
  vParam like(SQLPOINTER) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLSpecialColumns(): Get Special (Row identifying) columns
//
//       hstmt = (input) Statement handle
//     ColType = (input) reserved for future use (ignored)
//     Catalog = (input) Must be *OMIT
//  CatalogLen = (input) Must be 0
//  SchemaName = (input) Schema qualifier for table
//   SchemaLen = (input) Length of SchemaName parm, use SQL_NTS
//   TableName = (input) Table name to get cols from
//    TableLen = (input) Length of TableName parm, use SQL_NTS
//       Scope = (input) duration for which identifier is valid
//       SQL_SCOPE_CURROW      -- until fetch
//       SQL_SCOPE_TRANSACTION -- until commit
//       SQL_SCOPE_SESSION     -- until disconnect
//    Nullable = (input) Return null-capable columns?
//       SQL_NO_NULLS = don't return them.
//       SQL_NULLABLE = return them.
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// - results are returned in a result set -
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLSpecialColumns like(SQLRETURN) Extproc('SQLSpecialColumns');
  hstmt like(SQLHSTMT) value;
  ColType like(SQLSMALLINT) value;
  Catalog char(32767) const options(*varsize:*omit);
  CataLogLen like(SQLSMALLINT) value;
  SchemaName pointer value options(*string);
  SchemaLen like(SQLSMALLINT) value;
  TableName pointer value options(*string);
  TableLen like(SQLSMALLINT) value;
  Scope like(SQLSMALLINT) value;
  Nullable like(SQLSMALLINT) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLStatistics(): Get Index and Statistics Information
//  For a Base Table
//
//       hstmt = (input) Statement handle
//     Catalog = (input) Must be *omit
//  CatalogLen = (input) Must be 0
//  SchemaName = (input) Schema qualifier of table
//   SchemaLen = (input) Length of SchemaName parm, use SQL_NTS
//   TableName = (input) Name of table to get stats/index for
//    TableLen = (input) Length of TableName parm, use SQL_NTS
//      Unique = (input) Type of index info to return
//      SQL_INDEX_UNIQUE = only unique indexes
//      SQL_INDEX_ALL = every index
//    Accuracy = (input) Not used.  Pass 0
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// - results are returned in a result set -
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLStatistics like(SQLRETURN) Extproc('SQLStatistics');
  hstmt like(SQLHSTMT) value;
  Catalog char(32767) const options(*varsize:*omit);
  CataLogLen like(SQLSMALLINT) value;
  SchemaName pointer value options(*string);
  SchemaLen like(SQLSMALLINT) value;
  TableName  pointer value options(*string);
  TableLen like(SQLSMALLINT) value;
  Unique like(SQLSMALLINT) value;
  Accuracy like(SQLSMALLINT) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLTablePriveledges(): Get tables and associated priveldges
//
//       hstmt = (input) Statement handle
//     Catalog = (input) Must be *omit
//  CatalogLen = (input) Must be 0
//  SchemaName = (input) Schema qualifier, may contain patterns
//   SchemaLen = (input) Length of SchemaName parm, use SQL_NTS
//   TableName = (input) Name of table, may contain patterns
//    TableLen = (input) Length of TableName parm, use SQL_NTS
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// SQL_STILL_EXECUTING
// - results are returned in a result set -
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLTablePriveledges like(SQLRETURN) Extproc('SQLTablePriveledges');
  hstmt like(SQLHSTMT) value;
  Catalog char(32767) const options(*varsize:*omit);
  CataLogLen like(SQLSMALLINT) value;
  SchemaName pointer value options(*string);
  SchemaLen like(SQLSMALLINT) value;
  TableName pointer value options(*string);
  TableLen like(SQLSMALLINT) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLTables(): Get Table Information
//
//       hstmt = (input) Statement handle
//     Catalog = (input) Must be *omit
//  CatalogLen = (input) Must be 0
//  SchemaName = (input) Schema qualifier, may contain patterns
//   SchemaLen = (input) Length of SchemaName parm, use SQL_NTS
//   TableName = (input) Name of table, may contain patterns
//    TableLen = (input) Length of TableName parm, use SQL_NTS
//   TableType = (input) Types of tables to return.  This is
//       a comma-separated list of the following
//ALL,BASE TABLE,TABLE,VIEW,SYSTEM TABLE
//       or you can pass *NULL to mean "ALL"
// TableTypLen = (input) Length of TableType parm, use SQL_NTS
//       or 0 if you pass *NULL
//
// Returns SQL_SUCCESS,
// SQL_SUCCESS_WITH_INFO
// SQL_ERROR
// SQL_INVALID_HANDLE
// - results are returned in a result set -
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLTables like(SQLRETURN) Extproc('SQLTables');
  hstmt like(SQLHSTMT) value;
  Catalog char(32767) const options(*varsize:*omit);
  CataLogLen like(SQLSMALLINT) value;
  SchemaName pointer value options(*string);
  SchemaLen like(SQLSMALLINT) value;
  TableName pointer value options(*string);
  TableLen like(SQLSMALLINT) value;
  TableType pointer value options(*string);
  TableTypLen like(SQLSMALLINT) value;
end-pr;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// SQLTransact():  Commit or roll-back the current transaction
//
//    henv = (input) environment handle.  Ignored unless
//   hdbc is set to SQL_NULL_HDBC
//    hdbc = (input) connection handle.
//   fType = (input) desired action for transaction
//   SQL_COMMIT
//   SQL_ROLLBACK
//   SQL_COMMIT_HOLD
//   SQL_ROLLBACK_HOLD
//
// Returns SQL_SUCCESS,
// SQL_ERROR
// SQL_INVALID_HANDLE
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
dcl-pr SQLTransact like(SQLRETURN) Extproc('SQLTransact');
  henv like(SQLHENV) value;
  hdbc like(SQLHDBC) value;
  fType like(SQLSMALLINT) value;
end-pr;
