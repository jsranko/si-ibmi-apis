**FREE
         /if not defined(SISQLDIAGP)
         /define SISQLDIAGP
         /else
         /eof
         /endif

        //==========================================================================================
        //             Templates
        //==========================================================================================

         // Statement Information Item template;
         dcl-s tSISQLDIAG_COMMAND_FUNCTION VARCHAR(128) template;
         dcl-s tSISQLDIAG_COMMAND_FUNCTION_CODE INT(10) template;
         dcl-s tSISQLDIAG_DB2_DIAGNOSTIC_CONVERSION_ERROR INT(10) template;
         dcl-s tSISQLDIAG_DB2_GET_DIAGNOSTICS_DIAGNOSTICS VARCHAR(32740) template;
         dcl-s tSISQLDIAG_DB2_LAST_ROW INT(10) template;
         dcl-s tSISQLDIAG_DB2_NUMBER_CONNECTIONS INT(10) template;
         dcl-s tSISQLDIAG_DB2_NUMBER_PARAMETER_MARKERS INT(10) template;
         dcl-s tSISQLDIAG_DB2_NUMBER_RESULT_SETS INT(10) template;
         dcl-s tSISQLDIAG_DB2_NUMBER_ROWS PACKED(31:0) template;
         dcl-s tSISQLDIAG_DB2_NUMBER_SUCCESSFUL_SUBSTMTS INT(10) template;
         dcl-s tSISQLDIAG_DB2_RELATIVE_COST_ESTIMATE INT(10) template;
         dcl-s tSISQLDIAG_DB2_RETURN_STATUS INT(10) template;
         dcl-s tSISQLDIAG_DB2_ROW_COUNT_SECONDARY PACKED(31:0) template;
         dcl-s tSISQLDIAG_DB2_ROW_LENGTH INT(10) template;
         dcl-s tSISQLDIAG_DB2_SQL_ATTR_CONCURRENCY CHAR(1) template;
         dcl-s tSISQLDIAG_DB2_SQL_ATTR_CURSOR_CAPABILITY CHAR(1) template;
         dcl-s tSISQLDIAG_DB2_SQL_ATTR_CURSOR_HOLD CHAR(1) template;
         dcl-s tSISQLDIAG_DB2_SQL_ATTR_CURSOR_ROWSET CHAR(1) template;
         dcl-s tSISQLDIAG_DB2_SQL_ATTR_CURSOR_SCROLLABLE CHAR(1) template;
         dcl-s tSISQLDIAG_DB2_SQL_ATTR_CURSOR_SENSITIVITY CHAR(1) template;
         dcl-s tSISQLDIAG_DB2_SQL_ATTR_CURSOR_TYPE CHAR(1) template;
         dcl-s tSISQLDIAG_DB2_SQL_NESTING_LEVEL INT(10) template;
         dcl-s tSISQLDIAG_DYNAMIC_FUNCTION VARCHAR(128) template;
         dcl-s tSISQLDIAG_DYNAMIC_FUNCTION_CODE INT(10) template;
         dcl-s tSISQLDIAG_MORE CHAR(1) template;
         dcl-s tSISQLDIAG_NUMBER INT(10) template;
         dcl-s tSISQLDIAG_ROW_COUNT PACKED(31:0) template;
         dcl-s tSISQLDIAG_TRANSACTION_ACTIVE INT(10) template;
         dcl-s tSISQLDIAG_TRANSACTIONS_COMMITTED INT(10) template;
         dcl-s tSISQLDIAG_TRANSACTIONS_ROLLED_BACK INT(10) template;

         // Connection Information Item template;
         dcl-s tSISQLDIAG_CONNECTION_NAME VARCHAR(128) template;
         dcl-s tSISQLDIAG_DB2_AUTHENTICATION_TYPE CHAR(1) template;
         dcl-s tSISQLDIAG_DB2_AUTHORIZATION_ID VARCHAR(128) template;
         dcl-s tSISQLDIAG_DB2_CONNECTION_METHOD CHAR(1) template;
         dcl-s tSISQLDIAG_DB2_CONNECTION_NUMBER INT(10) template;
         dcl-s tSISQLDIAG_DB2_CONNECTION_STATE INT(10) template;
         dcl-s tSISQLDIAG_DB2_CONNECTION_STATUS INT(10) template;
         dcl-s tSISQLDIAG_DB2_CONNECTION_TYPE INT(5) template;
         dcl-s tSISQLDIAG_DB2_DYN_QUERY_MGMT INT(10) template;
         dcl-s tSISQLDIAG_DB2_ENCRYPTION_TYPE CHAR(1) template;
         dcl-s tSISQLDIAG_DB2_PRODUCT_ID VARCHAR(8) template;
         dcl-s tSISQLDIAG_DB2_SERVER_CLASS_NAME VARCHAR(128) template;
         dcl-s tSISQLDIAG_DB2_SERVER_NAME VARCHAR(128) template;

         // Condition Information Item template;
         dcl-s tSISQLDIAG_CATALOG_NAME VARCHAR(128) template;
         dcl-s tSISQLDIAG_CLASS_ORIGIN VARCHAR(128) template;
         dcl-s tSISQLDIAG_COLUMN_NAME VARCHAR(128) template;
         dcl-s tSISQLDIAG_CONDITION_IDENTIFIER VARCHAR(128) template;
         dcl-s tSISQLDIAG_CONDITION_NUMBER INT(10) template;
         dcl-s tSISQLDIAG_CONSTRAINT_CATALOG VARCHAR(128) template;
         dcl-s tSISQLDIAG_CONSTRAINT_NAME VARCHAR(128) template;
         dcl-s tSISQLDIAG_CONSTRAINT_SCHEMA VARCHAR(128) template;
         dcl-s tSISQLDIAG_CURSOR_NAME VARCHAR(128) template;
         dcl-s tSISQLDIAG_DB2_ERROR_CODE1 INT(10) template;
         dcl-s tSISQLDIAG_DB2_ERROR_CODE2 INT(10) template;
         dcl-s tSISQLDIAG_DB2_ERROR_CODE3 INT(10) template;
         dcl-s tSISQLDIAG_DB2_ERROR_CODE4 INT(10) template;
         dcl-s tSISQLDIAG_DB2_INTERNAL_ERROR_POINTER INT(10) template;
         dcl-s tSISQLDIAG_DB2_LINE_NUMBER INT(10) template;
         dcl-s tSISQLDIAG_DB2_MESSAGE_ID CHAR(10) template;
         dcl-s tSISQLDIAG_DB2_MESSAGE_ID1 VARCHAR(7) template;
         dcl-s tSISQLDIAG_DB2_MESSAGE_ID2 VARCHAR(7) template;
         dcl-s tSISQLDIAG_DB2_MESSAGE_KEY INT(10) template;
         dcl-s tSISQLDIAG_DB2_MODULE_DETECTING_ERROR VARCHAR(128) template;
         dcl-s tSISQLDIAG_DB2_NUMBER_FAILING_STATEMENTS INT(10) template;
         dcl-s tSISQLDIAG_DB2_OFFSET INT(10) template;
         dcl-s tSISQLDIAG_DB2_ORDINAL_TOKEN_n VARCHAR(32740) template;
         dcl-s tSISQLDIAG_DB2_PARTITION_NUMBER INT(10) template;
         dcl-s tSISQLDIAG_DB2_REASON_CODE INT(10) template;
         dcl-s tSISQLDIAG_DB2_RETURNED_SQLCODE INT(10) template;
         dcl-s tSISQLDIAG_DB2_ROW_NUMBER INT(10) template;
         dcl-s tSISQLDIAG_DB2_SQLERRD_SET CHAR(1) template;
         dcl-s tSISQLDIAG_DB2_SQLERRD1 INT(10) template;
         dcl-s tSISQLDIAG_DB2_SQLERRD2 INT(10) template;
         dcl-s tSISQLDIAG_DB2_SQLERRD3 INT(10) template;
         dcl-s tSISQLDIAG_DB2_SQLERRD4 INT(10) template;
         dcl-s tSISQLDIAG_DB2_SQLERRD5 INT(10) template;
         dcl-s tSISQLDIAG_DB2_SQLERRD6 INT(10) template;
         dcl-s tSISQLDIAG_DB2_TOKEN_COUNT INT(10) template;
         dcl-s tSISQLDIAG_DB2_TOKEN_STRING VARCHAR(1000) template;
         dcl-s tSISQLDIAG_MESSAGE_LENGTH INT(10) template;
         dcl-s tSISQLDIAG_MESSAGE_OCTET_LENGTH INT(10) template;
         dcl-s tSISQLDIAG_MESSAGE_TEXT VARCHAR(32740) template;
         dcl-s tSISQLDIAG_PARAMETER_MODE VARCHAR(5) template;
         dcl-s tSISQLDIAG_PARAMETER_NAME VARCHAR(128) template;
         dcl-s tSISQLDIAG_PARAMETER_ORDINAL_POSITION INT(10) template;
         dcl-s tSISQLDIAG_RETURNED_SQLSTATE CHAR(5) template;
         dcl-s tSISQLDIAG_ROUTINE_CATALOG VARCHAR(128) template;
         dcl-s tSISQLDIAG_ROUTINE_NAME VARCHAR(128) template;
         dcl-s tSISQLDIAG_ROUTINE_SCHEMA VARCHAR(128) template;
         dcl-s tSISQLDIAG_SCHEMA_NAME VARCHAR(128) template;
         dcl-s tSISQLDIAG_SERVER_NAME VARCHAR(128) template;
         dcl-s tSISQLDIAG_SPECIFIC_NAME VARCHAR(128) template;
         dcl-s tSISQLDIAG_SUBCLASS_ORIGIN VARCHAR(128) template;
         dcl-s tSISQLDIAG_TABLE_NAME VARCHAR(128) template;
         dcl-s tSISQLDIAG_TRIGGER_CATALOG VARCHAR(128) template;
         dcl-s tSISQLDIAG_TRIGGER_NAME VARCHAR(128) template;
         dcl-s tSISQLDIAG_TRIGGER_SCHEMA VARCHAR(128) template;

