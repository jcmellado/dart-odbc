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

// Generally useful constants
const int SQL_SPEC_MAJOR     =  3;
const int SQL_SPEC_MINOR     = 80;
const String SQL_SPEC_STRING = "03.80";

const int SQL_SQLSTATE_SIZE = 5;

const int SQLSTATE = SQL_SQLSTATE_SIZE + 1;

const int SQL_MAX_DSN_LENGTH = 32;

const int SQL_MAX_OPTION_STRING_LENGTH = 256;

// Return code SQL_NO_DATA_FOUND is the same as SQL_NO_DATA
const int SQL_NO_DATA_FOUND = SQL_NO_DATA;

// An end handle type
const int SQL_HANDLE_SENV = 5;

// Env attribute
const int SQL_ATTR_ODBC_VERSION       = 200;
const int SQL_ATTR_CONNECTION_POOLING = 201;
const int SQL_ATTR_CP_MATCH           = 202;

// Values for SQL_ATTR_CONNECTION_POOLING
const int SQL_CP_OFF            = 0;
const int SQL_CP_ONE_PER_DRIVER = 1;
const int SQL_CP_ONE_PER_HENV   = 2;
const int SQL_CP_DEFAULT        = SQL_CP_OFF;

// Values for SQL_ATTR_CP_MATCH
const int SQL_CP_STRICT_MATCH  = 0;
const int SQL_CP_RELAXED_MATCH = 1;
const int SQL_CP_MATCH_DEFAULT = SQL_CP_STRICT_MATCH;

// Values for SQL_ATTR_ODBC_VERSION
const int SQL_OV_ODBC2 = 2;
const int SQL_OV_ODBC3 = 3;

const int SQL_OV_ODBC3_80 = 380;

// Connection attributes
const int SQL_ACCESS_MODE       = 101;
const int SQL_AUTOCOMMIT        = 102;
const int SQL_LOGIN_TIMEOUT     = 103;
const int SQL_OPT_TRACE         = 104;
const int SQL_OPT_TRACEFILE     = 105;
const int SQL_TRANSLATE_DLL     = 106;
const int SQL_TRANSLATE_OPTION  = 107;
const int SQL_TXN_ISOLATION     = 108;
const int SQL_CURRENT_QUALIFIER = 109;
const int SQL_ODBC_CURSORS      = 110;
const int SQL_QUIET_MODE        = 111;
const int SQL_PACKET_SIZE       = 112;

// Connection attributes with new names
const int SQL_ATTR_ACCESS_MODE         = SQL_ACCESS_MODE;
const int SQL_ATTR_AUTOCOMMIT          = SQL_AUTOCOMMIT;
const int SQL_ATTR_CONNECTION_TIMEOUT  =  113;
const int SQL_ATTR_CURRENT_CATALOG     = SQL_CURRENT_QUALIFIER;
const int SQL_ATTR_DISCONNECT_BEHAVIOR =  114;
const int SQL_ATTR_ENLIST_IN_DTC       = 1207;
const int SQL_ATTR_ENLIST_IN_XA        = 1208;
const int SQL_ATTR_LOGIN_TIMEOUT       = SQL_LOGIN_TIMEOUT;
const int SQL_ATTR_ODBC_CURSORS        = SQL_ODBC_CURSORS;
const int SQL_ATTR_PACKET_SIZE         = SQL_PACKET_SIZE;
const int SQL_ATTR_QUIET_MODE          = SQL_QUIET_MODE;
const int SQL_ATTR_TRACE               = SQL_OPT_TRACE;
const int SQL_ATTR_TRACEFILE           = SQL_OPT_TRACEFILE;
const int SQL_ATTR_TRANSLATE_LIB       = SQL_TRANSLATE_DLL;
const int SQL_ATTR_TRANSLATE_OPTION    = SQL_TRANSLATE_OPTION;
const int SQL_ATTR_TXN_ISOLATION       = SQL_TXN_ISOLATION;

const int SQL_ATTR_CONNECTION_DEAD = 1209;

const int SQL_ATTR_ANSI_APP = 115;

const int SQL_ATTR_RESET_CONNECTION           = 116;
const int SQL_ATTR_ASYNC_DBC_FUNCTIONS_ENABLE = 117;

const int SQL_CONNECT_OPT_DRVR_START  = 1000;

const int SQL_CONN_OPT_MAX = SQL_PACKET_SIZE;
const int SQL_CONN_OPT_MIN = SQL_ACCESS_MODE;

// SQL_ACCESS_MODE options
const int SQL_MODE_READ_WRITE = 0;
const int SQL_MODE_READ_ONLY  = 1;
const int SQL_MODE_DEFAULT    = SQL_MODE_READ_WRITE;

// SQL_AUTOCOMMIT options
const int SQL_AUTOCOMMIT_OFF     = 0;
const int SQL_AUTOCOMMIT_ON      = 1;
const int SQL_AUTOCOMMIT_DEFAULT = SQL_AUTOCOMMIT_ON;

// SQL_LOGIN_TIMEOUT options
const int SQL_LOGIN_TIMEOUT_DEFAULT = 15;

// SQL_OPT_TRACE options
const int SQL_OPT_TRACE_OFF             = 0;
const int SQL_OPT_TRACE_ON              = 1;
const int SQL_OPT_TRACE_DEFAULT         = SQL_OPT_TRACE_OFF;
const String SQL_OPT_TRACE_FILE_DEFAULT = "\\SQL.LOG";

// SQL_ODBC_CURSORS options
const int SQL_CUR_USE_IF_NEEDED = 0;
const int SQL_CUR_USE_ODBC      = 1;
const int SQL_CUR_USE_DRIVER    = 2;
const int SQL_CUR_DEFAULT       = SQL_CUR_USE_DRIVER;

// Values for SQL_ATTR_DISCONNECT_BEHAVIOR
const int SQL_DB_RETURN_TO_POOL = 0;
const int SQL_DB_DISCONNECT     = 1;
const int SQL_DB_DEFAULT        = SQL_DB_RETURN_TO_POOL;

// Values for SQL_ATTR_ENLIST_IN_DTC
const int SQL_DTC_DONE = 0;

// Values for SQL_ATTR_CONNECTION_DEAD
const int SQL_CD_TRUE  = 1;
const int SQL_CD_FALSE = 0 ;

// Values for SQL_ATTR_ANSI_APP
const int SQL_AA_TRUE  = 1;
const int SQL_AA_FALSE = 0;

// Values for SQL_ATTR_RESET_CONNECTION
const int SQL_RESET_CONNECTION_YES = 1;

// Values for SQL_ATTR_ASYNC_DBC_FUNCTIONS_ENABLE
const int SQL_ASYNC_DBC_ENABLE_ON      = 1;
const int SQL_ASYNC_DBC_ENABLE_OFF     = 0;
const int SQL_ASYNC_DBC_ENABLE_DEFAULT = SQL_ASYNC_DBC_ENABLE_OFF;

// Statement attributes
const int SQL_QUERY_TIMEOUT   =  0;
const int SQL_MAX_ROWS        =  1;
const int SQL_NOSCAN          =  2;
const int SQL_MAX_LENGTH      =  3;
const int SQL_ASYNC_ENABLE    =  4;
const int SQL_BIND_TYPE       =  5;
const int SQL_CURSOR_TYPE     =  6;
const int SQL_CONCURRENCY     =  7;
const int SQL_KEYSET_SIZE     =  8;
const int SQL_ROWSET_SIZE     =  9;
const int SQL_SIMULATE_CURSOR = 10;
const int SQL_RETRIEVE_DATA   = 11;
const int SQL_USE_BOOKMARKS   = 12;
const int SQL_GET_BOOKMARK    = 13;
const int SQL_ROW_NUMBER      = 14;

// Statement attributes for ODBC 3.0
const int SQL_ATTR_ASYNC_ENABLE          =  4;
const int SQL_ATTR_CONCURRENCY           = SQL_CONCURRENCY;
const int SQL_ATTR_CURSOR_TYPE           = SQL_CURSOR_TYPE;
const int SQL_ATTR_ENABLE_AUTO_IPD       = 15;
const int SQL_ATTR_FETCH_BOOKMARK_PTR    = 16;
const int SQL_ATTR_KEYSET_SIZE           = SQL_KEYSET_SIZE;
const int SQL_ATTR_MAX_LENGTH            = SQL_MAX_LENGTH;
const int SQL_ATTR_MAX_ROWS              = SQL_MAX_ROWS;
const int SQL_ATTR_NOSCAN                = SQL_NOSCAN;
const int SQL_ATTR_PARAM_BIND_OFFSET_PTR = 17;
const int SQL_ATTR_PARAM_BIND_TYPE       = 18;
const int SQL_ATTR_PARAM_OPERATION_PTR   = 19;
const int SQL_ATTR_PARAM_STATUS_PTR      = 20;
const int SQL_ATTR_PARAMS_PROCESSED_PTR  = 21;
const int SQL_ATTR_PARAMSET_SIZE         = 22;
const int SQL_ATTR_QUERY_TIMEOUT         = SQL_QUERY_TIMEOUT;
const int SQL_ATTR_RETRIEVE_DATA         = SQL_RETRIEVE_DATA;
const int SQL_ATTR_ROW_BIND_OFFSET_PTR   = 23;
const int SQL_ATTR_ROW_BIND_TYPE         = SQL_BIND_TYPE;
const int SQL_ATTR_ROW_NUMBER            = SQL_ROW_NUMBER;
const int SQL_ATTR_ROW_OPERATION_PTR     = 24;
const int SQL_ATTR_ROW_STATUS_PTR        = 25;
const int SQL_ATTR_ROWS_FETCHED_PTR      = 26;
const int SQL_ATTR_ROW_ARRAY_SIZE        = 27;
const int SQL_ATTR_SIMULATE_CURSOR       = SQL_SIMULATE_CURSOR;
const int SQL_ATTR_USE_BOOKMARKS         = SQL_USE_BOOKMARKS;

const int SQL_STMT_OPT_MAX = SQL_ROW_NUMBER;
const int SQL_STMT_OPT_MIN = SQL_QUERY_TIMEOUT;

// New defines for SEARCHABLE column in SQLGetTypeInfo
const int SQL_COL_PRED_CHAR  = SQL_LIKE_ONLY;
const int SQL_COL_PRED_BASIC = SQL_ALL_EXCEPT_LIKE;

// Whether an attribute is a pointer or not
const int SQL_IS_POINTER   = -4;
const int SQL_IS_UINTEGER  = -5;
const int SQL_IS_INTEGER   = -6;
const int SQL_IS_USMALLINT = -7;
const int SQL_IS_SMALLINT  = -8;

// The value of SQL_ATTR_PARAM_BIND_TYPE
const int SQL_PARAM_BIND_BY_COLUMN    = 0;
const int SQL_PARAM_BIND_TYPE_DEFAULT = SQL_PARAM_BIND_BY_COLUMN;

// SQL_QUERY_TIMEOUT options
const int SQL_QUERY_TIMEOUT_DEFAULT = 0;

// SQL_MAX_ROWS options
const int SQL_MAX_ROWS_DEFAULT = 0;

// SQL_NOSCAN options
const int SQL_NOSCAN_OFF     = 0;
const int SQL_NOSCAN_ON      = 1;
const int SQL_NOSCAN_DEFAULT = SQL_NOSCAN_OFF;

// SQL_MAX_LENGTH options
const int SQL_MAX_LENGTH_DEFAULT = 0;

// Values for SQL_ATTR_ASYNC_ENABLE
const int SQL_ASYNC_ENABLE_OFF     = 0;
const int SQL_ASYNC_ENABLE_ON      = 1;
const int SQL_ASYNC_ENABLE_DEFAULT = SQL_ASYNC_ENABLE_OFF;

// SQL_BIND_TYPE options
const int SQL_BIND_BY_COLUMN    = 0;
const int SQL_BIND_TYPE_DEFAULT = SQL_BIND_BY_COLUMN;

// SQL_CONCURRENCY options
const int SQL_CONCUR_READ_ONLY = 1;
const int SQL_CONCUR_LOCK      = 2;
const int SQL_CONCUR_ROWVER    = 3;
const int SQL_CONCUR_VALUES    = 4;
const int SQL_CONCUR_DEFAULT   = SQL_CONCUR_READ_ONLY;

// SQL_CURSOR_TYPE options
const int SQL_CURSOR_FORWARD_ONLY  = 0;
const int SQL_CURSOR_KEYSET_DRIVEN = 1;
const int SQL_CURSOR_DYNAMIC       = 2;
const int SQL_CURSOR_STATIC        = 3;
const int SQL_CURSOR_TYPE_DEFAULT  = SQL_CURSOR_FORWARD_ONLY;

// SQL_ROWSET_SIZE options
const int SQL_ROWSET_SIZE_DEFAULT = 1;

// SQL_KEYSET_SIZE options
const int SQL_KEYSET_SIZE_DEFAULT = 0;

// SQL_SIMULATE_CURSOR options
const int SQL_SC_NON_UNIQUE = 0;
const int SQL_SC_TRY_UNIQUE = 1;
const int SQL_SC_UNIQUE     = 2;

// SQL_RETRIEVE_DATA options
const int SQL_RD_OFF     = 0;
const int SQL_RD_ON      = 1;
const int SQL_RD_DEFAULT = SQL_RD_ON;

// SQL_USE_BOOKMARKS options
const int SQL_UB_OFF     = 0;
const int SQL_UB_ON      = 1;
const int SQL_UB_DEFAULT = SQL_UB_OFF;

// New values for SQL_USE_BOOKMARKS attribute
const int SQL_UB_FIXED    = SQL_UB_ON;
const int SQL_UB_VARIABLE = 2;

// Extended descriptor field
const int SQL_DESC_ARRAY_SIZE                  = 20;
const int SQL_DESC_ARRAY_STATUS_PTR            = 21;
const int SQL_DESC_AUTO_UNIQUE_VALUE           = SQL_COLUMN_AUTO_INCREMENT;
const int SQL_DESC_BASE_COLUMN_NAME            = 22;
const int SQL_DESC_BASE_TABLE_NAME             = 23;
const int SQL_DESC_BIND_OFFSET_PTR             = 24;
const int SQL_DESC_BIND_TYPE                   = 25;
const int SQL_DESC_CASE_SENSITIVE              = SQL_COLUMN_CASE_SENSITIVE;
const int SQL_DESC_CATALOG_NAME                = SQL_COLUMN_QUALIFIER_NAME;
const int SQL_DESC_CONCISE_TYPE                = SQL_COLUMN_TYPE;
const int SQL_DESC_DATETIME_INTERVAL_PRECISION = 26;
const int SQL_DESC_DISPLAY_SIZE                = SQL_COLUMN_DISPLAY_SIZE;
const int SQL_DESC_FIXED_PREC_SCALE            = SQL_COLUMN_MONEY;
const int SQL_DESC_LABEL                       = SQL_COLUMN_LABEL;
const int SQL_DESC_LITERAL_PREFIX              = 27;
const int SQL_DESC_LITERAL_SUFFIX              = 28;
const int SQL_DESC_LOCAL_TYPE_NAME             = 29;
const int SQL_DESC_MAXIMUM_SCALE               = 30;
const int SQL_DESC_MINIMUM_SCALE               = 31;
const int SQL_DESC_NUM_PREC_RADIX              = 32;
const int SQL_DESC_PARAMETER_TYPE              = 33;
const int SQL_DESC_ROWS_PROCESSED_PTR          = 34;
const int SQL_DESC_ROWVER                      = 35;
const int SQL_DESC_SCHEMA_NAME                 = SQL_COLUMN_OWNER_NAME;
const int SQL_DESC_SEARCHABLE                  = SQL_COLUMN_SEARCHABLE;
const int SQL_DESC_TYPE_NAME                   = SQL_COLUMN_TYPE_NAME;
const int SQL_DESC_TABLE_NAME                  = SQL_COLUMN_TABLE_NAME;
const int SQL_DESC_UNSIGNED                    = SQL_COLUMN_UNSIGNED;
const int SQL_DESC_UPDATABLE                   = SQL_COLUMN_UPDATABLE;

// Defines for diagnostics fields
const int SQL_DIAG_CURSOR_ROW_COUNT = -1249;
const int SQL_DIAG_ROW_NUMBER       = -1248;
const int SQL_DIAG_COLUMN_NUMBER    = -1247;

// SQL extended datatypes
const int SQL_DATE          =   9;
const int SQL_INTERVAL      =  10;
const int SQL_TIME          =  10;
const int SQL_TIMESTAMP     =  11;
const int SQL_LONGVARCHAR   =  -1;
const int SQL_BINARY        =  -2;
const int SQL_VARBINARY     =  -3;
const int SQL_LONGVARBINARY =  -4;
const int SQL_BIGINT        =  -5;
const int SQL_TINYINT       =  -6;
const int SQL_BIT           =  -7;
const int SQL_GUID          = -11;

// Interval code
const int SQL_CODE_YEAR             =  1;
const int SQL_CODE_MONTH            =  2;
const int SQL_CODE_DAY              =  3;
const int SQL_CODE_HOUR             =  4;
const int SQL_CODE_MINUTE           =  5;
const int SQL_CODE_SECOND           =  6;
const int SQL_CODE_YEAR_TO_MONTH    =  7;
const int SQL_CODE_DAY_TO_HOUR      =  8;
const int SQL_CODE_DAY_TO_MINUTE    =  9;
const int SQL_CODE_DAY_TO_SECOND    = 10;
const int SQL_CODE_HOUR_TO_MINUTE   = 11;
const int SQL_CODE_HOUR_TO_SECOND   = 12;
const int SQL_CODE_MINUTE_TO_SECOND = 13;

int get SQL_INTERVAL_YEAR
    => ODBC_VERSION < 0x0300 ? -80 : 100 + SQL_CODE_YEAR;
int get SQL_INTERVAL_MONTH
    => ODBC_VERSION < 0x0300 ? -81 : 100 + SQL_CODE_MONTH;
int get SQL_INTERVAL_DAY
    => ODBC_VERSION < 0x0300 ? -82 : 100 + SQL_CODE_DAY;
int get SQL_INTERVAL_HOUR
    => ODBC_VERSION < 0x0300 ? -83 : 100 + SQL_CODE_HOUR;
int get SQL_INTERVAL_MINUTE
    => ODBC_VERSION < 0x0300 ? -84 : 100 + SQL_CODE_MINUTE;
int get SQL_INTERVAL_SECOND
    => ODBC_VERSION < 0x0300 ? -85 : 100 + SQL_CODE_SECOND;
int get SQL_INTERVAL_YEAR_TO_MONTH
    => ODBC_VERSION < 0x0300 ? -86 : 100 + SQL_CODE_YEAR_TO_MONTH;
int get SQL_INTERVAL_DAY_TO_HOUR
    => ODBC_VERSION < 0x0300 ? -87 : 100 + SQL_CODE_DAY_TO_HOUR;
int get SQL_INTERVAL_DAY_TO_MINUTE
    => ODBC_VERSION < 0x0300 ? -88 : 100 + SQL_CODE_DAY_TO_MINUTE;
int get SQL_INTERVAL_DAY_TO_SECOND
    => ODBC_VERSION < 0x0300 ? -89 : 100 + SQL_CODE_DAY_TO_SECOND;
int get SQL_INTERVAL_HOUR_TO_MINUTE
    => ODBC_VERSION < 0x0300 ? -90 : 100 + SQL_CODE_HOUR_TO_MINUTE;
int get SQL_INTERVAL_HOUR_TO_SECOND
    => ODBC_VERSION < 0x0300 ? -91 : 100 + SQL_CODE_HOUR_TO_SECOND;
int get SQL_INTERVAL_MINUTE_TO_SECOND
    => ODBC_VERSION < 0x0300 ? -92 : 100 + SQL_CODE_MINUTE_TO_SECOND;

int get SQL_UNICODE
    => ODBC_VERSION <= 0x0300 ? -95 : SQL_WCHAR;
int get SQL_UNICODE_VARCHAR
    => ODBC_VERSION <= 0x0300 ? -96 : SQL_WVARCHAR;
int get SQL_UNICODE_LONGVARCHAR
    => ODBC_VERSION <= 0x0300 ? -97 : SQL_WLONGVARCHAR;
int get SQL_UNICODE_CHAR
    => ODBC_VERSION <= 0x0300 ? SQL_UNICODE : SQL_WCHAR;

int get SQL_TYPE_DRIVER_START => SQL_INTERVAL_YEAR;
int get SQL_TYPE_DRIVER_END   => SQL_UNICODE_LONGVARCHAR;

// Datatype to SQL datatype mapping
const int SQL_C_CHAR    = SQL_CHAR;
const int SQL_C_LONG    = SQL_INTEGER;
const int SQL_C_SHORT   = SQL_SMALLINT;
const int SQL_C_FLOAT   = SQL_REAL;
const int SQL_C_DOUBLE  = SQL_DOUBLE;
const int SQL_C_NUMERIC = SQL_NUMERIC;
const int SQL_C_DEFAULT = 99;

const int SQL_SIGNED_OFFSET   = -20;
const int SQL_UNSIGNED_OFFSET = -22;

// C datatype to SQL datatype mapping
const int SQL_C_DATE                    = SQL_DATE;
const int SQL_C_TIME                    = SQL_TIME;
const int SQL_C_TIMESTAMP               = SQL_TIMESTAMP;
const int SQL_C_TYPE_DATE               = SQL_TYPE_DATE;
const int SQL_C_TYPE_TIME               = SQL_TYPE_TIME;
const int SQL_C_TYPE_TIMESTAMP          = SQL_TYPE_TIMESTAMP;
int get SQL_C_INTERVAL_YEAR             => SQL_INTERVAL_YEAR;
int get SQL_C_INTERVAL_MONTH            => SQL_INTERVAL_MONTH;
int get SQL_C_INTERVAL_DAY              => SQL_INTERVAL_DAY;
int get SQL_C_INTERVAL_HOUR             => SQL_INTERVAL_HOUR;
int get SQL_C_INTERVAL_MINUTE           => SQL_INTERVAL_MINUTE;
int get SQL_C_INTERVAL_SECOND           => SQL_INTERVAL_SECOND;
int get SQL_C_INTERVAL_YEAR_TO_MONTH    => SQL_INTERVAL_YEAR_TO_MONTH;
int get SQL_C_INTERVAL_DAY_TO_HOUR      => SQL_INTERVAL_DAY_TO_HOUR;
int get SQL_C_INTERVAL_DAY_TO_MINUTE    => SQL_INTERVAL_DAY_TO_MINUTE;
int get SQL_C_INTERVAL_DAY_TO_SECOND    => SQL_INTERVAL_DAY_TO_SECOND;
int get SQL_C_INTERVAL_HOUR_TO_MINUTE   => SQL_INTERVAL_HOUR_TO_MINUTE;
int get SQL_C_INTERVAL_HOUR_TO_SECOND   => SQL_INTERVAL_HOUR_TO_SECOND;
int get SQL_C_INTERVAL_MINUTE_TO_SECOND => SQL_INTERVAL_MINUTE_TO_SECOND;
const int SQL_C_BINARY                  = SQL_BINARY;
const int SQL_C_BIT                     = SQL_BIT;
const int SQL_C_SBIGINT                 = SQL_BIGINT + SQL_SIGNED_OFFSET;
const int SQL_C_UBIGINT                 = SQL_BIGINT + SQL_UNSIGNED_OFFSET;
const int SQL_C_TINYINT                 = SQL_TINYINT;
const int SQL_C_SLONG                   = SQL_C_LONG + SQL_SIGNED_OFFSET;
const int SQL_C_SSHORT                  = SQL_C_SHORT + SQL_SIGNED_OFFSET;
const int SQL_C_STINYINT                = SQL_TINYINT + SQL_SIGNED_OFFSET;
const int SQL_C_ULONG                   = SQL_C_LONG + SQL_UNSIGNED_OFFSET;
const int SQL_C_USHORT                  = SQL_C_SHORT + SQL_UNSIGNED_OFFSET;
const int SQL_C_UTINYINT                = SQL_TINYINT + SQL_UNSIGNED_OFFSET;

int get SQL_C_BOOKMARK => ODBC_64BITS ? SQL_C_UBIGINT : SQL_C_ULONG;

const int SQL_C_GUID = SQL_GUID;

const int SQL_TYPE_NULL = 0;
const int SQL_TYPE_MIN  = SQL_BIT;
const int SQL_TYPE_MAX  = SQL_VARCHAR;

// Base value of driver-specific C-Type (max is 0x7fff)
const int SQL_DRIVER_C_TYPE_BASE = 0x4000;

// Base value of driver-specific fields/attributes
// (max are 0x7fff [16-bit] or 0x00007fff [32-bit])
const int SQL_DRIVER_SQL_TYPE_BASE   = 0x4000;
const int SQL_DRIVER_DESC_FIELD_BASE = 0x4000;
const int SQL_DRIVER_DIAG_FIELD_BASE = 0x4000;
const int SQL_DRIVER_INFO_TYPE_BASE  = 0x4000;
const int SQL_DRIVER_CONN_ATTR_BASE  = 0x00004000;
const int SQL_DRIVER_STMT_ATTR_BASE  = 0x00004000;

const int SQL_C_VARBOOKMARK = SQL_C_BINARY;

// Define for SQL_DIAG_ROW_NUMBER and SQL_DIAG_COLUMN_NUMBER
const int SQL_NO_ROW_NUMBER         = -1;
const int SQL_NO_COLUMN_NUMBER      = -1;
const int SQL_ROW_NUMBER_UNKNOWN    = -2;
const int SQL_COLUMN_NUMBER_UNKNOWN = -2;

// SQLBindParameter extensions
const int SQL_DEFAULT_PARAM            = -5;
const int SQL_IGNORE                   = -6;
const int SQL_COLUMN_IGNORE            = SQL_IGNORE;
const int SQL_LEN_DATA_AT_EXEC_OFFSET  = -100;

int sqlLenDataAtExec(int length) => SQL_LEN_DATA_AT_EXEC_OFFSET - length;

// Binary length for driver specific attributes
const int SQL_LEN_BINARY_ATTR_OFFSET = -100;

int sqlLenBinaryAttr(int length) => SQL_LEN_BINARY_ATTR_OFFSET - length;

// Defines used by Driver Manager when mapping SQLSetParam to SQLBindParameter
const int SQL_PARAM_TYPE_DEFAULT = SQL_PARAM_INPUT_OUTPUT;
const int SQL_SETPARAM_VALUE_MAX = -1;

// SQLColAttributes defines
const int SQL_COLUMN_COUNT          =  0;
const int SQL_COLUMN_NAME           =  1;
const int SQL_COLUMN_TYPE           =  2;
const int SQL_COLUMN_LENGTH         =  3;
const int SQL_COLUMN_PRECISION      =  4;
const int SQL_COLUMN_SCALE          =  5;
const int SQL_COLUMN_DISPLAY_SIZE   =  6;
const int SQL_COLUMN_NULLABLE       =  7;
const int SQL_COLUMN_UNSIGNED       =  8;
const int SQL_COLUMN_MONEY          =  9;
const int SQL_COLUMN_UPDATABLE      = 10;
const int SQL_COLUMN_AUTO_INCREMENT = 11;
const int SQL_COLUMN_CASE_SENSITIVE = 12;
const int SQL_COLUMN_SEARCHABLE     = 13;
const int SQL_COLUMN_TYPE_NAME      = 14;
const int SQL_COLUMN_TABLE_NAME     = 15;
const int SQL_COLUMN_OWNER_NAME     = 16;
const int SQL_COLUMN_QUALIFIER_NAME = 17;
const int SQL_COLUMN_LABEL          = 18;
const int SQL_COLATT_OPT_MAX        = SQL_COLUMN_LABEL;
const int SQL_COLUMN_DRIVER_START   = 1000;

const int SQL_COLATT_OPT_MIN        = SQL_COLUMN_COUNT;

// SQLColAttributes subdefines for SQL_COLUMN_UPDATABLE
const int SQL_ATTR_READONLY          = 0;
const int SQL_ATTR_WRITE             = 1;
const int SQL_ATTR_READWRITE_UNKNOWN = 2;

// SQLColAttributes subdefines for SQL_COLUMN_SEARCHABLE and SQLGetInfo
const int SQL_UNSEARCHABLE    = 0;
const int SQL_LIKE_ONLY       = 1;
const int SQL_ALL_EXCEPT_LIKE = 2;
const int SQL_SEARCHABLE      = 3;
const int SQL_PRED_SEARCHABLE = SQL_SEARCHABLE;

// Special return values for SQLGetData
const int SQL_NO_TOTAL = -4;

// SQLGetFunctions: additional values for fFunction
// to represent functions that are not in the X/Open spec
const int SQL_API_SQLALLOCHANDLESTD   = 73;
const int SQL_API_SQLBULKOPERATIONS   = 24;
const int SQL_API_SQLBINDPARAMETER    = 72;
const int SQL_API_SQLBROWSECONNECT    = 55;
const int SQL_API_SQLCOLATTRIBUTES    =  6;
const int SQL_API_SQLCOLUMNPRIVILEGES = 56;
const int SQL_API_SQLDESCRIBEPARAM    = 58;
const int SQL_API_SQLDRIVERCONNECT    = 41;
const int SQL_API_SQLDRIVERS          = 71;
const int SQL_API_SQLEXTENDEDFETCH    = 59;
const int SQL_API_SQLFOREIGNKEYS      = 60;
const int SQL_API_SQLMORERESULTS      = 61;
const int SQL_API_SQLNATIVESQL        = 62;
const int SQL_API_SQLNUMPARAMS        = 63;
const int SQL_API_SQLPARAMOPTIONS     = 64;
const int SQL_API_SQLPRIMARYKEYS      = 65;
const int SQL_API_SQLPROCEDURECOLUMNS = 66;
const int SQL_API_SQLPROCEDURES       = 67;
const int SQL_API_SQLSETPOS           = 68;
const int SQL_API_SQLSETSCROLLOPTIONS = 69;
const int SQL_API_SQLTABLEPRIVILEGES  = 70;

const int SQL_EXT_API_LAST   = SQL_API_SQLBINDPARAMETER;
const int SQL_NUM_FUNCTIONS  = 23;
const int SQL_EXT_API_START  = 40;
const int SQL_NUM_EXTENSIONS = SQL_EXT_API_LAST - SQL_EXT_API_START + 1;

const int SQL_API_ALL_FUNCTIONS = 0;

const int SQL_API_LOADBYORDINAL = 199;

const int SQL_API_ODBC3_ALL_FUNCTIONS      = 999;
const int SQL_API_ODBC3_ALL_FUNCTIONS_SIZE = 250;

bool sqlFunctionExists(SqlBuffer functions, int function) =>
    (functions.peek(function >> 4) & (1 << (function & 0x000f))) != 0;

// Extended definitions for SQLGetInfo
const int SQL_INFO_FIRST                 =   0;
const int SQL_ACTIVE_CONNECTIONS         =   0;
const int SQL_ACTIVE_STATEMENTS          =   1;
const int SQL_DRIVER_HDBC                =   3;
const int SQL_DRIVER_HENV                =   4;
const int SQL_DRIVER_HSTMT               =   5;
const int SQL_DRIVER_NAME                =   6;
const int SQL_DRIVER_VER                 =   7;
const int SQL_ODBC_API_CONFORMANCE       =   9;
const int SQL_ODBC_VER                   =  10;
const int SQL_ROW_UPDATES                =  11;
const int SQL_ODBC_SAG_CLI_CONFORMANCE   =  12;
const int SQL_ODBC_SQL_CONFORMANCE       =  15;
const int SQL_PROCEDURES                 =  21;
const int SQL_CONCAT_NULL_BEHAVIOR       =  22;
const int SQL_CURSOR_ROLLBACK_BEHAVIOR   =  24;
const int SQL_EXPRESSIONS_IN_ORDERBY     =  27;
const int SQL_MAX_OWNER_NAME_LEN         =  32;
const int SQL_MAX_PROCEDURE_NAME_LEN     =  33;
const int SQL_MAX_QUALIFIER_NAME_LEN     =  34;
const int SQL_MULT_RESULT_SETS           =  36;
const int SQL_MULTIPLE_ACTIVE_TXN        =  37;
const int SQL_OUTER_JOINS                =  38;
const int SQL_OWNER_TERM                 =  39;
const int SQL_PROCEDURE_TERM             =  40;
const int SQL_QUALIFIER_NAME_SEPARATOR   =  41;
const int SQL_QUALIFIER_TERM             =  42;
const int SQL_SCROLL_OPTIONS             =  44;
const int SQL_TABLE_TERM                 =  45;
const int SQL_CONVERT_FUNCTIONS          =  48;
const int SQL_NUMERIC_FUNCTIONS          =  49;
const int SQL_STRING_FUNCTIONS           =  50;
const int SQL_SYSTEM_FUNCTIONS           =  51;
const int SQL_TIMEDATE_FUNCTIONS         =  52;
const int SQL_CONVERT_BIGINT             =  53;
const int SQL_CONVERT_BINARY             =  54;
const int SQL_CONVERT_BIT                =  55;
const int SQL_CONVERT_CHAR               =  56;
const int SQL_CONVERT_DATE               =  57;
const int SQL_CONVERT_DECIMAL            =  58;
const int SQL_CONVERT_DOUBLE             =  59;
const int SQL_CONVERT_FLOAT              =  60;
const int SQL_CONVERT_INTEGER            =  61;
const int SQL_CONVERT_LONGVARCHAR        =  62;
const int SQL_CONVERT_NUMERIC            =  63;
const int SQL_CONVERT_REAL               =  64;
const int SQL_CONVERT_SMALLINT           =  65;
const int SQL_CONVERT_TIME               =  66;
const int SQL_CONVERT_TIMESTAMP          =  67;
const int SQL_CONVERT_TINYINT            =  68;
const int SQL_CONVERT_VARBINARY          =  69;
const int SQL_CONVERT_VARCHAR            =  70;
const int SQL_CONVERT_LONGVARBINARY      =  71;
const int SQL_ODBC_SQL_OPT_IEF           =  73;
const int SQL_CORRELATION_NAME           =  74;
const int SQL_NON_NULLABLE_COLUMNS       =  75;
const int SQL_DRIVER_HLIB                =  76;
const int SQL_DRIVER_ODBC_VER            =  77;
const int SQL_LOCK_TYPES                 =  78;
const int SQL_POS_OPERATIONS             =  79;
const int SQL_POSITIONED_STATEMENTS      =  80;
const int SQL_BOOKMARK_PERSISTENCE       =  82;
const int SQL_STATIC_SENSITIVITY         =  83;
const int SQL_FILE_USAGE                 =  84;
const int SQL_COLUMN_ALIAS               =  87;
const int SQL_GROUP_BY                   =  88;
const int SQL_KEYWORDS                   =  89;
const int SQL_OWNER_USAGE                =  91;
const int SQL_QUALIFIER_USAGE            =  92;
const int SQL_QUOTED_IDENTIFIER_CASE     =  93;
const int SQL_SUBQUERIES                 =  95;
const int SQL_UNION                      =  96;
const int SQL_MAX_ROW_SIZE_INCLUDES_LONG = 103;
const int SQL_MAX_CHAR_LITERAL_LEN       = 108;
const int SQL_TIMEDATE_ADD_INTERVALS     = 109;
const int SQL_TIMEDATE_DIFF_INTERVALS    = 110;
const int SQL_NEED_LONG_DATA_LEN         = 111;
const int SQL_MAX_BINARY_LITERAL_LEN     = 112;
const int SQL_LIKE_ESCAPE_CLAUSE         = 113;
const int SQL_QUALIFIER_LOCATION         = 114;

const int SQL_INFO_LAST         = SQL_QUALIFIER_LOCATION;
const int SQL_INFO_DRIVER_START = 1000;

// ODBC 3.0 SQLGetInfo values that are not part of the X/Open standard
const int SQL_ACTIVE_ENVIRONMENTS             =   116;
const int SQL_ALTER_DOMAIN                    =   117;

const int SQL_SQL_CONFORMANCE                 =   118;
const int SQL_DATETIME_LITERALS               =   119;

const int SQL_ASYNC_MODE                      = 10021;
const int SQL_BATCH_ROW_COUNT                 =   120;
const int SQL_BATCH_SUPPORT                   =   121;
const int SQL_CATALOG_LOCATION                = SQL_QUALIFIER_LOCATION;
const int SQL_CATALOG_NAME_SEPARATOR          = SQL_QUALIFIER_NAME_SEPARATOR;
const int SQL_CATALOG_TERM                    = SQL_QUALIFIER_TERM;
const int SQL_CATALOG_USAGE                   = SQL_QUALIFIER_USAGE;
const int SQL_CONVERT_WCHAR                   =   122;
const int SQL_CONVERT_INTERVAL_DAY_TIME       =   123;
const int SQL_CONVERT_INTERVAL_YEAR_MONTH     =   124;
const int SQL_CONVERT_WLONGVARCHAR            =   125;
const int SQL_CONVERT_WVARCHAR                =   126;
const int SQL_CREATE_ASSERTION                =   127;
const int SQL_CREATE_CHARACTER_SET            =   128;
const int SQL_CREATE_COLLATION                =   129;
const int SQL_CREATE_DOMAIN                   =   130;
const int SQL_CREATE_SCHEMA                   =   131;
const int SQL_CREATE_TABLE                    =   132;
const int SQL_CREATE_TRANSLATION              =   133;
const int SQL_CREATE_VIEW                     =   134;
const int SQL_DRIVER_HDESC                    =   135;
const int SQL_DROP_ASSERTION                  =   136;
const int SQL_DROP_CHARACTER_SET              =   137;
const int SQL_DROP_COLLATION                  =   138;
const int SQL_DROP_DOMAIN                     =   139;
const int SQL_DROP_SCHEMA                     =   140;
const int SQL_DROP_TABLE                      =   141;
const int SQL_DROP_TRANSLATION                =   142;
const int SQL_DROP_VIEW                       =   143;
const int SQL_DYNAMIC_CURSOR_ATTRIBUTES1      =   144;
const int SQL_DYNAMIC_CURSOR_ATTRIBUTES2      =   145;
const int SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1 =   146;
const int SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2 =   147;
const int SQL_INDEX_KEYWORDS                  =   148;
const int SQL_INFO_SCHEMA_VIEWS               =   149;
const int SQL_KEYSET_CURSOR_ATTRIBUTES1       =   150;
const int SQL_KEYSET_CURSOR_ATTRIBUTES2       =   151;
const int SQL_MAX_ASYNC_CONCURRENT_STATEMENTS = 10022;
const int SQL_ODBC_INTERFACE_CONFORMANCE      =   152;
const int SQL_PARAM_ARRAY_ROW_COUNTS          =   153;
const int SQL_PARAM_ARRAY_SELECTS             =   154;
const int SQL_SCHEMA_TERM                     = SQL_OWNER_TERM;
const int SQL_SCHEMA_USAGE                    = SQL_OWNER_USAGE;
const int SQL_SQL92_DATETIME_FUNCTIONS        =   155;
const int SQL_SQL92_FOREIGN_KEY_DELETE_RULE   =   156;
const int SQL_SQL92_FOREIGN_KEY_UPDATE_RULE   =   157;
const int SQL_SQL92_GRANT                     =   158;
const int SQL_SQL92_NUMERIC_VALUE_FUNCTIONS   =   159;
const int SQL_SQL92_PREDICATES                =   160;
const int SQL_SQL92_RELATIONAL_JOIN_OPERATORS =   161;
const int SQL_SQL92_REVOKE                    =   162;
const int SQL_SQL92_ROW_VALUE_CONSTRUCTOR     =   163;
const int SQL_SQL92_STRING_FUNCTIONS          =   164;
const int SQL_SQL92_VALUE_EXPRESSIONS         =   165;
const int SQL_STANDARD_CLI_CONFORMANCE        =   166;
const int SQL_STATIC_CURSOR_ATTRIBUTES1       =   167;
const int SQL_STATIC_CURSOR_ATTRIBUTES2       =   168;

const int SQL_AGGREGATE_FUNCTIONS             =   169;
const int SQL_DDL_INDEX                       =   170;
const int SQL_DM_VER                          =   171;
const int SQL_INSERT_STATEMENT                =   172;
const int SQL_CONVERT_GUID                    =   173;
const int SQL_UNION_STATEMENT                 =   SQL_UNION;

// Info Types
const int SQL_ASYNC_DBC_FUNCTIONS             = 10023;

const int SQL_DTC_TRANSITION_COST             =  1750;

// SQL_ALTER_TABLE bitmasks
const int SQL_AT_ADD_COLUMN_SINGLE              =  0x00000020;
const int SQL_AT_ADD_COLUMN_DEFAULT             =  0x00000040;
const int SQL_AT_ADD_COLUMN_COLLATION           =  0x00000080;
const int SQL_AT_SET_COLUMN_DEFAULT             =  0x00000100;
const int SQL_AT_DROP_COLUMN_DEFAULT            =  0x00000200;
const int SQL_AT_DROP_COLUMN_CASCADE            =  0x00000400;
const int SQL_AT_DROP_COLUMN_RESTRICT           =  0x00000800;
const int SQL_AT_ADD_TABLE_CONSTRAINT           =  0x00001000;
const int SQL_AT_DROP_TABLE_CONSTRAINT_CASCADE  =  0x00002000;
const int SQL_AT_DROP_TABLE_CONSTRAINT_RESTRICT =  0x00004000;
const int SQL_AT_CONSTRAINT_NAME_DEFINITION     =  0x00008000;
const int SQL_AT_CONSTRAINT_INITIALLY_DEFERRED  =  0x00010000;
const int SQL_AT_CONSTRAINT_INITIALLY_IMMEDIATE =  0x00020000;
const int SQL_AT_CONSTRAINT_DEFERRABLE          =  0x00040000;
const int SQL_AT_CONSTRAINT_NON_DEFERRABLE      =  0x00080000;

// SQL_CONVERT_*  return value bitmasks
const int SQL_CVT_CHAR                = 0x00000001;
const int SQL_CVT_NUMERIC             = 0x00000002;
const int SQL_CVT_DECIMAL             = 0x00000004;
const int SQL_CVT_INTEGER             = 0x00000008;
const int SQL_CVT_SMALLINT            = 0x00000010;
const int SQL_CVT_FLOAT               = 0x00000020;
const int SQL_CVT_REAL                = 0x00000040;
const int SQL_CVT_DOUBLE              = 0x00000080;
const int SQL_CVT_VARCHAR             = 0x00000100;
const int SQL_CVT_LONGVARCHAR         = 0x00000200;
const int SQL_CVT_BINARY              = 0x00000400;
const int SQL_CVT_VARBINARY           = 0x00000800;
const int SQL_CVT_BIT                 = 0x00001000;
const int SQL_CVT_TINYINT             = 0x00002000;
const int SQL_CVT_BIGINT              = 0x00004000;
const int SQL_CVT_DATE                = 0x00008000;
const int SQL_CVT_TIME                = 0x00010000;
const int SQL_CVT_TIMESTAMP           = 0x00020000;
const int SQL_CVT_LONGVARBINARY       = 0x00040000;
const int SQL_CVT_INTERVAL_YEAR_MONTH = 0x00080000;
const int SQL_CVT_INTERVAL_DAY_TIME   = 0x00100000;
const int SQL_CVT_WCHAR               = 0x00200000;
const int SQL_CVT_WLONGVARCHAR        = 0x00400000;
const int SQL_CVT_WVARCHAR            = 0x00800000;
const int SQL_CVT_GUID                = 0x01000000;

// SQL_CONVERT_FUNCTIONS functions
const int SQL_FN_CVT_CONVERT = 0x00000001;
const int SQL_FN_CVT_CAST    = 0x00000002;

// SQL_STRING_FUNCTIONS functions
const int SQL_FN_STR_CONCAT           = 0x00000001;
const int SQL_FN_STR_INSERT           = 0x00000002;
const int SQL_FN_STR_LEFT             = 0x00000004;
const int SQL_FN_STR_LTRIM            = 0x00000008;
const int SQL_FN_STR_LENGTH           = 0x00000010;
const int SQL_FN_STR_LOCATE           = 0x00000020;
const int SQL_FN_STR_LCASE            = 0x00000040;
const int SQL_FN_STR_REPEAT           = 0x00000080;
const int SQL_FN_STR_REPLACE          = 0x00000100;
const int SQL_FN_STR_RIGHT            = 0x00000200;
const int SQL_FN_STR_RTRIM            = 0x00000400;
const int SQL_FN_STR_SUBSTRING        = 0x00000800;
const int SQL_FN_STR_UCASE            = 0x00001000;
const int SQL_FN_STR_ASCII            = 0x00002000;
const int SQL_FN_STR_CHAR             = 0x00004000;
const int SQL_FN_STR_DIFFERENCE       = 0x00008000;
const int SQL_FN_STR_LOCATE_2         = 0x00010000;
const int SQL_FN_STR_SOUNDEX          = 0x00020000;
const int SQL_FN_STR_SPACE            = 0x00040000;
const int SQL_FN_STR_BIT_LENGTH       = 0x00080000;
const int SQL_FN_STR_CHAR_LENGTH      = 0x00100000;
const int SQL_FN_STR_CHARACTER_LENGTH = 0x00200000;
const int SQL_FN_STR_OCTET_LENGTH     = 0x00400000;
const int SQL_FN_STR_POSITION         = 0x00800000;

// SQL_SQL92_STRING_FUNCTIONS
const int SQL_SSF_CONVERT       = 0x00000001;
const int SQL_SSF_LOWER         = 0x00000002;
const int SQL_SSF_UPPER         = 0x00000004;
const int SQL_SSF_SUBSTRING     = 0x00000008;
const int SQL_SSF_TRANSLATE     = 0x00000010;
const int SQL_SSF_TRIM_BOTH     = 0x00000020;
const int SQL_SSF_TRIM_LEADING  = 0x00000040;
const int SQL_SSF_TRIM_TRAILING = 0x00000080;

// SQL_NUMERIC_FUNCTIONS functions
const int SQL_FN_NUM_ABS      = 0x00000001;
const int SQL_FN_NUM_ACOS     = 0x00000002;
const int SQL_FN_NUM_ASIN     = 0x00000004;
const int SQL_FN_NUM_ATAN     = 0x00000008;
const int SQL_FN_NUM_ATAN2    = 0x00000010;
const int SQL_FN_NUM_CEILING  = 0x00000020;
const int SQL_FN_NUM_COS      = 0x00000040;
const int SQL_FN_NUM_COT      = 0x00000080;
const int SQL_FN_NUM_EXP      = 0x00000100;
const int SQL_FN_NUM_FLOOR    = 0x00000200;
const int SQL_FN_NUM_LOG      = 0x00000400;
const int SQL_FN_NUM_MOD      = 0x00000800;
const int SQL_FN_NUM_SIGN     = 0x00001000;
const int SQL_FN_NUM_SIN      = 0x00002000;
const int SQL_FN_NUM_SQRT     = 0x00004000;
const int SQL_FN_NUM_TAN      = 0x00008000;
const int SQL_FN_NUM_PI       = 0x00010000;
const int SQL_FN_NUM_RAND     = 0x00020000;
const int SQL_FN_NUM_DEGREES  = 0x00040000;
const int SQL_FN_NUM_LOG10    = 0x00080000;
const int SQL_FN_NUM_POWER    = 0x00100000;
const int SQL_FN_NUM_RADIANS  = 0x00200000;
const int SQL_FN_NUM_ROUND    = 0x00400000;
const int SQL_FN_NUM_TRUNCATE = 0x00800000;

// SQL_SQL92_NUMERIC_VALUE_FUNCTIONS
const int SQL_SNVF_BIT_LENGTH       = 0x00000001;
const int SQL_SNVF_CHAR_LENGTH      = 0x00000002;
const int SQL_SNVF_CHARACTER_LENGTH = 0x00000004;
const int SQL_SNVF_EXTRACT          = 0x00000008;
const int SQL_SNVF_OCTET_LENGTH     = 0x00000010;
const int SQL_SNVF_POSITION         = 0x00000020;

// SQL_TIMEDATE_FUNCTIONS functions
const int SQL_FN_TD_NOW               = 0x00000001;
const int SQL_FN_TD_CURDATE           = 0x00000002;
const int SQL_FN_TD_DAYOFMONTH        = 0x00000004;
const int SQL_FN_TD_DAYOFWEEK         = 0x00000008;
const int SQL_FN_TD_DAYOFYEAR         = 0x00000010;
const int SQL_FN_TD_MONTH             = 0x00000020;
const int SQL_FN_TD_QUARTER           = 0x00000040;
const int SQL_FN_TD_WEEK              = 0x00000080;
const int SQL_FN_TD_YEAR              = 0x00000100;
const int SQL_FN_TD_CURTIME           = 0x00000200;
const int SQL_FN_TD_HOUR              = 0x00000400;
const int SQL_FN_TD_MINUTE            = 0x00000800;
const int SQL_FN_TD_SECOND            = 0x00001000;
const int SQL_FN_TD_TIMESTAMPADD      = 0x00002000;
const int SQL_FN_TD_TIMESTAMPDIFF     = 0x00004000;
const int SQL_FN_TD_DAYNAME           = 0x00008000;
const int SQL_FN_TD_MONTHNAME         = 0x00010000;
const int SQL_FN_TD_CURRENT_DATE      = 0x00020000;
const int SQL_FN_TD_CURRENT_TIME      = 0x00040000;
const int SQL_FN_TD_CURRENT_TIMESTAMP = 0x00080000;
const int SQL_FN_TD_EXTRACT           = 0x00100000;

// SQL_SQL92_DATETIME_FUNCTIONS
const int SQL_SDF_CURRENT_DATE      = 0x00000001;
const int SQL_SDF_CURRENT_TIME      = 0x00000002;
const int SQL_SDF_CURRENT_TIMESTAMP = 0x00000004;

// SQL_SYSTEM_FUNCTIONS functions
const int SQL_FN_SYS_USERNAME = 0x00000001;
const int SQL_FN_SYS_DBNAME   = 0x00000002;
const int SQL_FN_SYS_IFNULL   = 0x00000004;

// SQL_TIMEDATE_ADD_INTERVALS and SQL_TIMEDATE_DIFF_INTERVALS functions
const int SQL_FN_TSI_FRAC_SECOND = 0x00000001;
const int SQL_FN_TSI_SECOND      = 0x00000002;
const int SQL_FN_TSI_MINUTE      = 0x00000004;
const int SQL_FN_TSI_HOUR        = 0x00000008;
const int SQL_FN_TSI_DAY         = 0x00000010;
const int SQL_FN_TSI_WEEK        = 0x00000020;
const int SQL_FN_TSI_MONTH       = 0x00000040;
const int SQL_FN_TSI_QUARTER     = 0x00000080;
const int SQL_FN_TSI_YEAR        = 0x00000100;

// Supported SQLFetchScroll FetchOrientation's
const int SQL_CA1_NEXT     = 0x00000001;
const int SQL_CA1_ABSOLUTE = 0x00000002;
const int SQL_CA1_RELATIVE = 0x00000004;
const int SQL_CA1_BOOKMARK = 0x00000008;

// Supported SQLSetPos LockType's
const int SQL_CA1_LOCK_NO_CHANGE = 0x00000040;
const int SQL_CA1_LOCK_EXCLUSIVE = 0x00000080;
const int SQL_CA1_LOCK_UNLOCK    = 0x00000100;

// Supported SQLSetPos Operations
const int SQL_CA1_POS_POSITION = 0x00000200;
const int SQL_CA1_POS_UPDATE   = 0x00000400;
const int SQL_CA1_POS_DELETE   = 0x00000800;
const int SQL_CA1_POS_REFRESH  = 0x00001000;

// Positioned updates and deletes
const int SQL_CA1_POSITIONED_UPDATE = 0x00002000;
const int SQL_CA1_POSITIONED_DELETE = 0x00004000;
const int SQL_CA1_SELECT_FOR_UPDATE = 0x00008000;

// Supported SQLBulkOperations operations
const int SQL_CA1_BULK_ADD                = 0x00010000;
const int SQL_CA1_BULK_UPDATE_BY_BOOKMARK = 0x00020000;
const int SQL_CA1_BULK_DELETE_BY_BOOKMARK = 0x00040000;
const int SQL_CA1_BULK_FETCH_BY_BOOKMARK  = 0x00080000;

// Supported values for SQL_ATTR_SCROLL_CONCURRENCY
const int SQL_CA2_READ_ONLY_CONCURRENCY  = 0x00000001;
const int SQL_CA2_LOCK_CONCURRENCY       = 0x00000002;
const int SQL_CA2_OPT_ROWVER_CONCURRENCY = 0x00000004;
const int SQL_CA2_OPT_VALUES_CONCURRENCY = 0x00000008;

// Sensitivity of the cursor to its own inserts, deletes, and updates
const int SQL_CA2_SENSITIVITY_ADDITIONS = 0x00000010;
const int SQL_CA2_SENSITIVITY_DELETIONS = 0x00000020;
const int SQL_CA2_SENSITIVITY_UPDATES   = 0x00000040;

// Semantics of SQL_ATTR_MAX_ROWS
const int SQL_CA2_MAX_ROWS_SELECT      = 0x00000080;
const int SQL_CA2_MAX_ROWS_INSERT      = 0x00000100;
const int SQL_CA2_MAX_ROWS_DELETE      = 0x00000200;
const int SQL_CA2_MAX_ROWS_UPDATE      = 0x00000400;
const int SQL_CA2_MAX_ROWS_CATALOG     = 0x00000800;
const int SQL_CA2_MAX_ROWS_AFFECTS_ALL = SQL_CA2_MAX_ROWS_SELECT |
                                         SQL_CA2_MAX_ROWS_INSERT |
                                         SQL_CA2_MAX_ROWS_DELETE |
                                         SQL_CA2_MAX_ROWS_UPDATE |
                                         SQL_CA2_MAX_ROWS_CATALOG;

// Semantics of SQL_DIAG_CURSOR_ROW_COUNT
const int SQL_CA2_CRC_EXACT       = 0x00001000;
const int SQL_CA2_CRC_APPROXIMATE = 0x00002000;

// The kinds of positioned statements that can be simulated
const int SQL_CA2_SIMULATE_NON_UNIQUE = 0x00004000;
const int SQL_CA2_SIMULATE_TRY_UNIQUE = 0x00008000;
const int SQL_CA2_SIMULATE_UNIQUE     = 0x00010000;

// SQL_ODBC_API_CONFORMANCE values
const int SQL_OAC_NONE   = 0x0000;
const int SQL_OAC_LEVEL1 = 0x0001;
const int SQL_OAC_LEVEL2 = 0x0002;

// SQL_ODBC_SAG_CLI_CONFORMANCE values
const int SQL_OSCC_NOT_COMPLIANT = 0x0000;
const int SQL_OSCC_COMPLIANT     = 0x0001;

// SQL_ODBC_SQL_CONFORMANCE values
const int SQL_OSC_MINIMUM  = 0x0000;
const int SQL_OSC_CORE     = 0x0001;
const int SQL_OSC_EXTENDED = 0x0002;

// SQL_CONCAT_NULL_BEHAVIOR values
const int SQL_CB_NULL      = 0x0000;
const int SQL_CB_NON_NULL  = 0x0001;

// SQL_SCROLL_OPTIONS masks
const int SQL_SO_FORWARD_ONLY  = 0x00000001;
const int SQL_SO_KEYSET_DRIVEN = 0x00000002;
const int SQL_SO_DYNAMIC       = 0x00000004;
const int SQL_SO_MIXED         = 0x00000008;
const int SQL_SO_STATIC        = 0x00000010;

const int SQL_FD_FETCH_BOOKMARK = 0x00000080;

// SQL_CORRELATION_NAME values
const int SQL_CN_NONE      = 0x0000;
const int SQL_CN_DIFFERENT = 0x0001;
const int SQL_CN_ANY       = 0x0002;

// SQL_NON_NULLABLE_COLUMNS values
const int SQL_NNC_NULL     = 0x0000;
const int SQL_NNC_NON_NULL = 0x0001;

// SQL_NULL_COLLATION values
const int SQL_NC_START = 0x0002;
const int SQL_NC_END   = 0x0004;

// SQL_FILE_USAGE values
const int SQL_FILE_NOT_SUPPORTED = 0x0000;
const int SQL_FILE_TABLE         = 0x0001;
const int SQL_FILE_QUALIFIER     = 0x0002;
const int SQL_FILE_CATALOG       = SQL_FILE_QUALIFIER;

// SQL_GETDATA_EXTENSIONS values
const int SQL_GD_BLOCK         = 0x00000004;
const int SQL_GD_BOUND         = 0x00000008;
const int SQL_GD_OUTPUT_PARAMS = 0x00000010;

// SQL_POSITIONED_STATEMENTS masks
const int SQL_PS_POSITIONED_DELETE = 0x00000001;
const int SQL_PS_POSITIONED_UPDATE = 0x00000002;
const int SQL_PS_SELECT_FOR_UPDATE = 0x00000004;

// SQL_GROUP_BY values
const int SQL_GB_NOT_SUPPORTED            = 0x0000;
const int SQL_GB_GROUP_BY_EQUALS_SELECT   = 0x0001;
const int SQL_GB_GROUP_BY_CONTAINS_SELECT = 0x0002;
const int SQL_GB_NO_RELATION              = 0x0003;
const int SQL_GB_COLLATE                  = 0x0004;

// SQL_OWNER_USAGE masks
const int SQL_OU_DML_STATEMENTS       = 0x00000001;
const int SQL_OU_PROCEDURE_INVOCATION = 0x00000002;
const int SQL_OU_TABLE_DEFINITION     = 0x00000004;
const int SQL_OU_INDEX_DEFINITION     = 0x00000008;
const int SQL_OU_PRIVILEGE_DEFINITION = 0x00000010;

// SQL_SCHEMA_USAGE masks
const int SQL_SU_DML_STATEMENTS       = SQL_OU_DML_STATEMENTS;
const int SQL_SU_PROCEDURE_INVOCATION = SQL_OU_PROCEDURE_INVOCATION;
const int SQL_SU_TABLE_DEFINITION     = SQL_OU_TABLE_DEFINITION;
const int SQL_SU_INDEX_DEFINITION     = SQL_OU_INDEX_DEFINITION;
const int SQL_SU_PRIVILEGE_DEFINITION = SQL_OU_PRIVILEGE_DEFINITION;

// SQL_QUALIFIER_USAGE masks
const int SQL_QU_DML_STATEMENTS       = 0x00000001;
const int SQL_QU_PROCEDURE_INVOCATION = 0x00000002;
const int SQL_QU_TABLE_DEFINITION     = 0x00000004;
const int SQL_QU_INDEX_DEFINITION     = 0x00000008;
const int SQL_QU_PRIVILEGE_DEFINITION = 0x00000010;

// SQL_CATALOG_USAGE masks
const int SQL_CU_DML_STATEMENTS       = SQL_QU_DML_STATEMENTS;
const int SQL_CU_PROCEDURE_INVOCATION = SQL_QU_PROCEDURE_INVOCATION;
const int SQL_CU_TABLE_DEFINITION     = SQL_QU_TABLE_DEFINITION;
const int SQL_CU_INDEX_DEFINITION     = SQL_QU_INDEX_DEFINITION;
const int SQL_CU_PRIVILEGE_DEFINITION = SQL_QU_PRIVILEGE_DEFINITION;

// SQL_SUBQUERIES masks
const int SQL_SQ_COMPARISON            = 0x00000001;
const int SQL_SQ_EXISTS                = 0x00000002;
const int SQL_SQ_IN                    = 0x00000004;
const int SQL_SQ_QUANTIFIED            = 0x00000008;
const int SQL_SQ_CORRELATED_SUBQUERIES = 0x00000010;

// SQL_UNION masks
const int SQL_U_UNION     = 0x00000001;
const int SQL_U_UNION_ALL = 0x00000002;

// SQL_BOOKMARK_PERSISTENCE values
const int SQL_BP_CLOSE       = 0x00000001;
const int SQL_BP_DELETE      = 0x00000002;
const int SQL_BP_DROP        = 0x00000004;
const int SQL_BP_TRANSACTION = 0x00000008;
const int SQL_BP_UPDATE      = 0x00000010;
const int SQL_BP_OTHER_HSTMT = 0x00000020;
const int SQL_BP_SCROLL      = 0x00000040;

// SQL_STATIC_SENSITIVITY values
const int SQL_SS_ADDITIONS = 0x00000001;
const int SQL_SS_DELETIONS = 0x00000002;
const int SQL_SS_UPDATES   = 0x00000004;

// SQL_VIEW values
const int SQL_CV_CREATE_VIEW  = 0x00000001;
const int SQL_CV_CHECK_OPTION = 0x00000002;
const int SQL_CV_CASCADED     = 0x00000004;
const int SQL_CV_LOCAL        = 0x00000008;

// SQL_LOCK_TYPES masks
const int SQL_LCK_NO_CHANGE = 0x00000001;
const int SQL_LCK_EXCLUSIVE = 0x00000002;
const int SQL_LCK_UNLOCK    = 0x00000004;

// SQL_POS_OPERATIONS masks
const int SQL_POS_POSITION = 0x00000001;
const int SQL_POS_REFRESH  = 0x00000002;
const int SQL_POS_UPDATE   = 0x00000004;
const int SQL_POS_DELETE   = 0x00000008;
const int SQL_POS_ADD      = 0x00000010;

// SQL_QUALIFIER_LOCATION values
const int SQL_QL_START = 0x0001;
const int SQL_QL_END   = 0x0002;

// SQL_AGGREGATE_FUNCTIONS bitmasks
const int SQL_AF_AVG      = 0x00000001;
const int SQL_AF_COUNT    = 0x00000002;
const int SQL_AF_MAX      = 0x00000004;
const int SQL_AF_MIN      = 0x00000008;
const int SQL_AF_SUM      = 0x00000010;
const int SQL_AF_DISTINCT = 0x00000020;
const int SQL_AF_ALL      = 0x00000040;

// SQL_SQL_CONFORMANCE bit masks
const int SQL_SC_SQL92_ENTRY            = 0x00000001;
const int SQL_SC_FIPS127_2_TRANSITIONAL = 0x00000002;
const int SQL_SC_SQL92_INTERMEDIATE     = 0x00000004;
const int SQL_SC_SQL92_FULL             = 0x00000008;

// SQL_DATETIME_LITERALS masks
const int SQL_DL_SQL92_DATE                      = 0x00000001;
const int SQL_DL_SQL92_TIME                      = 0x00000002;
const int SQL_DL_SQL92_TIMESTAMP                 = 0x00000004;
const int SQL_DL_SQL92_INTERVAL_YEAR             = 0x00000008;
const int SQL_DL_SQL92_INTERVAL_MONTH            = 0x00000010;
const int SQL_DL_SQL92_INTERVAL_DAY              = 0x00000020;
const int SQL_DL_SQL92_INTERVAL_HOUR             = 0x00000040;
const int SQL_DL_SQL92_INTERVAL_MINUTE           = 0x00000080;
const int SQL_DL_SQL92_INTERVAL_SECOND           = 0x00000100;
const int SQL_DL_SQL92_INTERVAL_YEAR_TO_MONTH    = 0x00000200;
const int SQL_DL_SQL92_INTERVAL_DAY_TO_HOUR      = 0x00000400;
const int SQL_DL_SQL92_INTERVAL_DAY_TO_MINUTE    = 0x00000800;
const int SQL_DL_SQL92_INTERVAL_DAY_TO_SECOND    = 0x00001000;
const int SQL_DL_SQL92_INTERVAL_HOUR_TO_MINUTE   = 0x00002000;
const int SQL_DL_SQL92_INTERVAL_HOUR_TO_SECOND   = 0x00004000;
const int SQL_DL_SQL92_INTERVAL_MINUTE_TO_SECOND = 0x00008000;

// SQL_CATALOG_LOCATION values
const int SQL_CL_START = SQL_QL_START;
const int SQL_CL_END   = SQL_QL_END;

// Values for SQL_BATCH_ROW_COUNT
const int SQL_BRC_PROCEDURES = 0x0000001;
const int SQL_BRC_EXPLICIT   = 0x0000002;
const int SQL_BRC_ROLLED_UP  = 0x0000004;

// Bitmasks for SQL_BATCH_SUPPORT
const int SQL_BS_SELECT_EXPLICIT    = 0x00000001;
const int SQL_BS_ROW_COUNT_EXPLICIT = 0x00000002;
const int SQL_BS_SELECT_PROC        = 0x00000004;
const int SQL_BS_ROW_COUNT_PROC     = 0x00000008;

// Values for SQL_PARAM_ARRAY_ROW_COUNTS getinfo
const int SQL_PARC_BATCH    = 1;
const int SQL_PARC_NO_BATCH = 2;

// values for SQL_PARAM_ARRAY_SELECTS
const int SQL_PAS_BATCH     = 1;
const int SQL_PAS_NO_BATCH  = 2;
const int SQL_PAS_NO_SELECT = 3;

// Bitmasks for SQL_INDEX_KEYWORDS
const int SQL_IK_NONE = 0x00000000;
const int SQL_IK_ASC  = 0x00000001;
const int SQL_IK_DESC = 0x00000002;
const int SQL_IK_ALL  = SQL_IK_ASC | SQL_IK_DESC;

// Bitmasks for SQL_INFO_SCHEMA_VIEWS
const int SQL_ISV_ASSERTIONS              = 0x00000001;
const int SQL_ISV_CHARACTER_SETS          = 0x00000002;
const int SQL_ISV_CHECK_CONSTRAINTS       = 0x00000004;
const int SQL_ISV_COLLATIONS              = 0x00000008;
const int SQL_ISV_COLUMN_DOMAIN_USAGE     = 0x00000010;
const int SQL_ISV_COLUMN_PRIVILEGES       = 0x00000020;
const int SQL_ISV_COLUMNS                 = 0x00000040;
const int SQL_ISV_CONSTRAINT_COLUMN_USAGE = 0x00000080;
const int SQL_ISV_CONSTRAINT_TABLE_USAGE  = 0x00000100;
const int SQL_ISV_DOMAIN_CONSTRAINTS      = 0x00000200;
const int SQL_ISV_DOMAINS                 = 0x00000400;
const int SQL_ISV_KEY_COLUMN_USAGE        = 0x00000800;
const int SQL_ISV_REFERENTIAL_CONSTRAINTS = 0x00001000;
const int SQL_ISV_SCHEMATA                = 0x00002000;
const int SQL_ISV_SQL_LANGUAGES           = 0x00004000;
const int SQL_ISV_TABLE_CONSTRAINTS       = 0x00008000;
const int SQL_ISV_TABLE_PRIVILEGES        = 0x00010000;
const int SQL_ISV_TABLES                  = 0x00020000;
const int SQL_ISV_TRANSLATIONS            = 0x00040000;
const int SQL_ISV_USAGE_PRIVILEGES        = 0x00080000;
const int SQL_ISV_VIEW_COLUMN_USAGE       = 0x00100000;
const int SQL_ISV_VIEW_TABLE_USAGE        = 0x00200000;
const int SQL_ISV_VIEWS                   = 0x00400000;

// Bitmasks for SQL_ALTER_DOMAIN
const int SQL_AD_CONSTRAINT_NAME_DEFINITION         = 0x00000001;
const int SQL_AD_ADD_DOMAIN_CONSTRAINT              = 0x00000002;
const int SQL_AD_DROP_DOMAIN_CONSTRAINT             = 0x00000004;
const int SQL_AD_ADD_DOMAIN_DEFAULT                 = 0x00000008;
const int SQL_AD_DROP_DOMAIN_DEFAULT                = 0x00000010;
const int SQL_AD_ADD_CONSTRAINT_INITIALLY_DEFERRED  = 0x00000020;
const int SQL_AD_ADD_CONSTRAINT_INITIALLY_IMMEDIATE = 0x00000040;
const int SQL_AD_ADD_CONSTRAINT_DEFERRABLE          = 0x00000080;
const int SQL_AD_ADD_CONSTRAINT_NON_DEFERRABLE      = 0x00000100;

// SQL_CREATE_SCHEMA bitmasks
const int SQL_CS_CREATE_SCHEMA         = 0x00000001;
const int SQL_CS_AUTHORIZATION         = 0x00000002;
const int SQL_CS_DEFAULT_CHARACTER_SET = 0x00000004;

// SQL_CREATE_TRANSLATION bitmasks
const int SQL_CTR_CREATE_TRANSLATION = 0x00000001;

/* SQL_CREATE_ASSERTION bitmasks */
const int SQL_CA_CREATE_ASSERTION               = 0x00000001;
const int SQL_CA_CONSTRAINT_INITIALLY_DEFERRED  = 0x00000010;
const int SQL_CA_CONSTRAINT_INITIALLY_IMMEDIATE = 0x00000020;
const int SQL_CA_CONSTRAINT_DEFERRABLE          = 0x00000040;
const int SQL_CA_CONSTRAINT_NON_DEFERRABLE      = 0x00000080;

// SQL_CREATE_CHARACTER_SET bitmasks
const int SQL_CCS_CREATE_CHARACTER_SET = 0x00000001;
const int SQL_CCS_COLLATE_CLAUSE       = 0x00000002;
const int SQL_CCS_LIMITED_COLLATION    = 0x00000004;

// SQL_CREATE_COLLATION bitmasks
const int SQL_CCOL_CREATE_COLLATION = 0x00000001;

// SQL_CREATE_DOMAIN bitmasks
const int SQL_CDO_CREATE_DOMAIN                  = 0x00000001;
const int SQL_CDO_DEFAULT                        = 0x00000002;
const int SQL_CDO_CONSTRAINT                     = 0x00000004;
const int SQL_CDO_COLLATION                      = 0x00000008;
const int SQL_CDO_CONSTRAINT_NAME_DEFINITION     = 0x00000010;
const int SQL_CDO_CONSTRAINT_INITIALLY_DEFERRED  = 0x00000020;
const int SQL_CDO_CONSTRAINT_INITIALLY_IMMEDIATE = 0x00000040;
const int SQL_CDO_CONSTRAINT_DEFERRABLE          = 0x00000080;
const int SQL_CDO_CONSTRAINT_NON_DEFERRABLE      = 0x00000100;

// SQL_CREATE_TABLE bitmasks
const int SQL_CT_CREATE_TABLE                   = 0x00000001;
const int SQL_CT_COMMIT_PRESERVE                = 0x00000002;
const int SQL_CT_COMMIT_DELETE                  = 0x00000004;
const int SQL_CT_GLOBAL_TEMPORARY               = 0x00000008;
const int SQL_CT_LOCAL_TEMPORARY                = 0x00000010;
const int SQL_CT_CONSTRAINT_INITIALLY_DEFERRED  = 0x00000020;
const int SQL_CT_CONSTRAINT_INITIALLY_IMMEDIATE = 0x00000040;
const int SQL_CT_CONSTRAINT_DEFERRABLE          = 0x00000080;
const int SQL_CT_CONSTRAINT_NON_DEFERRABLE      = 0x00000100;
const int SQL_CT_COLUMN_CONSTRAINT              = 0x00000200;
const int SQL_CT_COLUMN_DEFAULT                 = 0x00000400;
const int SQL_CT_COLUMN_COLLATION               = 0x00000800;
const int SQL_CT_TABLE_CONSTRAINT               = 0x00001000;
const int SQL_CT_CONSTRAINT_NAME_DEFINITION     = 0x00002000;

// SQL_DDL_INDEX bitmasks
const int SQL_DI_CREATE_INDEX = 0x00000001;
const int SQL_DI_DROP_INDEX   = 0x00000002;

// SQL_DROP_COLLATION bitmasks
const int SQL_DC_DROP_COLLATION = 0x00000001;

// SQL_DROP_DOMAIN bitmasks
const int SQL_DD_DROP_DOMAIN = 0x00000001;
const int SQL_DD_RESTRICT    = 0x00000002;
const int SQL_DD_CASCADE     = 0x00000004;

// SQL_DROP_SCHEMA bitmasks
const int SQL_DS_DROP_SCHEMA = 0x00000001;
const int SQL_DS_RESTRICT    = 0x00000002;
const int SQL_DS_CASCADE     = 0x00000004;

// SQL_DROP_CHARACTER_SET bitmasks
const int SQL_DCS_DROP_CHARACTER_SET = 0x00000001;

// SQL_DROP_ASSERTION bitmasks
const int SQL_DA_DROP_ASSERTION = 0x00000001;

// SQL_DROP_TABLE bitmasks
const int SQL_DT_DROP_TABLE = 0x00000001;
const int SQL_DT_RESTRICT   = 0x00000002;
const int SQL_DT_CASCADE    = 0x00000004;

// SQL_DROP_TRANSLATION bitmasks
const int SQL_DTR_DROP_TRANSLATION = 0x00000001;

// SQL_DROP_VIEW bitmasks
const int SQL_DV_DROP_VIEW = 0x00000001;
const int SQL_DV_RESTRICT  = 0x00000002;
const int SQL_DV_CASCADE   = 0x00000004;

// SQL_INSERT_STATEMENT bitmasks
const int SQL_IS_INSERT_LITERALS = 0x00000001;
const int SQL_IS_INSERT_SEARCHED = 0x00000002;
const int SQL_IS_SELECT_INTO     = 0x00000004;

// SQL_ODBC_INTERFACE_CONFORMANCE values
const int SQL_OIC_CORE   = 1;
const int SQL_OIC_LEVEL1 = 2;
const int SQL_OIC_LEVEL2 = 3;

// SQL_SQL92_FOREIGN_KEY_DELETE_RULE bitmasks
const int SQL_SFKD_CASCADE     = 0x00000001;
const int SQL_SFKD_NO_ACTION   = 0x00000002;
const int SQL_SFKD_SET_DEFAULT = 0x00000004;
const int SQL_SFKD_SET_NULL    = 0x00000008;

// SQL_SQL92_FOREIGN_KEY_UPDATE_RULE bitmasks
const int SQL_SFKU_CASCADE     = 0x00000001;
const int SQL_SFKU_NO_ACTION   = 0x00000002;
const int SQL_SFKU_SET_DEFAULT = 0x00000004;
const int SQL_SFKU_SET_NULL    = 0x00000008;

// SQL_SQL92_GRANT  bitmasks
const int SQL_SG_USAGE_ON_DOMAIN        = 0x00000001;
const int SQL_SG_USAGE_ON_CHARACTER_SET = 0x00000002;
const int SQL_SG_USAGE_ON_COLLATION     = 0x00000004;
const int SQL_SG_USAGE_ON_TRANSLATION   = 0x00000008;
const int SQL_SG_WITH_GRANT_OPTION      = 0x00000010;
const int SQL_SG_DELETE_TABLE           = 0x00000020;
const int SQL_SG_INSERT_TABLE           = 0x00000040;
const int SQL_SG_INSERT_COLUMN          = 0x00000080;
const int SQL_SG_REFERENCES_TABLE       = 0x00000100;
const int SQL_SG_REFERENCES_COLUMN      = 0x00000200;
const int SQL_SG_SELECT_TABLE           = 0x00000400;
const int SQL_SG_UPDATE_TABLE           = 0x00000800;
const int SQL_SG_UPDATE_COLUMN          = 0x00001000;

// SQL_SQL92_PREDICATES bitmasks
const int SQL_SP_EXISTS                = 0x00000001;
const int SQL_SP_ISNOTNULL             = 0x00000002;
const int SQL_SP_ISNULL                = 0x00000004;
const int SQL_SP_MATCH_FULL            = 0x00000008;
const int SQL_SP_MATCH_PARTIAL         = 0x00000010;
const int SQL_SP_MATCH_UNIQUE_FULL     = 0x00000020;
const int SQL_SP_MATCH_UNIQUE_PARTIAL  = 0x00000040;
const int SQL_SP_OVERLAPS              = 0x00000080;
const int SQL_SP_UNIQUE                = 0x00000100;
const int SQL_SP_LIKE                  = 0x00000200;
const int SQL_SP_IN                    = 0x00000400;
const int SQL_SP_BETWEEN               = 0x00000800;
const int SQL_SP_COMPARISON            = 0x00001000;
const int SQL_SP_QUANTIFIED_COMPARISON = 0x00002000;

// SQL_SQL92_RELATIONAL_JOIN_OPERATORS bitmasks
const int SQL_SRJO_CORRESPONDING_CLAUSE = 0x00000001;
const int SQL_SRJO_CROSS_JOIN           = 0x00000002;
const int SQL_SRJO_EXCEPT_JOIN          = 0x00000004;
const int SQL_SRJO_FULL_OUTER_JOIN      = 0x00000008;
const int SQL_SRJO_INNER_JOIN           = 0x00000010;
const int SQL_SRJO_INTERSECT_JOIN       = 0x00000020;
const int SQL_SRJO_LEFT_OUTER_JOIN      = 0x00000040;
const int SQL_SRJO_NATURAL_JOIN         = 0x00000080;
const int SQL_SRJO_RIGHT_OUTER_JOIN     = 0x00000100;
const int SQL_SRJO_UNION_JOIN           = 0x00000200;

// SQL_SQL92_REVOKE bitmasks
const int SQL_SR_USAGE_ON_DOMAIN        = 0x00000001;
const int SQL_SR_USAGE_ON_CHARACTER_SET = 0x00000002;
const int SQL_SR_USAGE_ON_COLLATION     = 0x00000004;
const int SQL_SR_USAGE_ON_TRANSLATION   = 0x00000008;
const int SQL_SR_GRANT_OPTION_FOR       = 0x00000010;
const int SQL_SR_CASCADE                = 0x00000020;
const int SQL_SR_RESTRICT               = 0x00000040;
const int SQL_SR_DELETE_TABLE           = 0x00000080;
const int SQL_SR_INSERT_TABLE           = 0x00000100;
const int SQL_SR_INSERT_COLUMN          = 0x00000200;
const int SQL_SR_REFERENCES_TABLE       = 0x00000400;
const int SQL_SR_REFERENCES_COLUMN      = 0x00000800;
const int SQL_SR_SELECT_TABLE           = 0x00001000;
const int SQL_SR_UPDATE_TABLE           = 0x00002000;
const int SQL_SR_UPDATE_COLUMN          = 0x00004000;

// SQL_SQL92_ROW_VALUE_CONSTRUCTOR bitmasks
const int SQL_SRVC_VALUE_EXPRESSION = 0x00000001;
const int SQL_SRVC_NULL             = 0x00000002;
const int SQL_SRVC_DEFAULT          = 0x00000004;
const int SQL_SRVC_ROW_SUBQUERY     = 0x00000008;

// SQL_SQL92_VALUE_EXPRESSIONS bitmasks
const int SQL_SVE_CASE     = 0x00000001;
const int SQL_SVE_CAST     = 0x00000002;
const int SQL_SVE_COALESCE = 0x00000004;
const int SQL_SVE_NULLIF   = 0x00000008;

// SQL_STANDARD_CLI_CONFORMANCE bitmasks
const int SQL_SCC_XOPEN_CLI_VERSION1 = 0x00000001;
const int SQL_SCC_ISO92_CLI          = 0x00000002;

// SQL_UNION_STATEMENT bitmasks
const int SQL_US_UNION     = SQL_U_UNION;
const int SQL_US_UNION_ALL = SQL_U_UNION_ALL;

// SQL_DTC_TRANSITION_COST bitmasks
const int SQL_DTC_ENLIST_EXPENSIVE   = 0x00000001;
const int SQL_DTC_UNENLIST_EXPENSIVE = 0x00000002;

// Possible values for SQL_ASYNC_DBC_FUNCTIONS
const int SQL_ASYNC_DBC_NOT_CAPABLE = 0x00000000;
const int SQL_ASYNC_DBC_CAPABLE     = 0x00000001;

// Additional SQLDataSources fetch directions
const int SQL_FETCH_FIRST_USER   = 31;
const int SQL_FETCH_FIRST_SYSTEM = 32;

// Defines for SQLSetPos
const int SQL_ENTIRE_ROWSET = 0;

// Operations in SQLSetPos
const int SQL_POSITION = 0;
const int SQL_REFRESH  = 1;
const int SQL_UPDATE   = 2;
const int SQL_DELETE   = 3;

// Operations in SQLBulkOperations
const int SQL_ADD                     = 4;
const int SQL_SETPOS_MAX_OPTION_VALUE = SQL_ADD;
const int SQL_UPDATE_BY_BOOKMARK      = 5;
const int SQL_DELETE_BY_BOOKMARK      = 6;
const int SQL_FETCH_BY_BOOKMARK       = 7;

// Lock options in SQLSetPos
const int SQL_LOCK_NO_CHANGE = 0;
const int SQL_LOCK_EXCLUSIVE = 1;
const int SQL_LOCK_UNLOCK    = 2;

const int SQL_SETPOS_MAX_LOCK_VALUE = SQL_LOCK_UNLOCK;

// Macros for SQLSetPos
int sqlPositionTo(SqlHandle hStmt, int row)
    => sqlSetPos(hStmt, row, SQL_POSITION, SQL_LOCK_NO_CHANGE);
int sqlLockRecord(SqlHandle hStmt, int row, int lock)
    => sqlSetPos(hStmt, row, SQL_POSITION, lock);
int sqlRefreshRecord(SqlHandle hStmt, int row, int lock)
    => sqlSetPos(hStmt, row, SQL_REFRESH, lock);
int sqlUpdateRecord(SqlHandle hStmt, int row)
    => sqlSetPos(hStmt, row, SQL_UPDATE, SQL_LOCK_NO_CHANGE);
int sqlDeleteRecord(SqlHandle hStmt, int row)
    => sqlSetPos(hStmt, row, SQL_DELETE, SQL_LOCK_NO_CHANGE);
int sqlAddRecord(SqlHandle hStmt, int row)
    => sqlSetPos(hStmt, row, SQL_ADD, SQL_LOCK_NO_CHANGE);

// Column types and scopes in SQLSpecialColumns
const int SQL_BEST_ROWID = 1;
const int SQL_ROWVER     = 2;

// Defines for SQLSpecialColumns
const int SQL_PC_NOT_PSEUDO = 1;

// Defines for SQLStatistics
const int SQL_QUICK  = 0;
const int SQL_ENSURE = 1;

// Defines for SQLStatistics
const int SQL_TABLE_STAT = 0;

// Defines for SQLTables
const String SQL_ALL_CATALOGS    = "%";
const String SQL_ALL_SCHEMAS     = "%";
const String SQL_ALL_TABLE_TYPES = "%";

// Options for SQLDriverConnect
const int SQL_DRIVER_NOPROMPT          = 0;
const int SQL_DRIVER_COMPLETE          = 1;
const int SQL_DRIVER_PROMPT            = 2;
const int SQL_DRIVER_COMPLETE_REQUIRED = 3;

// SQLExtendedFetch "fFetchType" values
const int SQL_FETCH_BOOKMARK = 8;

// SQLExtendedFetch "rgfRowStatus" element values
const int SQL_ROW_SUCCESS           = 0;
const int SQL_ROW_DELETED           = 1;
const int SQL_ROW_UPDATED           = 2;
const int SQL_ROW_NOROW             = 3;
const int SQL_ROW_ADDED             = 4;
const int SQL_ROW_ERROR             = 5;
const int SQL_ROW_SUCCESS_WITH_INFO = 6;
const int SQL_ROW_PROCEED           = 0;
const int SQL_ROW_IGNORE            = 1;

// Value for SQL_DESC_ARRAY_STATUS_PTR
const int SQL_PARAM_SUCCESS           = 0;
const int SQL_PARAM_SUCCESS_WITH_INFO = 6;
const int SQL_PARAM_ERROR             = 5;
const int SQL_PARAM_UNUSED            = 7;
const int SQL_PARAM_DIAG_UNAVAILABLE  = 1;

const int SQL_PARAM_PROCEED = 0;
const int SQL_PARAM_IGNORE  = 1;

// Defines for SQLForeignKeys (UPDATE_RULE and DELETE_RULE)
const int SQL_CASCADE     = 0;
const int SQL_RESTRICT    = 1;
const int SQL_SET_NULL    = 2;
const int SQL_NO_ACTION   = 3;
const int SQL_SET_DEFAULT = 4;

const int SQL_INITIALLY_DEFERRED  = 5;
const int SQL_INITIALLY_IMMEDIATE = 6;
const int SQL_NOT_DEFERRABLE      = 7;

// Defines for SQLBindParameter and SQLProcedureColumns
const int SQL_PARAM_TYPE_UNKNOWN        =  0;
const int SQL_PARAM_INPUT               =  1;
const int SQL_PARAM_INPUT_OUTPUT        =  2;
const int SQL_RESULT_COL                =  3;
const int SQL_PARAM_OUTPUT              =  4;
const int SQL_RETURN_VALUE              =  5;
const int SQL_PARAM_INPUT_OUTPUT_STREAM =  8;
const int SQL_PARAM_OUTPUT_STREAM       = 16;

// Defines for SQLProcedures
const int SQL_PT_UNKNOWN   = 0;
const int SQL_PT_PROCEDURE = 1;
const int SQL_PT_FUNCTION  = 2;

const String SQL_ODBC_KEYWORDS =
    "ABSOLUTE,ACTION,ADA,ADD,ALL,ALLOCATE,ALTER,AND,ANY,ARE,AS,"
    "ASC,ASSERTION,AT,AUTHORIZATION,AVG,"
    "BEGIN,BETWEEN,BIT,BIT_LENGTH,BOTH,BY,CASCADE,CASCADED,CASE,CAST,CATALOG,"
    "CHAR,CHAR_LENGTH,CHARACTER,CHARACTER_LENGTH,CHECK,CLOSE,COALESCE,"
    "COLLATE,COLLATION,COLUMN,COMMIT,CONNECT,CONNECTION,CONSTRAINT,"
    "CONSTRAINTS,CONTINUE,CONVERT,CORRESPONDING,COUNT,CREATE,CROSS,CURRENT,"
    "CURRENT_DATE,CURRENT_TIME,CURRENT_TIMESTAMP,CURRENT_USER,CURSOR,"
    "DATE,DAY,DEALLOCATE,DEC,DECIMAL,DECLARE,DEFAULT,DEFERRABLE,"
    "DEFERRED,DELETE,DESC,DESCRIBE,DESCRIPTOR,DIAGNOSTICS,DISCONNECT,"
    "DISTINCT,DOMAIN,DOUBLE,DROP,"
    "ELSE,END,END-EXEC,ESCAPE,EXCEPT,EXCEPTION,EXEC,EXECUTE,"
    "EXISTS,EXTERNAL,EXTRACT,"
    "FALSE,FETCH,FIRST,FLOAT,FOR,FOREIGN,FORTRAN,FOUND,FROM,FULL,"
    "GET,GLOBAL,GO,GOTO,GRANT,GROUP,HAVING,HOUR,"
    "IDENTITY,IMMEDIATE,IN,INCLUDE,INDEX,INDICATOR,INITIALLY,INNER,"
    "INPUT,INSENSITIVE,INSERT,INT,INTEGER,INTERSECT,INTERVAL,INTO,IS,ISOLATION,"
    "JOIN,KEY,LANGUAGE,LAST,LEADING,LEFT,LEVEL,LIKE,LOCAL,LOWER,"
    "MATCH,MAX,MIN,MINUTE,MODULE,MONTH,"
    "NAMES,NATIONAL,NATURAL,NCHAR,NEXT,NO,NONE,NOT,NULL,NULLIF,NUMERIC,"
    "OCTET_LENGTH,OF,ON,ONLY,OPEN,OPTION,OR,ORDER,OUTER,OUTPUT,OVERLAPS,"
    "PAD,PARTIAL,PASCAL,PLI,POSITION,PRECISION,PREPARE,PRESERVE,"
    "PRIMARY,PRIOR,PRIVILEGES,PROCEDURE,PUBLIC,"
    "READ,REAL,REFERENCES,RELATIVE,RESTRICT,REVOKE,RIGHT,ROLLBACK,ROWS"
    "SCHEMA,SCROLL,SECOND,SECTION,SELECT,SESSION,SESSION_USER,SET,SIZE,"
    "SMALLINT,SOME,SPACE,SQL,SQLCA,SQLCODE,SQLERROR,SQLSTATE,SQLWARNING,"
    "SUBSTRING,SUM,SYSTEM_USER,"
    "TABLE,TEMPORARY,THEN,TIME,TIMESTAMP,TIMEZONE_HOUR,TIMEZONE_MINUTE,"
    "TO,TRAILING,TRANSACTION,TRANSLATE,TRANSLATION,TRIM,TRUE,"
    "UNION,UNIQUE,UNKNOWN,UPDATE,UPPER,USAGE,USER,USING,"
    "VALUE,VALUES,VARCHAR,VARYING,VIEW,WHEN,WHENEVER,WHERE,WITH,WORK,WRITE,"
    "YEAR,ZONE";

// Deprecated defines from prior versions of ODBC
const int SQL_DATABASE_NAME        = 16;
const int SQL_FD_FETCH_PREV        = SQL_FD_FETCH_PRIOR;
const int SQL_FETCH_PREV           = SQL_FETCH_PRIOR;
const int SQL_CONCUR_TIMESTAMP     = SQL_CONCUR_ROWVER;
const int SQL_SCCO_OPT_TIMESTAMP   = SQL_SCCO_OPT_ROWVER;
const int SQL_CC_DELETE            = SQL_CB_DELETE;
const int SQL_CR_DELETE            = SQL_CB_DELETE;
const int SQL_CC_CLOSE             = SQL_CB_CLOSE;
const int SQL_CR_CLOSE             = SQL_CB_CLOSE;
const int SQL_CC_PRESERVE          = SQL_CB_PRESERVE;
const int SQL_CR_PRESERVE          = SQL_CB_PRESERVE;
const int SQL_SCROLL_FORWARD_ONLY  = 0;
const int SQL_SCROLL_KEYSET_DRIVEN = -1;
const int SQL_SCROLL_DYNAMIC       = -2;
const int SQL_SCROLL_STATIC        = -3;
