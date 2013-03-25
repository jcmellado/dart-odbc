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

library odbc;

import "dart-ext:odbc_ext";

part "src/sql.dart";
part "src/sqltypes.dart";
part "src/sqlext.dart";
part "src/sqlucode.dart";
part "src/sqlbox.dart";

const deprecated = 0;

// ODBC version number.
int ODBC_VERSION = 0x0380;

// 64BITS.
bool ODBC_64BITS = false;

// UNICODE.
bool ODBC_UNICODE = false;

// ODBC functions.
@deprecated
int sqlAllocConnect(SqlHandle hEnv,
                    SqlHandle hConn) native "sqlAllocConnect";

@deprecated
int sqlAllocEnv(SqlHandle hEnv) native "sqlAllocEnv";

int sqlAllocHandle(int handleType,
                   SqlHandle inHandle,
                   SqlHandle outHandle) native "sqlAllocHandle";

@deprecated
int sqlAllocStmt(SqlHandle hConn,
                 SqlHandle hStmt) native "sqlAllocStmt";

int sqlBindCol(SqlHandle hStmt,
               int columnNumber,
               int ctype,
               SqlPointer value,
               int valueLen,
               SqlPointer flags) native "sqlBindCol";

int sqlBindParameter(SqlHandle hStmt,
                     int paramNumber,
                     int inOutType,
                     int cType,
                     int sqlType,
                     int columnSize,
                     int decimalDigits,
                     SqlPointer value,
                     int valueLen,
                     SqlPointer flags) native "sqlBindParameter";

int sqlBrowseConnect(SqlHandle hConn,
                     String inConnectString,
                     int inConnectStringLen,
                     SqlString outConnectString,
                     int outConnectStringLen,
                     SqlInt realOutConnectStringLen) native "sqlBrowseConnect";

int sqlBulkOperations(SqlHandle hStmt,
                      int operation) native "sqlBulkOperations";

int sqlCancel(SqlHandle hStmt) native "sqlCancel";

int sqlCancelHandle(int handleType,
                    SqlHandle hStmt) native "sqlCancelHandle";

int sqlCloseCursor(SqlHandle hStmt) native "sqlCloseCursor";

int sqlColAttribute(SqlHandle hStmt,
                    int columnNumber,
                    int field,
                    SqlString charAttribute,
                    int charAttributeLen,
                    SqlInt realCharAttributeLen,
                    SqlInt numericAttribute) native "sqlColAttribute";

@deprecated
int sqlColAttributes(SqlHandle hStmt,
                     int columnNumber,
                     int field,
                     SqlString charAttribute,
                     int charAttributeLen,
                     SqlInt realCharAttributeLen,
                     SqlInt numericAttribute) native "sqlColAttributes";

int sqlColumnPrivileges(SqlHandle hStmt,
                        String catalog,
                        int catalogLen,
                        String schema,
                        int schemaLen,
                        String table,
                        int tableLen,
                        String column,
                        int columnLen) native "sqlColumnPrivileges";

int sqlColumns(SqlHandle hStmt,
               String catalog,
               int catalogLen,
               String schema,
               int schemaLen,
               String table,
               int tableLen,
               String column,
               int columnLen) native "sqlColumns";

int sqlConnect(SqlHandle hConn,
               String server,
               int serverLen,
               String user,
               int userLen,
               String password,
               int passwordLen) native "sqlConnect";

int sqlCopyDesc(SqlHandle hDescSource,
                SqlHandle hDescTarget) native "sqlCopyDesc";

int sqlDataSources(SqlHandle hEnv,
                   int direction,
                   SqlString server,
                   int serverLen,
                   SqlInt realServerLen,
                   SqlString description,
                   int descriptionLen,
                   SqlInt realDescriptionLen) native "sqlDataSources";

int sqlDescribeCol(SqlHandle hStmt,
                   int columnNumber,
                   SqlString columnName,
                   int nameLen,
                   SqlInt realNameLen,
                   SqlInt dataType,
                   SqlInt columnSize,
                   SqlInt decimalDigits,
                   SqlInt nullable) native "sqlDescribeCol";

int sqlDescribeParam(SqlHandle hStmt,
                     int paramNumber,
                     SqlInt dataType,
                     SqlInt paramSize,
                     SqlInt decimalDigits,
                     SqlInt nullable) native "sqlDescribeParam";

int sqlDisconnect(SqlHandle hConn) native "sqlDisconnect";

int sqlDriverConnect(SqlHandle hConn,
                     SqlHWnd hWnd,
                     String inConnectString,
                     int inConnectStringLen,
                     SqlString outConnectString,
                     int outConnectStringLen,
                     SqlInt realOutConnectStringLen,
                     int driverCompletion) native "sqlDriverConnect";

int sqlDrivers(SqlHandle hEnv,
               int direction,
               SqlString description,
               int descriptionLen,
               SqlInt realDescriptionLen,
               SqlString attributes,
               int attributesLen,
               SqlInt realAttributesLen) native "sqlDrivers";

int sqlEndTran(int handleType,
               SqlHandle handle,
               int completionType) native "sqlEndTran";

@deprecated
int sqlError(SqlHandle hEnv,
             SqlHandle hConn,
             SqlHandle hStmt,
             SqlString state,
             SqlInt nativeError,
             SqlString message,
             int messageLen,
             SqlInt realMessageLen) native "sqlError";

int sqlExecDirect(SqlHandle hStmt,
                  String text,
                  int textLen) native "sqlExecDirect";

int sqlExecute(SqlHandle hStmt) native "sqlExecute";

int sqlExtendedFetch(SqlHandle hStmt,
                     int orientation,
                     int offset,
                     SqlPointer rowCount,
                     SqlPointer status) native "sqlExtendedFetch";

int sqlFetch(SqlHandle hStmt) native "sqlFetch";

int sqlFetchScroll(SqlHandle hStmt,
                   int orientation,
                   int offset) native "sqlFetchScroll";

int sqlForeignKeys(SqlHandle hStmt,
                   String pkCatalog,
                   int pkCatalogLen,
                   String pkSchema,
                   int pkSchemaLen,
                   String pkTable,
                   int pkTableLen,
                   String fkCatalog,
                   int fkCatalogLen,
                   String fkSchema,
                   int fkSchemaLen,
                   String fkTable,
                   int fkTableLen) native "sqlForeignKeys";

@deprecated
int sqlFreeConnect(SqlHandle hConn) native "sqlFreeConnect";

@deprecated
int sqlFreeEnv(SqlHandle hEnv) native "sqlFreeEnv";

int sqlFreeHandle(int handleType,
                  SqlHandle handle) native "sqlFreeHandle";

int sqlFreeStmt(SqlHandle hStmt,
                int option) native "sqlFreeStmt";

int sqlGetConnectAttr(SqlHandle hConn,
                      int attribute,
                      SqlBox value,
                      int valueLen,
                      SqlInt realValueLen) native "sqlGetConnectAttr";

@deprecated
int sqlGetConnectOption(SqlHandle hConn,
                        int option,
                        SqlBox value) native "sqlGetConnectOption";

int sqlGetCursorName(SqlHandle hStmt,
                     SqlString cursorName,
                     int nameLen,
                     SqlInt realNameLen) native "sqlGetCursorName";

int sqlGetData(SqlHandle hStmt,
               int columnNumber,
               int cType,
               SqlBox value,
               int valueLen,
               SqlInt flags) native "sqlGetData";

int sqlGetDescField(SqlHandle hDesc,
                    int recordNumber,
                    int field,
                    SqlBox value,
                    int valueLen,
                    SqlInt realValueLen) native "sqlGetDescField";

int sqlGetDescRec(SqlHandle hDesc,
                  int recordNumber,
                  SqlString name,
                  int nameLen,
                  SqlInt realNameLen,
                  SqlInt type,
                  SqlInt subType,
                  SqlInt length,
                  SqlInt precision,
                  SqlInt scale,
                  SqlInt nullable) native "sqlGetDescRec";

int sqlGetDiagField(int handleType,
                    SqlHandle handle,
                    int recordNumber,
                    int identifier,
                    SqlBox value,
                    int valueLen,
                    SqlInt realValueLen) native "sqlGetDiagField";

int sqlGetDiagRec(int handleType,
                  SqlHandle handle,
                  int recordNumber,
                  SqlString state,
                  SqlInt nativeError,
                  SqlString message,
                  int messageLen,
                  SqlInt realMessageLen) native "sqlGetDiagRec";

int sqlGetEnvAttr(SqlHandle hEnv,
                  int attribute,
                  SqlBox value,
                  int valueLen,
                  SqlInt realValueLen) native "sqlGetEnvAttr";

int sqlGetFunctions(SqlHandle hConn,
                    int function,
                    SqlPointer supported) native "sqlGetFunctions";

int sqlGetInfo(SqlHandle hConn,
               int type,
               SqlBox value,
               int valueLen,
               SqlInt realValueLen) native "sqlGetInfo";

int sqlGetStmtAttr(SqlHandle hStmt,
                   int attribute,
                   SqlBox value,
                   int valueLen,
                   SqlInt realValueLen) native "sqlGetStmtAttr";

@deprecated
int sqlGetStmtOption(SqlHandle hStmt,
                     int option,
                     SqlBox value) native "sqlGetStmtOption";

int sqlGetTypeInfo(SqlHandle hStmt,
                   int dataType) native "sqlGetTypeInfo";

int sqlMoreResults(SqlHandle hStmt) native "sqlMoreResults";

int sqlNativeSql(SqlHandle hConn,
                 String sql,
                 int sqlLen,
                 SqlString nativeSql,
                 int nativeSqlLen,
                 SqlInt realNativeSqlLen) native "sqlNativeSql";

int sqlNumParams(SqlHandle hStmt,
                 SqlInt numParams) native "sqlNumParams";

int sqlNumResultCols(SqlHandle hStmt,
                     SqlInt numColumns) native "sqlNumResultCols";

int sqlParamData(SqlHandle hStmt,
                 SqlPointer value) native "sqlParamData";

@deprecated
int sqlParamOptions(SqlHandle hStmt,
                    int rows,
                    SqlPointer status) native "sqlParamOptions";

int sqlPrepare(SqlHandle hStmt,
               String text,
               int textLen) native "sqlPrepare";

int sqlPrimaryKeys(SqlHandle hStmt,
                   String catalog,
                   int catalogLen,
                   String schema,
                   int schemaLen,
                   String table,
                   int tableLen) native "sqlPrimaryKeys";

int sqlProcedureColumns(SqlHandle hStmt,
                        String catalog,
                        int catalogLen,
                        String schema,
                        int schemaLen,
                        String procedure,
                        int procedureLen,
                        String column,
                        int columnLen) native "sqlProcedureColumns";

int sqlProcedures(SqlHandle hStmt,
                  String catalog,
                  int catalogLen,
                  String schema,
                  int schemaLen,
                  String procedure,
                  int procedureLen) native "sqlProcedures";

int sqlPutData(SqlHandle hConn,
               SqlPointer data,
               int flags) native "sqlPutData";

int sqlRowCount(SqlHandle hConn,
                SqlInt numRows) native "sqlRowCount";

int sqlSetConnectAttr(SqlHandle hConn,
                      int attribute,
                      SqlBox value,
                      int valueLen) native "sqlSetConnectAttr";

@deprecated
int sqlSetConnectOption(SqlHandle hConn,
                        int option,
                        SqlPointer value) native "sqlSetConnectOption";

int sqlSetCursorName(SqlHandle hStmt,
                     String name,
                     int nameLen) native "sqlSetCursorName";

int sqlSetDescField(SqlHandle hDesc,
                    int recordNumber,
                    int field,
                    SqlBox value,
                    int valueLen) native "sqlSetDescField";

int sqlSetDescRec(SqlHandle hDesc,
                  int recordNumber,
                  int type,
                  int subType,
                  int length,
                  int precision,
                  int scale,
                  SqlPointer value,
                  SqlPointer valueLen,
                  SqlPointer flags) native "sqlSetDescRec";

int sqlSetEnvAttr(SqlHandle hEnv,
                  int attribute,
                  SqlBox value,
                  int valueLen) native "sqlSetEnvAttr";

@deprecated
int sqlSetParam(SqlHandle hStmt,
                int paramNumber,
                int cType,
                int sqlType,
                int columnSize,
                int decimalDigits,
                SqlPointer value,
                SqlPointer valueLen) native "sqlSetParam";

int sqlSetPos(SqlHandle hStmt,
              int rowNumber,
              int operation,
              int lockType) native "sqlSetPos";
@deprecated
int sqlSetScrollOptions(SqlHandle hStmt,
                        int concurrency,
                        int numKeys,
                        int numRows) native "sqlSetScrollOptions";

int sqlSetStmtAttr(SqlHandle hStmt,
                   int attribute,
                   SqlBox value,
                   int valueLen) native "sqlSetStmtAttr";

@deprecated
int sqlSetStmtOption(SqlHandle hStmt,
                     int option,
                     SqlPointer value) native "sqlSetStmtOption";

int sqlSpecialColumns(SqlHandle hStmt,
                      int type,
                      String catalog,
                      int catalogLen,
                      String schema,
                      int schemaLen,
                      String table,
                      int tableLen,
                      int scope,
                      int nullable) native "sqlSpecialColumns";

int sqlStatistics(SqlHandle hStmt,
                  String catalog,
                  int catalogLen,
                  String schema,
                  int schemaLen,
                  String table,
                  int tableLen,
                  int unique,
                  int reserved) native "sqlStatistics";

int sqlTablePrivileges(SqlHandle hStmt,
                       String catalog,
                       int catalogLen,
                       String schema,
                       int schemaLen,
                       String table,
                       int tableLen) native "sqlTablePrivileges";

int sqlTables(SqlHandle hStmt,
              String catalog,
              int catalogLen,
              String schema,
              int schemaLen,
              String table,
              int tableLen,
              String type,
              int typeLen) native "sqlTables";

@deprecated
int sqlTransact(SqlHandle hEnv,
                SqlHandle hConn,
                int completionType) native "sqlTransact";

// Poke/Peek functions.
void _sqlAllocate(SqlBuffer container) native "sqlAllocate";

void _sqlPoke(SqlBuffer container,
              int row,
              int col,
              dynamic data) native "sqlPoke";

dynamic _sqlPeek(SqlBuffer container,
                 int row,
                 int col) native "sqlPeek";

int _sqlAddress(SqlBuffer container,
                int row,
                int col) native "sqlAddress";

int _sqlRowSize(SqlBuffer container) native "sqlRowSize";
