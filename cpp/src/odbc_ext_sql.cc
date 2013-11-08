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

#ifndef INCLUDE_ODBC_EXT_SQL_H_
#include "odbc_ext_sql.h"
#endif

#ifndef INCLUDE_ODBC_EXT_BOX_H_
#include "odbc_ext_box.h"
#endif

//
// ODBC functions.
//
#define ODBC_EXT_FUNCTION(function) \
void function(Dart_NativeArguments args) { \
  Dart_EnterScope();

#define ARGS(index) Dart_GetNativeArgument(args, index)

#define ODBC_EXT_SQLRETURN(value) \
  ODBC_EXT_RETURN_VALUE(Dart_NewInteger(value))

#define ODBC_EXT_RETURN_VALUE(value) \
  Dart_SetReturnValue(args, value); \
  ODBC_EXT_RETURN

#define ODBC_EXT_RETURN \
  Dart_ExitScope(); \
}

//SQLAllocConnect
ODBC_EXT_FUNCTION(sqlAllocConnect)
  Dart_Handle arg1 = ARGS(1);
  SQLHANDLE value1 = unboxSqlHandle(arg1);

  SQLRETURN sqlReturn = SQLAllocConnect(unboxSqlHandle(ARGS(0)),
                                        Dart_IsNull(arg1) ? NULL : &value1);
  boxSqlHandle(arg1, value1);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLAllocEnv
ODBC_EXT_FUNCTION(sqlAllocEnv)
  Dart_Handle arg0 = ARGS(0);
  SQLHANDLE value0 = unboxSqlHandle(arg0);

  SQLRETURN sqlReturn = SQLAllocEnv(Dart_IsNull(arg0) ? NULL : &value0);

  boxSqlHandle(arg0, value0);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLAllocHandle
ODBC_EXT_FUNCTION(sqlAllocHandle)
  Dart_Handle arg2 = ARGS(2);
  SQLHANDLE value2 = unboxSqlHandle(arg2);

  SQLRETURN sqlReturn = SQLAllocHandle(getSqlSmallInt(ARGS(0)),
                                       unboxSqlHandle(ARGS(1)),
                                       Dart_IsNull(arg2) ? NULL : &value2);
  boxSqlHandle(arg2, value2);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLAllocStmt
ODBC_EXT_FUNCTION(sqlAllocStmt)
  Dart_Handle arg1 = ARGS(1);
  SQLHANDLE value1 = unboxSqlHandle(arg1);

  SQLRETURN sqlReturn = SQLAllocStmt(unboxSqlHandle(ARGS(0)),
                                     Dart_IsNull(arg1) ? NULL : &value1);
  boxSqlHandle(arg1, value1);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLBindCol
ODBC_EXT_FUNCTION(sqlBindCol)
  SQLRETURN sqlReturn = SQLBindCol(unboxSqlHandle(ARGS(0)),
                                   getSqlUSmallInt(ARGS(1)),
                                   getSqlSmallInt(ARGS(2)),
                                   unboxSqlPointer(ARGS(3)),
                                   getSqlLen(ARGS(4)),
                                   unboxSqlLenPtr(ARGS(5)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLBindParameter
ODBC_EXT_FUNCTION(sqlBindParameter)
  SQLRETURN sqlReturn = SQLBindParameter(unboxSqlHandle(ARGS(0)),
                                         getSqlUSmallInt(ARGS(1)),
                                         getSqlSmallInt(ARGS(2)),
                                         getSqlSmallInt(ARGS(3)),
                                         getSqlSmallInt(ARGS(4)),
                                         getSqlULen(ARGS(5)),
                                         getSqlSmallInt(ARGS(6)),
                                         unboxSqlPointer(ARGS(7)),
                                         getSqlLen(ARGS(8)),
                                         unboxSqlLenPtr(ARGS(9)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLBrowseConnect
ODBC_EXT_FUNCTION(sqlBrowseConnect)
  Dart_Handle arg3 = ARGS(3);
  Dart_Handle arg5 = ARGS(5);

  SQLTCHAR* value3 = unboxSqlTChar(arg3);
  SQLSMALLINT value5 = unboxSqlSmallInt(arg5);

  SQLRETURN sqlReturn = SQLBrowseConnect(unboxSqlHandle(ARGS(0)),
                                         getSqlTChar(ARGS(1)),
                                         getSqlSmallInt(ARGS(2)),
                                         value3,
                                         getSqlSmallInt(ARGS(4)),
                                         Dart_IsNull(arg5) ? NULL : &value5);
  boxSqlTChar(arg3, value3);
  boxSqlSmallInt(arg5, value5);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLBulkOperations
ODBC_EXT_FUNCTION(sqlBulkOperations)
  SQLRETURN sqlReturn = SQLBulkOperations(unboxSqlHandle(ARGS(0)),
                                          getSqlSmallInt(ARGS(1)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLCancel
ODBC_EXT_FUNCTION(sqlCancel)
  SQLRETURN sqlReturn = SQLCancel(unboxSqlHandle(ARGS(0)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLCancelHandle
ODBC_EXT_FUNCTION(sqlCancelHandle)
  SQLRETURN sqlReturn = SQLCancelHandle(getSqlSmallInt(ARGS(0)),
                                        unboxSqlHandle(ARGS(1)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLCloseCursor
ODBC_EXT_FUNCTION(sqlCloseCursor)
  SQLRETURN sqlReturn = SQLCloseCursor(unboxSqlHandle(ARGS(0)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLColAttribute
ODBC_EXT_FUNCTION(sqlColAttribute)
  Dart_Handle arg3 = ARGS(3);
  Dart_Handle arg5 = ARGS(5);
  Dart_Handle arg6 = ARGS(6);

  SQLPOINTER value3 = unboxSqlTChar(arg3);
  SQLSMALLINT value5 = unboxSqlSmallInt(arg5);
  SQLLEN value6 = unboxSqlLen(arg6);

  SQLRETURN sqlReturn = SQLColAttribute(unboxSqlHandle(ARGS(0)),
                                        getSqlUSmallInt(ARGS(1)),
                                        getSqlUSmallInt(ARGS(2)),
                                        value3,
                                        getSqlSmallInt(ARGS(4)),
                                        Dart_IsNull(arg5) ? NULL : &value5,
                                        Dart_IsNull(arg6) ? NULL : &value6);
  boxSqlTChar(arg3, value3);
  boxSqlSmallInt(arg5, value5);
  boxSqlLen(arg6, value6);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLColAttributes
ODBC_EXT_FUNCTION(sqlColAttributes)
  Dart_Handle arg3 = ARGS(3);
  Dart_Handle arg5 = ARGS(5);
  Dart_Handle arg6 = ARGS(6);

  SQLPOINTER value3 = unboxSqlTChar(arg3);
  SQLSMALLINT value5 = unboxSqlSmallInt(arg5);
  SQLLEN value6 = unboxSqlLen(arg6);

  SQLRETURN sqlReturn = SQLColAttributes(unboxSqlHandle(ARGS(0)),
                                         getSqlUSmallInt(ARGS(1)),
                                         getSqlUSmallInt(ARGS(2)),
                                         value3,
                                         getSqlSmallInt(ARGS(4)),
                                         Dart_IsNull(arg5) ? NULL : &value5,
                                         Dart_IsNull(arg6) ? NULL : &value6);
  boxSqlTChar(arg3, value3);
  boxSqlSmallInt(arg5, value5);
  boxSqlLen(arg6, value6);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLColumnPrivileges
ODBC_EXT_FUNCTION(sqlColumnPrivileges)
  SQLRETURN sqlReturn = SQLColumnPrivileges(unboxSqlHandle(ARGS(0)),
                                            getSqlTChar(ARGS(1)),
                                            getSqlSmallInt(ARGS(2)),
                                            getSqlTChar(ARGS(3)),
                                            getSqlSmallInt(ARGS(4)),
                                            getSqlTChar(ARGS(5)),
                                            getSqlSmallInt(ARGS(6)),
                                            getSqlTChar(ARGS(7)),
                                            getSqlSmallInt(ARGS(8)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLColumns
ODBC_EXT_FUNCTION(sqlColumns)
  SQLRETURN sqlReturn = SQLColumns(unboxSqlHandle(ARGS(0)),
                                   getSqlTChar(ARGS(1)),
                                   getSqlSmallInt(ARGS(2)),
                                   getSqlTChar(ARGS(3)),
                                   getSqlSmallInt(ARGS(4)),
                                   getSqlTChar(ARGS(5)),
                                   getSqlSmallInt(ARGS(6)),
                                   getSqlTChar(ARGS(7)),
                                   getSqlSmallInt(ARGS(8)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLConnect
ODBC_EXT_FUNCTION(sqlConnect)
  SQLRETURN sqlReturn = SQLConnect(unboxSqlHandle(ARGS(0)),
                                   getSqlTChar(ARGS(1)),
                                   getSqlSmallInt(ARGS(2)),
                                   getSqlTChar(ARGS(3)),
                                   getSqlSmallInt(ARGS(4)),
                                   getSqlTChar(ARGS(5)),
                                   getSqlSmallInt(ARGS(6)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLCopyDesc
ODBC_EXT_FUNCTION(sqlCopyDesc)
  SQLRETURN sqlReturn = SQLCopyDesc(unboxSqlHandle(ARGS(0)),
                                    unboxSqlHandle(ARGS(1)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLDataSources
ODBC_EXT_FUNCTION(sqlDataSources)
  Dart_Handle arg2 = ARGS(2);
  Dart_Handle arg4 = ARGS(4);
  Dart_Handle arg5 = ARGS(5);
  Dart_Handle arg7 = ARGS(7);

  SQLTCHAR* value2 = unboxSqlTChar(arg2);
  SQLSMALLINT value4 = unboxSqlSmallInt(arg4);
  SQLTCHAR* value5 = unboxSqlTChar(arg5);
  SQLSMALLINT value7 = unboxSqlSmallInt(arg7);

  SQLRETURN sqlReturn = SQLDataSources(unboxSqlHandle(ARGS(0)),
                                       getSqlUSmallInt(ARGS(1)),
                                       value2,
                                       getSqlSmallInt(ARGS(3)),
                                       Dart_IsNull(arg4) ? NULL : &value4,
                                       value5,
                                       getSqlSmallInt(ARGS(6)),
                                       Dart_IsNull(arg7) ? NULL : &value7);
  boxSqlTChar(arg2, value2);
  boxSqlSmallInt(arg4, value4);
  boxSqlTChar(arg5, value5);
  boxSqlSmallInt(arg7, value7);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLDescribeCol
ODBC_EXT_FUNCTION(sqlDescribeCol)
  Dart_Handle arg2 = ARGS(2);
  Dart_Handle arg4 = ARGS(4);
  Dart_Handle arg5 = ARGS(5);
  Dart_Handle arg6 = ARGS(6);
  Dart_Handle arg7 = ARGS(7);
  Dart_Handle arg8 = ARGS(8);

  SQLTCHAR* value2 = unboxSqlTChar(arg2);
  SQLSMALLINT value4 = unboxSqlSmallInt(arg4);
  SQLSMALLINT value5 = unboxSqlSmallInt(arg5);
  SQLULEN value6 = unboxSqlULen(arg6);
  SQLSMALLINT value7 = unboxSqlSmallInt(arg7);
  SQLSMALLINT value8 = unboxSqlSmallInt(arg8);
  
  SQLRETURN sqlReturn = SQLDescribeCol(unboxSqlHandle(ARGS(0)),
                                       getSqlUSmallInt(ARGS(1)),
                                       value2,
                                       getSqlSmallInt(ARGS(3)),
                                       Dart_IsNull(arg4) ? NULL : &value4,
                                       Dart_IsNull(arg5) ? NULL : &value5,
                                       Dart_IsNull(arg6) ? NULL : &value6,
                                       Dart_IsNull(arg7) ? NULL : &value7,
                                       Dart_IsNull(arg8) ? NULL : &value8);
  boxSqlTChar(arg2, value2);
  boxSqlSmallInt(arg4, value4);
  boxSqlSmallInt(arg5, value5);
  boxSqlULen(arg6, value6);
  boxSqlSmallInt(arg7, value7);
  boxSqlSmallInt(arg8, value8);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLDescribeParam
ODBC_EXT_FUNCTION(sqlDescribeParam)
  Dart_Handle arg2 = ARGS(2);
  Dart_Handle arg3 = ARGS(3);
  Dart_Handle arg4 = ARGS(4);
  Dart_Handle arg5 = ARGS(5);

  SQLSMALLINT value2 = unboxSqlSmallInt(arg2);
  SQLULEN value3 = unboxSqlULen(arg3);
  SQLSMALLINT value4 = unboxSqlSmallInt(arg4);
  SQLSMALLINT value5 = unboxSqlSmallInt(arg5);
  
  SQLRETURN sqlReturn = SQLDescribeParam(unboxSqlHandle(ARGS(0)),
                                         getSqlUSmallInt(ARGS(1)),
                                         Dart_IsNull(arg2) ? NULL : &value2,
                                         Dart_IsNull(arg3) ? NULL : &value3,
                                         Dart_IsNull(arg4) ? NULL : &value4,
                                         Dart_IsNull(arg5) ? NULL : &value5);
  boxSqlSmallInt(arg2, value2);
  boxSqlULen(arg3, value3);
  boxSqlSmallInt(arg4, value4);
  boxSqlSmallInt(arg5, value5);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLDisconnect
ODBC_EXT_FUNCTION(sqlDisconnect)
  SQLRETURN sqlReturn = SQLDisconnect(unboxSqlHandle(ARGS(0)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLDriverConnect
ODBC_EXT_FUNCTION(sqlDriverConnect)
  Dart_Handle arg4 = ARGS(4);
  Dart_Handle arg6 = ARGS(6);

  SQLTCHAR* value4 = unboxSqlTChar(arg4);
  SQLSMALLINT value6 = unboxSqlSmallInt(arg6);

  SQLRETURN sqlReturn = SQLDriverConnect(unboxSqlHandle(ARGS(0)),
                                         unboxSqlHWnd(ARGS(1)),
                                         getSqlTChar(ARGS(2)),
                                         getSqlSmallInt(ARGS(3)),
                                         value4,
                                         getSqlSmallInt(ARGS(5)),
                                         Dart_IsNull(arg6) ? NULL : &value6,
                                         getSqlUSmallInt(ARGS(7)));
  boxSqlTChar(arg4, value4);
  boxSqlSmallInt(arg6, value6);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLDrivers
ODBC_EXT_FUNCTION(sqlDrivers)
  Dart_Handle arg2 = ARGS(2);
  Dart_Handle arg4 = ARGS(4);
  Dart_Handle arg5 = ARGS(5);
  Dart_Handle arg7 = ARGS(7);

  SQLTCHAR* value2 = unboxSqlTChar(arg2);
  SQLSMALLINT value4 = unboxSqlSmallInt(arg4);
  SQLTCHAR* value5 = unboxSqlTChar(arg5);
  SQLSMALLINT value7 = unboxSqlSmallInt(arg7);

  SQLRETURN sqlReturn = SQLDrivers(unboxSqlHandle(ARGS(0)),
                                   getSqlUSmallInt(ARGS(1)),
                                   value2,
                                   getSqlSmallInt(ARGS(3)),
                                   Dart_IsNull(arg4) ? NULL : &value4,
                                   value5,
                                   getSqlSmallInt(ARGS(6)),
                                   Dart_IsNull(arg7) ? NULL : &value7);
  boxSqlTChar(arg2, value2);
  boxSqlSmallInt(arg4, value4);
  boxSqlTChar(arg5, value5);
  boxSqlSmallInt(arg7, value7);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLEndTran
ODBC_EXT_FUNCTION(sqlEndTran)
  SQLRETURN sqlReturn = SQLEndTran(getSqlSmallInt(ARGS(0)),
                                   unboxSqlHandle(ARGS(1)),
                                   getSqlSmallInt(ARGS(2)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLError
ODBC_EXT_FUNCTION(sqlError)
  Dart_Handle arg3 = ARGS(3);
  Dart_Handle arg4 = ARGS(4);
  Dart_Handle arg5 = ARGS(5);
  Dart_Handle arg7 = ARGS(7);

  SQLTCHAR* value3 = unboxSqlTChar(arg3);
  SQLINTEGER value4 = unboxSqlInteger(arg4);
  SQLTCHAR* value5 = unboxSqlTChar(arg5);
  SQLSMALLINT value7 = unboxSqlSmallInt(arg7);

  SQLRETURN sqlReturn = SQLError(unboxSqlHandle(ARGS(0)),
                                 unboxSqlHandle(ARGS(1)),
                                 unboxSqlHandle(ARGS(2)),
                                 value3,
                                 Dart_IsNull(arg4) ? NULL : &value4,
                                 value5,
                                 getSqlSmallInt(ARGS(6)),
                                 Dart_IsNull(arg7) ? NULL : &value7);
  boxSqlTChar(arg3, value3);
  boxSqlInteger(arg4, value4);
  boxSqlTChar(arg5, value5);
  boxSqlSmallInt(arg7, value7);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLExecDirect
ODBC_EXT_FUNCTION(sqlExecDirect)
  SQLRETURN sqlReturn = SQLExecDirect(unboxSqlHandle(ARGS(0)),
                                      getSqlTChar(ARGS(1)),
                                      getSqlInteger(ARGS(2)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLExecute
ODBC_EXT_FUNCTION(sqlExecute)
  SQLRETURN sqlReturn = SQLExecute(unboxSqlHandle(ARGS(0)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLExtendedFetch
ODBC_EXT_FUNCTION(sqlExtendedFetch)
  SQLRETURN sqlReturn = SQLExtendedFetch(unboxSqlHandle(ARGS(0)),
                                         getSqlUSmallInt(ARGS(1)),
                                         getSqlLen(ARGS(2)),
                                         unboxSqlULenPtr(ARGS(3)),
                                         unboxSqlUSmallIntPtr(ARGS(4)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLFetch
ODBC_EXT_FUNCTION(sqlFetch)
  SQLRETURN sqlReturn = SQLFetch(unboxSqlHandle(ARGS(0)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLFetchScroll
ODBC_EXT_FUNCTION(sqlFetchScroll)
  SQLRETURN sqlReturn = SQLFetchScroll(unboxSqlHandle(ARGS(0)),
                                       getSqlSmallInt(ARGS(1)),
                                       getSqlLen(ARGS(2)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLForeignKeys
ODBC_EXT_FUNCTION(sqlForeignKeys)
  SQLRETURN sqlReturn = SQLForeignKeys(unboxSqlHandle(ARGS(0)),
                                       getSqlTChar(ARGS(1)),
                                       getSqlSmallInt(ARGS(2)),
                                       getSqlTChar(ARGS(3)),
                                       getSqlSmallInt(ARGS(4)),
                                       getSqlTChar(ARGS(5)),
                                       getSqlSmallInt(ARGS(6)),
                                       getSqlTChar(ARGS(7)),
                                       getSqlSmallInt(ARGS(8)),
                                       getSqlTChar(ARGS(9)),
                                       getSqlSmallInt(ARGS(10)),
                                       getSqlTChar(ARGS(11)),
                                       getSqlSmallInt(ARGS(12)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLFreeConnect
ODBC_EXT_FUNCTION(sqlFreeConnect)
  SQLRETURN sqlReturn = SQLFreeConnect(unboxSqlHandle(ARGS(0)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLFreeEnv
ODBC_EXT_FUNCTION(sqlFreeEnv)
  SQLRETURN sqlReturn = SQLFreeEnv(unboxSqlHandle(ARGS(0)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLFreeHandle
ODBC_EXT_FUNCTION(sqlFreeHandle)
  SQLRETURN sqlReturn = SQLFreeHandle(getSqlSmallInt(ARGS(0)),
                                      unboxSqlHandle(ARGS(1)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLFreeStmt
ODBC_EXT_FUNCTION(sqlFreeStmt)
  SQLRETURN sqlReturn = SQLFreeStmt(unboxSqlHandle(ARGS(0)),
                                    getSqlUSmallInt(ARGS(1)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLGetConnectAttr
ODBC_EXT_FUNCTION(sqlGetConnectAttr)
  Dart_Handle arg2 = ARGS(2);
  Dart_Handle arg4 = ARGS(4);

  SQLPOINTER value2 = unboxSqlBoxPtr(arg2);
  SQLINTEGER value4 = unboxSqlInteger(arg4);

  SQLRETURN sqlReturn = SQLGetConnectAttr(unboxSqlHandle(ARGS(0)),
                                          getSqlInteger(ARGS(1)),
                                          value2,
                                          getSqlInteger(ARGS(3)),
                                          Dart_IsNull(arg4) ? NULL : &value4);
  boxSqlBoxPtr(arg2, value2);
  boxSqlInteger(arg4, value4);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLGetConnectOption
ODBC_EXT_FUNCTION(sqlGetConnectOption)
  Dart_Handle arg2 = ARGS(2);
  SQLPOINTER value2 = unboxSqlBoxPtr(arg2);

  SQLRETURN sqlReturn = SQLGetConnectOption(unboxSqlHandle(ARGS(0)),
                                            getSqlUSmallInt(ARGS(1)),
                                            value2);
  boxSqlBoxPtr(arg2, value2);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLGetCursorName
ODBC_EXT_FUNCTION(sqlGetCursorName)
  Dart_Handle arg1 = ARGS(1);
  Dart_Handle arg3 = ARGS(3);

  SQLTCHAR* value1 = unboxSqlTChar(arg1);
  SQLSMALLINT value3 = unboxSqlSmallInt(arg3);

  SQLRETURN sqlReturn = SQLGetCursorName(unboxSqlHandle(ARGS(0)),
                                         value1,
                                         getSqlSmallInt(ARGS(2)),
                                         Dart_IsNull(arg3) ? NULL : &value3);
  boxSqlTChar(arg1, value1);
  boxSqlSmallInt(arg3, value3);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLGetData
ODBC_EXT_FUNCTION(sqlGetData)
  Dart_Handle arg3 = ARGS(3);
  Dart_Handle arg5 = ARGS(5);

  SQLPOINTER value3 = unboxSqlBoxPtr(arg3);
  SQLLEN value5 = unboxSqlLen(arg5);

  SQLRETURN sqlReturn = SQLGetData(unboxSqlHandle(ARGS(0)),
                                   getSqlUSmallInt(ARGS(1)),
                                   getSqlSmallInt(ARGS(2)),
                                   value3,
                                   getSqlLen(ARGS(4)),
                                   Dart_IsNull(arg5) ? NULL : &value5);
  boxSqlBoxPtr(arg3, value3);
  boxSqlLen(arg5, value5);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLGetDescField
ODBC_EXT_FUNCTION(sqlGetDescField)
  Dart_Handle arg3 = ARGS(3);
  Dart_Handle arg5 = ARGS(5);

  SQLPOINTER value3 = unboxSqlBoxPtr(arg3);
  SQLINTEGER value5 = unboxSqlInteger(arg5);

  SQLRETURN sqlReturn = SQLGetDescField(unboxSqlHandle(ARGS(0)),
                                        getSqlSmallInt(ARGS(1)),
                                        getSqlSmallInt(ARGS(2)),
                                        value3,
                                        getSqlInteger(ARGS(4)),
                                        Dart_IsNull(arg5) ? NULL : &value5);
  boxSqlBoxPtr(arg3, value3);
  boxSqlInteger(arg5, value5);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLGetDescRec
ODBC_EXT_FUNCTION(sqlGetDescRec)
  Dart_Handle arg2 = ARGS(2);
  Dart_Handle arg4 = ARGS(4);
  Dart_Handle arg5 = ARGS(5);
  Dart_Handle arg6 = ARGS(6);
  Dart_Handle arg7 = ARGS(7);
  Dart_Handle arg8 = ARGS(8);
  Dart_Handle arg9 = ARGS(9);
  Dart_Handle arg10 = ARGS(10);

  SQLTCHAR* value2 = unboxSqlTChar(arg2);
  SQLSMALLINT value4 = unboxSqlSmallInt(arg4);
  SQLSMALLINT value5 = unboxSqlSmallInt(arg5);
  SQLSMALLINT value6 = unboxSqlSmallInt(arg6);
  SQLLEN value7 = unboxSqlLen(arg7);
  SQLSMALLINT value8 = unboxSqlSmallInt(arg8);
  SQLSMALLINT value9 = unboxSqlSmallInt(arg9);
  SQLSMALLINT value10 = unboxSqlSmallInt(arg10);

  SQLRETURN sqlReturn = SQLGetDescRec(unboxSqlHandle(ARGS(0)),
                                      getSqlSmallInt(ARGS(1)),
                                      value2,
                                      getSqlSmallInt(ARGS(3)),
                                      Dart_IsNull(arg4) ? NULL : &value4,
                                      Dart_IsNull(arg5) ? NULL : &value5,
                                      Dart_IsNull(arg6) ? NULL : &value6,
                                      Dart_IsNull(arg7) ? NULL : &value7,
                                      Dart_IsNull(arg8) ? NULL : &value8,
                                      Dart_IsNull(arg9) ? NULL : &value9,
                                      Dart_IsNull(arg10) ? NULL : &value10);
  boxSqlTChar(arg2, value2);
  boxSqlSmallInt(arg4, value4);
  boxSqlSmallInt(arg5, value5);
  boxSqlSmallInt(arg6, value6);
  boxSqlLen(arg7, value7);
  boxSqlSmallInt(arg8, value8);
  boxSqlSmallInt(arg9, value9);
  boxSqlSmallInt(arg10, value10);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLGetDiagField
ODBC_EXT_FUNCTION(sqlGetDiagField)
  Dart_Handle arg4 = ARGS(4);
  Dart_Handle arg6 = ARGS(6);

  SQLPOINTER value4 = unboxSqlBoxPtr(arg4);
  SQLSMALLINT value6 = unboxSqlSmallInt(arg6);

  SQLRETURN sqlReturn = SQLGetDiagField(getSqlSmallInt(ARGS(0)),
                                        unboxSqlHandle(ARGS(1)),
                                        getSqlSmallInt(ARGS(2)),
                                        getSqlSmallInt(ARGS(3)),
                                        value4,
                                        getSqlSmallInt(ARGS(5)),
                                        Dart_IsNull(arg6) ? NULL : &value6);
  boxSqlBoxPtr(arg4, value4);
  boxSqlSmallInt(arg6, value6);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLGetDiagRec
ODBC_EXT_FUNCTION(sqlGetDiagRec)
  Dart_Handle arg3 = ARGS(3);
  Dart_Handle arg4 = ARGS(4);
  Dart_Handle arg5 = ARGS(5);
  Dart_Handle arg7 = ARGS(7);

  SQLTCHAR* value3 = unboxSqlTChar(arg3);
  SQLINTEGER value4 = unboxSqlInteger(arg4);
  SQLTCHAR* value5 = unboxSqlTChar(arg5);
  SQLSMALLINT value7 = unboxSqlSmallInt(arg7);

  SQLRETURN sqlReturn = SQLGetDiagRec(getSqlSmallInt(ARGS(0)),
                                      unboxSqlHandle(ARGS(1)),
                                      getSqlSmallInt(ARGS(2)),
                                      value3,
                                      Dart_IsNull(arg4) ? NULL : &value4,
                                      value5,
                                      getSqlSmallInt(ARGS(6)),
                                      Dart_IsNull(arg7) ? NULL : &value7);
  boxSqlTChar(arg3, value3);
  boxSqlInteger(arg4, value4);
  boxSqlTChar(arg5, value5);
  boxSqlSmallInt(arg7, value7);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLGetEnvAttr
ODBC_EXT_FUNCTION(sqlGetEnvAttr)
  Dart_Handle arg2 = ARGS(2);
  Dart_Handle arg4 = ARGS(4);

  SQLPOINTER value2 = unboxSqlBoxPtr(arg2);
  SQLINTEGER value4 = unboxSqlInteger(arg4);

  SQLRETURN sqlReturn = SQLGetEnvAttr(unboxSqlHandle(ARGS(0)),
                                      getSqlInteger(ARGS(1)),
                                      value2,
                                      getSqlInteger(ARGS(3)),
                                      Dart_IsNull(arg4) ? NULL : &value4);
  boxSqlBoxPtr(arg2, value2);
  boxSqlInteger(arg4, value4);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLGetFunctions
ODBC_EXT_FUNCTION(sqlGetFunctions)
  SQLRETURN sqlReturn = SQLGetFunctions(unboxSqlHandle(ARGS(0)),
                                        getSqlUSmallInt(ARGS(1)),
                                        unboxSqlUSmallIntPtr(ARGS(2)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLGetInfo
ODBC_EXT_FUNCTION(sqlGetInfo)
  Dart_Handle arg2 = ARGS(2);
  Dart_Handle arg4 = ARGS(4);

  SQLPOINTER value2 = unboxSqlBoxPtr(arg2);
  SQLSMALLINT value4 = unboxSqlSmallInt(arg4);

  SQLRETURN sqlReturn = SQLGetInfo(unboxSqlHandle(ARGS(0)),
                                   getSqlUSmallInt(ARGS(1)),
                                   value2,
                                   getSqlSmallInt(ARGS(3)),
                                   Dart_IsNull(arg4) ? NULL : &value4);
  boxSqlBoxPtr(arg2, value2);
  boxSqlSmallInt(arg4, value4);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLGetStmtAttr
ODBC_EXT_FUNCTION(sqlGetStmtAttr)
  Dart_Handle arg2 = ARGS(2);
  Dart_Handle arg4 = ARGS(4);

  SQLPOINTER value2 = unboxSqlBoxPtr(arg2);
  SQLINTEGER value4 = unboxSqlInteger(arg4);

  SQLRETURN sqlReturn = SQLGetStmtAttr(unboxSqlHandle(ARGS(0)),
                                       getSqlInteger(ARGS(1)),
                                       value2,
                                       getSqlInteger(ARGS(3)),
                                       Dart_IsNull(arg4) ? NULL : &value4);
  boxSqlBoxPtr(arg2, value2);
  boxSqlInteger(arg4, value4);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLGetStmtOption
ODBC_EXT_FUNCTION(sqlGetStmtOption)
  Dart_Handle arg2 = ARGS(2);
  SQLPOINTER value2 = unboxSqlBoxPtr(arg2);

  SQLRETURN sqlReturn = SQLGetStmtOption(unboxSqlHandle(ARGS(0)),
                                         getSqlUSmallInt(ARGS(1)),
                                         value2);
  boxSqlBoxPtr(arg2, value2);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLGetTypeInfo
ODBC_EXT_FUNCTION(sqlGetTypeInfo)
  SQLRETURN sqlReturn = SQLGetTypeInfo(unboxSqlHandle(ARGS(0)),
                                       getSqlSmallInt(ARGS(1)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLMoreResults
ODBC_EXT_FUNCTION(sqlMoreResults)
  SQLRETURN sqlReturn = SQLMoreResults(unboxSqlHandle(ARGS(0)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLNativeSql
ODBC_EXT_FUNCTION(sqlNativeSql)
  Dart_Handle arg3 = ARGS(3);
  Dart_Handle arg5 = ARGS(5);

  SQLTCHAR* value3 = unboxSqlTChar(arg3);
  SQLINTEGER value5 = unboxSqlInteger(arg5);

  SQLRETURN sqlReturn = SQLNativeSql(unboxSqlHandle(ARGS(0)),
                                     getSqlTChar(ARGS(1)),
                                     getSqlInteger(ARGS(2)),
                                     value3,
                                     getSqlInteger(ARGS(4)),
                                     Dart_IsNull(arg5) ? NULL : &value5);
  boxSqlTChar(arg3, value3);
  boxSqlInteger(arg5, value5);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLNumParams
ODBC_EXT_FUNCTION(sqlNumParams)
  Dart_Handle arg1 = ARGS(1);
  SQLSMALLINT value1 = unboxSqlSmallInt(arg1);

  SQLRETURN sqlReturn = SQLNumParams(unboxSqlHandle(ARGS(0)),
                                     Dart_IsNull(arg1) ? NULL : &value1);
  boxSqlSmallInt(arg1, value1);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLNumResultCols
ODBC_EXT_FUNCTION(sqlNumResultCols)
  Dart_Handle arg1 = ARGS(1);
  SQLSMALLINT value1 = unboxSqlSmallInt(arg1);

  SQLRETURN sqlReturn = SQLNumResultCols(unboxSqlHandle(ARGS(0)),
                                         Dart_IsNull(arg1) ? NULL : &value1);
  boxSqlSmallInt(arg1, value1);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLParamData
ODBC_EXT_FUNCTION(sqlParamData)
  Dart_Handle arg1 = ARGS(1);
  SQLPOINTER value1 = unboxSqlPointer(arg1);

  SQLRETURN sqlReturn = SQLParamData(unboxSqlHandle(ARGS(0)),
                                     Dart_IsNull(arg1) ? NULL : &value1);
  boxSqlPointer(arg1, value1);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLParamOptions
ODBC_EXT_FUNCTION(sqlParamOptions)
  SQLRETURN sqlReturn = SQLParamOptions(unboxSqlHandle(ARGS(0)),
                                        getSqlULen(ARGS(1)),
                                        unboxSqlULenPtr(ARGS(2)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLPrepare
ODBC_EXT_FUNCTION(sqlPrepare)
  SQLRETURN sqlReturn = SQLPrepare(unboxSqlHandle(ARGS(0)),
                                   getSqlTChar(ARGS(1)),
                                   getSqlInteger(ARGS(2)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLPrimaryKeys
ODBC_EXT_FUNCTION(sqlPrimaryKeys)
  SQLRETURN sqlReturn = SQLPrimaryKeys(unboxSqlHandle(ARGS(0)),
                                       getSqlTChar(ARGS(1)),
                                       getSqlSmallInt(ARGS(2)),
                                       getSqlTChar(ARGS(3)),
                                       getSqlSmallInt(ARGS(4)),
                                       getSqlTChar(ARGS(5)),
                                       getSqlSmallInt(ARGS(6)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLProcedureColumns
ODBC_EXT_FUNCTION(sqlProcedureColumns)
  SQLRETURN sqlReturn = SQLProcedureColumns(unboxSqlHandle(ARGS(0)),
                                            getSqlTChar(ARGS(1)),
                                            getSqlSmallInt(ARGS(2)),
                                            getSqlTChar(ARGS(3)),
                                            getSqlSmallInt(ARGS(4)),
                                            getSqlTChar(ARGS(5)),
                                            getSqlSmallInt(ARGS(6)),
                                            getSqlTChar(ARGS(7)),
                                            getSqlSmallInt(ARGS(8)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLProcedures
ODBC_EXT_FUNCTION(sqlProcedures)
  SQLRETURN sqlReturn = SQLProcedures(unboxSqlHandle(ARGS(0)),
                                      getSqlTChar(ARGS(1)),
                                      getSqlSmallInt(ARGS(2)),
                                      getSqlTChar(ARGS(3)),
                                      getSqlSmallInt(ARGS(4)),
                                      getSqlTChar(ARGS(5)),
                                      getSqlSmallInt(ARGS(6)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLPutData
ODBC_EXT_FUNCTION(sqlPutData)
  SQLRETURN sqlReturn = SQLPutData(unboxSqlHandle(ARGS(0)),
                                   unboxSqlPointer(ARGS(1)),
                                   getSqlLen(ARGS(2)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLRowCount
ODBC_EXT_FUNCTION(sqlRowCount)
  Dart_Handle arg1 = ARGS(1);
  SQLLEN value1 = unboxSqlLen(arg1);

  SQLRETURN sqlReturn = SQLRowCount(unboxSqlHandle(ARGS(0)),
                                    Dart_IsNull(arg1) ? NULL : &value1);
  boxSqlLen(arg1, value1);
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLSetConnectAttr
ODBC_EXT_FUNCTION(sqlSetConnectAttr)
  SQLRETURN sqlReturn = SQLSetConnectAttr(unboxSqlHandle(ARGS(0)),
                                          getSqlInteger(ARGS(1)),
                                          unboxSqlPointer(ARGS(2)),
                                          getSqlInteger(ARGS(3)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLSetConnectOption
ODBC_EXT_FUNCTION(sqlSetConnectOption)
  SQLRETURN sqlReturn = SQLSetConnectOption(unboxSqlHandle(ARGS(0)),
                                            getSqlUSmallInt(ARGS(1)),
                                            (SQLULEN)unboxSqlPointer(ARGS(2)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLSetCursorName
ODBC_EXT_FUNCTION(sqlSetCursorName)
  SQLRETURN sqlReturn = SQLSetCursorName(unboxSqlHandle(ARGS(0)),
                                         getSqlTChar(ARGS(1)),
                                         getSqlSmallInt(ARGS(2)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLSetDescField
ODBC_EXT_FUNCTION(sqlSetDescField)
  SQLRETURN sqlReturn = SQLSetDescField(unboxSqlHandle(ARGS(0)),
                                        getSqlSmallInt(ARGS(1)),
                                        getSqlSmallInt(ARGS(2)),
                                        unboxSqlPointer(ARGS(3)),
                                        getSqlInteger(ARGS(4)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLSetDescRec
ODBC_EXT_FUNCTION(sqlSetDescRec)
  SQLRETURN sqlReturn = SQLSetDescRec(unboxSqlHandle(ARGS(0)),
                                      getSqlSmallInt(ARGS(1)),
                                      getSqlSmallInt(ARGS(2)),
                                      getSqlSmallInt(ARGS(3)),
                                      getSqlLen(ARGS(4)),
                                      getSqlSmallInt(ARGS(5)),
                                      getSqlSmallInt(ARGS(6)),
                                      unboxSqlPointer(ARGS(7)),
                                      unboxSqlLenPtr(ARGS(8)),
                                      unboxSqlLenPtr(ARGS(9)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLSetEnvAttr
ODBC_EXT_FUNCTION(sqlSetEnvAttr)
  SQLRETURN sqlReturn = SQLSetEnvAttr(unboxSqlHandle(ARGS(0)),
                                      getSqlInteger(ARGS(1)),
                                      unboxSqlPointer(ARGS(2)),
                                      getSqlInteger(ARGS(3)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLSetParam
ODBC_EXT_FUNCTION(sqlSetParam)
  SQLRETURN sqlReturn = SQLSetParam(unboxSqlHandle(ARGS(0)),
                                    getSqlUSmallInt(ARGS(1)),
                                    getSqlSmallInt(ARGS(2)),
                                    getSqlSmallInt(ARGS(3)),
                                    getSqlUInteger(ARGS(4)),
                                    getSqlSmallInt(ARGS(5)),
                                    unboxSqlPointer(ARGS(6)),
                                    unboxSqlIntegerPtr(ARGS(7)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLSetPos
ODBC_EXT_FUNCTION(sqlSetPos)
  SQLRETURN sqlReturn = SQLSetPos(unboxSqlHandle(ARGS(0)),
                                  getSqlSetPosIRow(ARGS(1)),
                                  getSqlUSmallInt(ARGS(2)),
                                  getSqlUSmallInt(ARGS(3)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLSetScrollOptions
ODBC_EXT_FUNCTION(sqlSetScrollOptions)
  SQLRETURN sqlReturn = SQLSetScrollOptions(unboxSqlHandle(ARGS(0)),
                                            getSqlUSmallInt(ARGS(1)),
                                            getSqlInteger(ARGS(2)),
                                            getSqlUSmallInt(ARGS(3)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLSetStmtAttr
ODBC_EXT_FUNCTION(sqlSetStmtAttr)
  SQLRETURN sqlReturn = SQLSetStmtAttr(unboxSqlHandle(ARGS(0)),
                                       getSqlInteger(ARGS(1)),
                                       unboxSqlPointer(ARGS(2)),
                                       getSqlInteger(ARGS(3)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLSetStmtOption
ODBC_EXT_FUNCTION(sqlSetStmtOption)
  SQLRETURN sqlReturn = SQLSetStmtOption(unboxSqlHandle(ARGS(0)),
                                         getSqlUSmallInt(ARGS(1)),
                                         (SQLULEN)unboxSqlPointer(ARGS(2)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLSpecialColumns
ODBC_EXT_FUNCTION(sqlSpecialColumns)
  SQLRETURN sqlReturn = SQLSpecialColumns(unboxSqlHandle(ARGS(0)),
                                          getSqlUSmallInt(ARGS(1)),
                                          getSqlTChar(ARGS(2)),
                                          getSqlSmallInt(ARGS(3)),
                                          getSqlTChar(ARGS(4)),
                                          getSqlSmallInt(ARGS(5)),
                                          getSqlTChar(ARGS(6)),
                                          getSqlSmallInt(ARGS(7)),
                                          getSqlUSmallInt(ARGS(8)),
                                          getSqlUSmallInt(ARGS(9)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLStatistics
ODBC_EXT_FUNCTION(sqlStatistics)
  SQLRETURN sqlReturn = SQLStatistics(unboxSqlHandle(ARGS(0)),
                                      getSqlTChar(ARGS(1)),
                                      getSqlSmallInt(ARGS(2)),
                                      getSqlTChar(ARGS(3)),
                                      getSqlSmallInt(ARGS(4)),
                                      getSqlTChar(ARGS(5)),
                                      getSqlSmallInt(ARGS(6)),
                                      getSqlUSmallInt(ARGS(7)),
                                      getSqlUSmallInt(ARGS(8)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLTablePrivileges
ODBC_EXT_FUNCTION(sqlTablePrivileges)
  SQLRETURN sqlReturn = SQLTablePrivileges(unboxSqlHandle(ARGS(0)),
                                           getSqlTChar(ARGS(1)),
                                           getSqlSmallInt(ARGS(2)),
                                           getSqlTChar(ARGS(3)),
                                           getSqlSmallInt(ARGS(4)),
                                           getSqlTChar(ARGS(5)),
                                           getSqlSmallInt(ARGS(6)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLTables
ODBC_EXT_FUNCTION(sqlTables)
  SQLRETURN sqlReturn = SQLTables(unboxSqlHandle(ARGS(0)),
                                  getSqlTChar(ARGS(1)),
                                  getSqlSmallInt(ARGS(2)),
                                  getSqlTChar(ARGS(3)),
                                  getSqlSmallInt(ARGS(4)),
                                  getSqlTChar(ARGS(5)),
                                  getSqlSmallInt(ARGS(6)),
                                  getSqlTChar(ARGS(7)),
                                  getSqlSmallInt(ARGS(8)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLTransact
ODBC_EXT_FUNCTION(sqlTransact)
  SQLRETURN sqlReturn = SQLTransact(unboxSqlHandle(ARGS(0)),
                                    unboxSqlHandle(ARGS(1)),
                                    getSqlUSmallInt(ARGS(2)));
ODBC_EXT_SQLRETURN(sqlReturn)

//SQLAllocate
ODBC_EXT_FUNCTION(sqlAllocate)
  Dart_Handle container = ARGS(0);

  intptr_t size = rowSize(container) * UNBOX_ROWS(container);
  uint8_t* peer = allocate(size);
  Dart_Handle buffer = Dart_NewExternalTypedData(Dart_TypedData_kUint8, peer, size);
  Dart_NewWeakPersistentHandle(buffer, peer, finalizerCallback);

  BOX_BUFFER(container, buffer);
ODBC_EXT_RETURN

//SQLPoke
ODBC_EXT_FUNCTION(sqlPoke)
  Dart_Handle container = ARGS(0);
  int64_t row = getInteger(ARGS(1));
  int64_t col = getInteger(ARGS(2));
  Dart_Handle value = ARGS(3);

  int64_t ctype = 0;
  intptr_t length = 0;
  void* peer = address(container, row, col, ctype, length);

  poke(peer, value, ctype, length);
ODBC_EXT_RETURN

//SQLPeek
ODBC_EXT_FUNCTION(sqlPeek)
  Dart_Handle container = ARGS(0);
  int64_t row = getInteger(ARGS(1));
  int64_t col = getInteger(ARGS(2));

  int64_t ctype = 0;
  intptr_t length = 0;
  void* peer = address(container, row, col, ctype, length);

  Dart_Handle object = peek(peer, ctype, length);
ODBC_EXT_RETURN_VALUE(object)

//SQLlAddress
ODBC_EXT_FUNCTION(sqlAddress)
  Dart_Handle container = ARGS(0);
  int64_t row = getInteger(ARGS(1));
  int64_t col = getInteger(ARGS(2));

  int64_t ctype = 0;
  intptr_t length = 0;
  void* peer = address(container, row, col, ctype, length);

  Dart_Handle object = Dart_NewInteger((int64_t)peer);
ODBC_EXT_RETURN_VALUE(object)

//SQLRowSize
ODBC_EXT_FUNCTION(sqlRowSize)
  Dart_Handle object = Dart_NewInteger(rowSize(ARGS(0)));
ODBC_EXT_RETURN_VALUE(object);

//
// Native resolver.
//
#define ODBC_EXT_LOOKUP(fn, args) \
  if ((strcmp(cname, #fn) == 0) && (argc == args)) { return fn; }

Dart_NativeFunction odbcResolver(Dart_Handle name, int argc) {
  const char* cname;
  Dart_StringToCString(name, &cname);

  ODBC_EXT_LOOKUP(sqlAllocConnect, 2)
  ODBC_EXT_LOOKUP(sqlAllocEnv, 1)
  ODBC_EXT_LOOKUP(sqlAllocHandle, 3)
  ODBC_EXT_LOOKUP(sqlAllocStmt, 2)
  ODBC_EXT_LOOKUP(sqlBindCol, 6)
  ODBC_EXT_LOOKUP(sqlBindParameter, 10)
  ODBC_EXT_LOOKUP(sqlBrowseConnect, 6)
  ODBC_EXT_LOOKUP(sqlBulkOperations, 2)
  ODBC_EXT_LOOKUP(sqlCancel, 1)
  ODBC_EXT_LOOKUP(sqlCancelHandle, 2)
  ODBC_EXT_LOOKUP(sqlCloseCursor, 1)
  ODBC_EXT_LOOKUP(sqlColAttribute, 7)
  ODBC_EXT_LOOKUP(sqlColAttributes, 7)
  ODBC_EXT_LOOKUP(sqlColumnPrivileges, 9)
  ODBC_EXT_LOOKUP(sqlColumns, 9)
  ODBC_EXT_LOOKUP(sqlConnect, 7)
  ODBC_EXT_LOOKUP(sqlCopyDesc, 2)
  ODBC_EXT_LOOKUP(sqlDataSources, 8)
  ODBC_EXT_LOOKUP(sqlDescribeCol, 9)
  ODBC_EXT_LOOKUP(sqlDescribeParam, 6)
  ODBC_EXT_LOOKUP(sqlDisconnect, 1)
  ODBC_EXT_LOOKUP(sqlDriverConnect, 8)
  ODBC_EXT_LOOKUP(sqlDrivers, 8)
  ODBC_EXT_LOOKUP(sqlEndTran, 3)
  ODBC_EXT_LOOKUP(sqlError, 8)
  ODBC_EXT_LOOKUP(sqlExecDirect, 3)
  ODBC_EXT_LOOKUP(sqlExecute, 1)
  ODBC_EXT_LOOKUP(sqlExtendedFetch, 5)
  ODBC_EXT_LOOKUP(sqlFetch, 1)
  ODBC_EXT_LOOKUP(sqlFetchScroll, 3)
  ODBC_EXT_LOOKUP(sqlForeignKeys, 13)
  ODBC_EXT_LOOKUP(sqlFreeConnect, 1)
  ODBC_EXT_LOOKUP(sqlFreeEnv, 1)
  ODBC_EXT_LOOKUP(sqlFreeHandle, 2)
  ODBC_EXT_LOOKUP(sqlFreeStmt, 2)
  ODBC_EXT_LOOKUP(sqlGetConnectAttr, 5)
  ODBC_EXT_LOOKUP(sqlGetConnectOption, 3)
  ODBC_EXT_LOOKUP(sqlGetCursorName, 4)
  ODBC_EXT_LOOKUP(sqlGetData, 6)
  ODBC_EXT_LOOKUP(sqlGetDescField, 6)
  ODBC_EXT_LOOKUP(sqlGetDescRec, 11)
  ODBC_EXT_LOOKUP(sqlGetDiagField, 7)
  ODBC_EXT_LOOKUP(sqlGetDiagRec, 8)
  ODBC_EXT_LOOKUP(sqlGetEnvAttr, 5)
  ODBC_EXT_LOOKUP(sqlGetFunctions, 3)
  ODBC_EXT_LOOKUP(sqlGetInfo, 5)
  ODBC_EXT_LOOKUP(sqlGetStmtAttr, 5)
  ODBC_EXT_LOOKUP(sqlGetStmtOption, 3)
  ODBC_EXT_LOOKUP(sqlGetTypeInfo, 2)
  ODBC_EXT_LOOKUP(sqlMoreResults, 1)
  ODBC_EXT_LOOKUP(sqlNativeSql, 6)
  ODBC_EXT_LOOKUP(sqlNumParams, 2)
  ODBC_EXT_LOOKUP(sqlNumResultCols, 2)
  ODBC_EXT_LOOKUP(sqlParamData, 2)
  ODBC_EXT_LOOKUP(sqlParamOptions, 3)
  ODBC_EXT_LOOKUP(sqlPrepare, 3)
  ODBC_EXT_LOOKUP(sqlPrimaryKeys, 7)
  ODBC_EXT_LOOKUP(sqlProcedureColumns, 9)
  ODBC_EXT_LOOKUP(sqlProcedures, 7)
  ODBC_EXT_LOOKUP(sqlPutData, 3)
  ODBC_EXT_LOOKUP(sqlRowCount, 2)
  ODBC_EXT_LOOKUP(sqlSetConnectAttr, 4)
  ODBC_EXT_LOOKUP(sqlSetConnectOption, 3)
  ODBC_EXT_LOOKUP(sqlSetCursorName, 3)
  ODBC_EXT_LOOKUP(sqlSetDescField, 5)
  ODBC_EXT_LOOKUP(sqlSetDescRec, 10)
  ODBC_EXT_LOOKUP(sqlSetEnvAttr, 4)
  ODBC_EXT_LOOKUP(sqlSetParam, 8)
  ODBC_EXT_LOOKUP(sqlSetPos, 4)
  ODBC_EXT_LOOKUP(sqlSetScrollOptions, 4)
  ODBC_EXT_LOOKUP(sqlSetStmtAttr, 4)
  ODBC_EXT_LOOKUP(sqlSetStmtOption, 3)
  ODBC_EXT_LOOKUP(sqlSpecialColumns, 10)
  ODBC_EXT_LOOKUP(sqlStatistics, 9)
  ODBC_EXT_LOOKUP(sqlTablePrivileges, 7)
  ODBC_EXT_LOOKUP(sqlTables, 9)
  ODBC_EXT_LOOKUP(sqlTransact, 3)

  ODBC_EXT_LOOKUP(sqlAllocate, 1)
  ODBC_EXT_LOOKUP(sqlPoke, 4)
  ODBC_EXT_LOOKUP(sqlPeek, 3)
  ODBC_EXT_LOOKUP(sqlAddress, 3)
  ODBC_EXT_LOOKUP(sqlRowSize, 1)

  return NULL;
}
