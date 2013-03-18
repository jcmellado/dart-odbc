/*
  Copyright (c) 2013 Juan Mellado

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
*/

/*
References:
- Microsoft Open Database Connectivity (ODBC)
  http://msdn.microsoft.com/en-us/library/windows/desktop/ms710252(v=vs.85).aspx
*/

part of odbc;

// Special length/indicator values
const int SQL_NULL_DATA    = -1;
const int SQL_DATA_AT_EXEC = -2;

// Return values from functions
const int SQL_SUCCESS              =   0;
const int SQL_SUCCESS_WITH_INFO    =   1;
const int SQL_NO_DATA              = 100;
const int SQL_PARAM_DATA_AVAILABLE = 101;
const int SQL_ERROR                =  -1;
const int SQL_INVALID_HANDLE       =  -2;
const int SQL_STILL_EXECUTING      =   2;
const int SQL_NEED_DATA            =  99;

// Test for SQL_SUCCESS or SQL_SUCCESS_WITH_INFO
bool sqlSucceeded(int sqlReturn) =>
    (sqlReturn == SQL_SUCCESS) || (sqlReturn == SQL_SUCCESS_WITH_INFO);

// Flags for null-terminated string
const int SQL_NTS  = -3;
const int SQL_NTSL = -3;

// Maximum message length
const int SQL_MAX_MESSAGE_LENGTH = 512;

// Date/time length constants
const int SQL_DATE_LEN      = 10;
const int SQL_TIME_LEN      =  8;
const int SQL_TIMESTAMP_LEN = 19;

// Handle type identifiers
const int SQL_HANDLE_ENV  = 1;
const int SQL_HANDLE_DBC  = 2;
const int SQL_HANDLE_STMT = 3;
const int SQL_HANDLE_DESC = 4;

// Environment attribute
const int SQL_ATTR_OUTPUT_NTS = 10001;

// Connection attributes
const int SQL_ATTR_AUTO_IPD    = 10001;
const int SQL_ATTR_METADATA_ID = 10014;

// Statement attributes
const int SQL_ATTR_APP_ROW_DESC       = 10010;
const int SQL_ATTR_APP_PARAM_DESC     = 10011;
const int SQL_ATTR_IMP_ROW_DESC       = 10012;
const int SQL_ATTR_IMP_PARAM_DESC     = 10013;
const int SQL_ATTR_CURSOR_SCROLLABLE  =    -1;
const int SQL_ATTR_CURSOR_SENSITIVITY =    -2;

// SQL_ATTR_CURSOR_SCROLLABLE values
const int SQL_NONSCROLLABLE =  0;
const int SQL_SCROLLABLE    =  1;

// Identifiers of fields in the SQL descriptor
const int SQL_DESC_COUNT                  = 1001;
const int SQL_DESC_TYPE                   = 1002;
const int SQL_DESC_LENGTH                 = 1003;
const int SQL_DESC_OCTET_LENGTH_PTR       = 1004;
const int SQL_DESC_PRECISION              = 1005;
const int SQL_DESC_SCALE                  = 1006;
const int SQL_DESC_DATETIME_INTERVAL_CODE = 1007;
const int SQL_DESC_NULLABLE               = 1008;
const int SQL_DESC_INDICATOR_PTR          = 1009;
const int SQL_DESC_DATA_PTR               = 1010;
const int SQL_DESC_NAME                   = 1011;
const int SQL_DESC_UNNAMED                = 1012;
const int SQL_DESC_OCTET_LENGTH           = 1013;
const int SQL_DESC_ALLOC_TYPE             = 1099;

// Identifiers of fields in the diagnostics area
const int SQL_DIAG_RETURNCODE            =  1;
const int SQL_DIAG_NUMBER                =  2;
const int SQL_DIAG_ROW_COUNT             =  3;
const int SQL_DIAG_SQLSTATE              =  4;
const int SQL_DIAG_NATIVE                =  5;
const int SQL_DIAG_MESSAGE_TEXT          =  6;
const int SQL_DIAG_DYNAMIC_FUNCTION      =  7;
const int SQL_DIAG_CLASS_ORIGIN          =  8;
const int SQL_DIAG_SUBCLASS_ORIGIN       =  9;
const int SQL_DIAG_CONNECTION_NAME       = 10;
const int SQL_DIAG_SERVER_NAME           = 11;
const int SQL_DIAG_DYNAMIC_FUNCTION_CODE = 12;

// Dynamic function codes
const int SQL_DIAG_ALTER_DOMAIN          =  3;
const int SQL_DIAG_ALTER_TABLE           =  4;
const int SQL_DIAG_CALL                  =  7;
const int SQL_DIAG_CREATE_ASSERTION      =  6;
const int SQL_DIAG_CREATE_CHARACTER_SET  =  8;
const int SQL_DIAG_CREATE_COLLATION      = 10;
const int SQL_DIAG_CREATE_DOMAIN         = 23;
const int SQL_DIAG_CREATE_INDEX          = -1;
const int SQL_DIAG_CREATE_SCHEMA         = 64;
const int SQL_DIAG_CREATE_TABLE          = 77;
const int SQL_DIAG_CREATE_TRANSLATION    = 79;
const int SQL_DIAG_CREATE_VIEW           = 84;
const int SQL_DIAG_DELETE_WHERE          = 19;
const int SQL_DIAG_DROP_ASSERTION        = 24;
const int SQL_DIAG_DROP_CHARACTER_SET    = 25;
const int SQL_DIAG_DROP_COLLATION        = 26;
const int SQL_DIAG_DROP_DOMAIN           = 27;
const int SQL_DIAG_DROP_INDEX            = -2;
const int SQL_DIAG_DROP_SCHEMA           = 31;
const int SQL_DIAG_DROP_TABLE            = 32;
const int SQL_DIAG_DROP_TRANSLATION      = 33;
const int SQL_DIAG_DROP_VIEW             = 36;
const int SQL_DIAG_DYNAMIC_DELETE_CURSOR = 38;
const int SQL_DIAG_DYNAMIC_UPDATE_CURSOR = 81;
const int SQL_DIAG_GRANT                 = 48;
const int SQL_DIAG_INSERT                = 50;
const int SQL_DIAG_REVOKE                = 59;
const int SQL_DIAG_SELECT_CURSOR         = 85;
const int SQL_DIAG_UNKNOWN_STATEMENT     =  0;
const int SQL_DIAG_UPDATE_WHERE          = 82;

// SQL data type codes
const int SQL_UNKNOWN_TYPE =  0;
const int SQL_CHAR         =  1;
const int SQL_NUMERIC      =  2;
const int SQL_DECIMAL      =  3;
const int SQL_INTEGER      =  4;
const int SQL_SMALLINT     =  5;
const int SQL_FLOAT        =  6;
const int SQL_REAL         =  7;
const int SQL_DOUBLE       =  8;
const int SQL_DATETIME     =  9;
const int SQL_VARCHAR      = 12;

// One-parameter shortcuts for date/time data types
const int SQL_TYPE_DATE      = 91;
const int SQL_TYPE_TIME      = 92;
const int SQL_TYPE_TIMESTAMP = 93;

// Statement attribute values for cursor sensitivity
const int SQL_UNSPECIFIED = 0;
const int SQL_INSENSITIVE = 1;
const int SQL_SENSITIVE   = 2;

// GetTypeInfo() request for all data types
const int SQL_ALL_TYPES = 0;

// Default conversion code for SQLBindCol(), SQLBindParam() and SQLGetData()
const int SQL_DEFAULT = 99;

// SQLSQLLEN GetData() code indicating that the application row descriptor
// specifies the data type
const int SQL_ARD_TYPE = -99;

const int SQL_APD_TYPE = -100;

// SQL date/time type subcodes
const int SQL_CODE_DATE      = 1;
const int SQL_CODE_TIME      = 2;
const int SQL_CODE_TIMESTAMP = 3;

// CLI option values
const int SQL_FALSE = 0;
const int SQL_TRUE  = 1;

// Values of NULLABLE field in descriptor
const int SQL_NO_NULLS = 0;
const int SQL_NULLABLE = 1;

// Value returned by SQLGetTypeInfo() to denote that it is
// not known whether or not a data type supports null values.
const int SQL_NULLABLE_UNKNOWN = 2;

// Values returned by SQLGetTypeInfo() to show WHERE clause supported
const int SQL_PRED_NONE  = 0;
const int SQL_PRED_CHAR  = 1;
const int SQL_PRED_BASIC = 2;

// Values of UNNAMED field in descriptor
const int SQL_NAMED   = 0;
const int SQL_UNNAMED = 1;

// Values of ALLOC_TYPE field in descriptor
const int SQL_DESC_ALLOC_AUTO = 1;
const int SQL_DESC_ALLOC_USER = 2;

// FreeStmt() options
const int SQL_CLOSE        = 0;
const int SQL_DROP         = 1;
const int SQL_UNBIND       = 2;
const int SQL_RESET_PARAMS = 3;

// Codes used for FetchOrientation in SQLFetchScroll() and in SQLDataSources()
const int SQL_FETCH_NEXT  = 1;
const int SQL_FETCH_FIRST = 2;

// Other codes used for FetchOrientation in SQLFetchScroll()
const int SQL_FETCH_LAST     = 3;
const int SQL_FETCH_PRIOR    = 4;
const int SQL_FETCH_ABSOLUTE = 5;
const int SQL_FETCH_RELATIVE = 6;

// SQLEndTran() options
const int SQL_COMMIT   = 0;
const int SQL_ROLLBACK = 1;

// Null handles returned by SQLAllocHandle()
const int SQL_NULL_HENV  = 0;
const int SQL_NULL_HDBC  = 0;
const int SQL_NULL_HSTMT = 0;
const int SQL_NULL_HDESC = 0;

// Null handle used in place of parent handle when allocating HENV
const int SQL_NULL_HANDLE = 0;

// Values that may appear in the result set of SQLSpecialColumns()
const int SQL_SCOPE_CURROW      = 0;
const int SQL_SCOPE_TRANSACTION = 1;
const int SQL_SCOPE_SESSION     = 2;

const int SQL_PC_UNKNOWN    = 0;
const int SQL_PC_NON_PSEUDO = 1;
const int SQL_PC_PSEUDO     = 2;

// Reserved value for the IdentifierType argument of SQLSpecialColumns()
const int SQL_ROW_IDENTIFIER = 1;

// Reserved values for UNIQUE argument of SQLStatistics()
const int SQL_INDEX_UNIQUE = 0;
const int SQL_INDEX_ALL    = 1;

// Values that may appear in the result set of SQLStatistics()
const int SQL_INDEX_CLUSTERED = 1;
const int SQL_INDEX_HASHED    = 2;
const int SQL_INDEX_OTHER     = 3;

// SQLGetFunctions() values to identify ODBC APIs
const int SQL_API_SQLALLOCCONNECT     =    1;
const int SQL_API_SQLALLOCENV         =    2;
const int SQL_API_SQLALLOCHANDLE      = 1001;
const int SQL_API_SQLALLOCSTMT        =    3;
const int SQL_API_SQLBINDCOL          =    4;
const int SQL_API_SQLBINDPARAM        = 1002;
const int SQL_API_SQLCANCEL           =    5;
const int SQL_API_SQLCLOSECURSOR      = 1003;
const int SQL_API_SQLCOLATTRIBUTE     =    6;
const int SQL_API_SQLCOLUMNS          =   40;
const int SQL_API_SQLCONNECT          =    7;
const int SQL_API_SQLCOPYDESC         = 1004;
const int SQL_API_SQLDATASOURCES      =   57;
const int SQL_API_SQLDESCRIBECOL      =    8;
const int SQL_API_SQLDISCONNECT       =    9;
const int SQL_API_SQLENDTRAN          = 1005;
const int SQL_API_SQLERROR            =   10;
const int SQL_API_SQLEXECDIRECT       =   11;
const int SQL_API_SQLEXECUTE          =   12;
const int SQL_API_SQLFETCH            =   13;
const int SQL_API_SQLFETCHSCROLL      = 1021;
const int SQL_API_SQLFREECONNECT      =   14;
const int SQL_API_SQLFREEENV          =   15;
const int SQL_API_SQLFREEHANDLE       = 1006;
const int SQL_API_SQLFREESTMT         =   16;
const int SQL_API_SQLGETCONNECTATTR   = 1007;
const int SQL_API_SQLGETCONNECTOPTION =   42;
const int SQL_API_SQLGETCURSORNAME    =   17;
const int SQL_API_SQLGETDATA          =   43;
const int SQL_API_SQLGETDESCFIELD     = 1008;
const int SQL_API_SQLGETDESCREC       = 1009;
const int SQL_API_SQLGETDIAGFIELD     = 1010;
const int SQL_API_SQLGETDIAGREC       = 1011;
const int SQL_API_SQLGETENVATTR       = 1012;
const int SQL_API_SQLGETFUNCTIONS     =   44;
const int SQL_API_SQLGETINFO          =   45;
const int SQL_API_SQLGETSTMTATTR      = 1014;
const int SQL_API_SQLGETSTMTOPTION    =   46;
const int SQL_API_SQLGETTYPEINFO      =   47;
const int SQL_API_SQLNUMRESULTCOLS    =   18;
const int SQL_API_SQLPARAMDATA        =   48;
const int SQL_API_SQLPREPARE          =   19;
const int SQL_API_SQLPUTDATA          =   49;
const int SQL_API_SQLROWCOUNT         =   20;
const int SQL_API_SQLSETCONNECTATTR   = 1016;
const int SQL_API_SQLSETCONNECTOPTION =   50;
const int SQL_API_SQLSETCURSORNAME    =   21;
const int SQL_API_SQLSETDESCFIELD     = 1017;
const int SQL_API_SQLSETDESCREC       = 1018;
const int SQL_API_SQLSETENVATTR       = 1019;
const int SQL_API_SQLSETPARAM         =   22;
const int SQL_API_SQLSETSTMTATTR      = 1020;
const int SQL_API_SQLSETSTMTOPTION    =   51;
const int SQL_API_SQLSPECIALCOLUMNS   =   52;
const int SQL_API_SQLSTATISTICS       =   53;
const int SQL_API_SQLTABLES           =   54;
const int SQL_API_SQLTRANSACT         =   23;

const int SQL_API_SQLCANCELHANDLE     = 1022;

// Information requested by SQLGetInfo()
const int SQL_MAX_DRIVER_CONNECTIONS        =   0;
const int SQL_MAXIMUM_DRIVER_CONNECTIONS    = SQL_MAX_DRIVER_CONNECTIONS;
const int SQL_MAX_CONCURRENT_ACTIVITIES     =   1;
const int SQL_MAXIMUM_CONCURRENT_ACTIVITIES = SQL_MAX_CONCURRENT_ACTIVITIES;
const int SQL_DATA_SOURCE_NAME              =   2;
const int SQL_FETCH_DIRECTION               =   8;
const int SQL_SERVER_NAME                   =  13;
const int SQL_SEARCH_PATTERN_ESCAPE         =  14;
const int SQL_DBMS_NAME                     =  17;
const int SQL_DBMS_VER                      =  18;
const int SQL_ACCESSIBLE_TABLES             =  19;
const int SQL_ACCESSIBLE_PROCEDURES         =  20;
const int SQL_CURSOR_COMMIT_BEHAVIOR        =  23;
const int SQL_DATA_SOURCE_READ_ONLY         =  25;
const int SQL_DEFAULT_TXN_ISOLATION         =  26;
const int SQL_IDENTIFIER_CASE               =  28;
const int SQL_IDENTIFIER_QUOTE_CHAR         =  29;
const int SQL_MAX_COLUMN_NAME_LEN           =  30;
const int SQL_MAXIMUM_COLUMN_NAME_LENGTH    = SQL_MAX_COLUMN_NAME_LEN;
const int SQL_MAX_CURSOR_NAME_LEN           =  31;
const int SQL_MAXIMUM_CURSOR_NAME_LENGTH    = SQL_MAX_CURSOR_NAME_LEN;
const int SQL_MAX_SCHEMA_NAME_LEN           =  32;
const int SQL_MAXIMUM_SCHEMA_NAME_LENGTH    = SQL_MAX_SCHEMA_NAME_LEN;
const int SQL_MAX_CATALOG_NAME_LEN          =  34;
const int SQL_MAXIMUM_CATALOG_NAME_LENGTH   = SQL_MAX_CATALOG_NAME_LEN;
const int SQL_MAX_TABLE_NAME_LEN            =  35;
const int SQL_SCROLL_CONCURRENCY            =  43;
const int SQL_TXN_CAPABLE                   =  46;
const int SQL_TRANSACTION_CAPABLE           = SQL_TXN_CAPABLE;
const int SQL_USER_NAME                     =  47;
const int SQL_TXN_ISOLATION_OPTION          =  72;
const int SQL_TRANSACTION_ISOLATION_OPTION  = SQL_TXN_ISOLATION_OPTION;
const int SQL_INTEGRITY                     =  73;
const int SQL_GETDATA_EXTENSIONS            =  81;
const int SQL_NULL_COLLATION                =  85;
const int SQL_ALTER_TABLE                   =  86;
const int SQL_ORDER_BY_COLUMNS_IN_SELECT    =  90;
const int SQL_SPECIAL_CHARACTERS            =  94;
const int SQL_MAX_COLUMNS_IN_GROUP_BY       =  97;
const int SQL_MAXIMUM_COLUMNS_IN_GROUP_BY   = SQL_MAX_COLUMNS_IN_GROUP_BY;
const int SQL_MAX_COLUMNS_IN_INDEX          =  98;
const int SQL_MAXIMUM_COLUMNS_IN_INDEX      = SQL_MAX_COLUMNS_IN_INDEX;
const int SQL_MAX_COLUMNS_IN_ORDER_BY       =  99;
const int SQL_MAXIMUM_COLUMNS_IN_ORDER_BY   = SQL_MAX_COLUMNS_IN_ORDER_BY;
const int SQL_MAX_COLUMNS_IN_SELECT         = 100;
const int SQL_MAXIMUM_COLUMNS_IN_SELECT     = SQL_MAX_COLUMNS_IN_SELECT;
const int SQL_MAX_COLUMNS_IN_TABLE          = 101;
const int SQL_MAX_INDEX_SIZE                = 102;
const int SQL_MAXIMUM_INDEX_SIZE            = SQL_MAX_INDEX_SIZE;
const int SQL_MAX_ROW_SIZE                  = 104;
const int SQL_MAXIMUM_ROW_SIZE              = SQL_MAX_ROW_SIZE;
const int SQL_MAX_STATEMENT_LEN             = 105;
const int SQL_MAXIMUM_STATEMENT_LENGTH      = SQL_MAX_STATEMENT_LEN;
const int SQL_MAX_TABLES_IN_SELECT          = 106;
const int SQL_MAXIMUM_TABLES_IN_SELECT      = SQL_MAX_TABLES_IN_SELECT;
const int SQL_MAX_USER_NAME_LEN             = 107;
const int SQL_MAXIMUM_USER_NAME_LENGTH      = SQL_MAX_USER_NAME_LEN;

int get SQL_OJ_CAPABILITIES         => ODBC_VERSION >= 0x0300 ? 115 : 65003;
int get SQL_OUTER_JOIN_CAPABILITIES => ODBC_VERSION >= 0x0300 ? SQL_OJ_CAPABILITIES : null;

const int SQL_XOPEN_CLI_YEAR            = 10000;
const int SQL_CURSOR_SENSITIVITY        = 10001;
const int SQL_DESCRIBE_PARAMETER        = 10002;
const int SQL_CATALOG_NAME              = 10003;
const int SQL_COLLATION_SEQ             = 10004;
const int SQL_MAX_IDENTIFIER_LEN        = 10005;
const int SQL_MAXIMUM_IDENTIFIER_LENGTH = SQL_MAX_IDENTIFIER_LEN;

// SQL_ALTER_TABLE bitmasks
const int SQL_AT_ADD_COLUMN  = 0x00000001;
const int SQL_AT_DROP_COLUMN = 0x00000002;

const int SQL_AT_ADD_CONSTRAINT = 0x00000008;

// SQL_ASYNC_MODE values
const int SQL_AM_NONE       = 0;
const int SQL_AM_CONNECTION = 1;
const int SQL_AM_STATEMENT  = 2;

// SQL_CURSOR_COMMIT_BEHAVIOR values
const int SQL_CB_DELETE   = 0;
const int SQL_CB_CLOSE    = 1;
const int SQL_CB_PRESERVE = 2;

// SQL_FETCH_DIRECTION bitmasks
const int SQL_FD_FETCH_NEXT     = 0x00000001;
const int SQL_FD_FETCH_FIRST    = 0x00000002;
const int SQL_FD_FETCH_LAST     = 0x00000004;
const int SQL_FD_FETCH_PRIOR    = 0x00000008;
const int SQL_FD_FETCH_ABSOLUTE = 0x00000010;
const int SQL_FD_FETCH_RELATIVE = 0x00000020;

// SQL_GETDATA_EXTENSIONS bitmasks
const int SQL_GD_ANY_COLUMN = 0x00000001;
const int SQL_GD_ANY_ORDER  = 0x00000002;

// SQL_IDENTIFIER_CASE values
const int SQL_IC_UPPER     = 1;
const int SQL_IC_LOWER     = 2;
const int SQL_IC_SENSITIVE = 3;
const int SQL_IC_MIXED     = 4;

// SQL_OJ_CAPABILITIES bitmasks
const int SQL_OJ_LEFT               = 0x00000001;
const int SQL_OJ_RIGHT              = 0x00000002;
const int SQL_OJ_FULL               = 0x00000004;
const int SQL_OJ_NESTED             = 0x00000008;
const int SQL_OJ_NOT_ORDERED        = 0x00000010;
const int SQL_OJ_INNER              = 0x00000020;
const int SQL_OJ_ALL_COMPARISON_OPS = 0x00000040;

// SQL_SCROLL_CONCURRENCY bitmasks
const int SQL_SCCO_READ_ONLY  = 0x00000001;
const int SQL_SCCO_LOCK       = 0x00000002;
const int SQL_SCCO_OPT_ROWVER = 0x00000004;
const int SQL_SCCO_OPT_VALUES = 0x00000008;

// SQL_TXN_CAPABLE values
const int SQL_TC_NONE       = 0;
const int SQL_TC_DML        = 1;
const int SQL_TC_ALL        = 2;
const int SQL_TC_DDL_COMMIT = 3;
const int SQL_TC_DDL_IGNORE = 4;

// SQL_TXN_ISOLATION_OPTION bitmasks
const int SQL_TXN_READ_UNCOMMITTED         = 0x00000001;
const int SQL_TRANSACTION_READ_UNCOMMITTED = SQL_TXN_READ_UNCOMMITTED;
const int SQL_TXN_READ_COMMITTED           = 0x00000002;
const int SQL_TRANSACTION_READ_COMMITTED   = SQL_TXN_READ_COMMITTED;
const int SQL_TXN_REPEATABLE_READ          = 0x00000004;
const int SQL_TRANSACTION_REPEATABLE_READ  = SQL_TXN_REPEATABLE_READ;
const int SQL_TXN_SERIALIZABLE             = 0x00000008;
const int SQL_TRANSACTION_SERIALIZABLE     = SQL_TXN_SERIALIZABLE;

// SQL_NULL_COLLATION values
const int SQL_NC_HIGH = 0;
const int SQL_NC_LOW  = 1;
