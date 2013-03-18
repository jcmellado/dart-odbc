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

part of odbc_test;

abstract class TestAttribute {

  static void run() {

    group("Attribute", () {

      test("sql(Set/Get)(Env/Connect/Stmt)Attr", () {
        var hEnv = new SqlHandle();
        var hConn = new SqlHandle();
        var hStmt = new SqlHandle();

        //Env
        _(sqlAllocHandle(SQL_HANDLE_ENV, null, hEnv));

        var version = new SqlPointer()..value = _VERSION;
        _(sqlSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION, version, 0));

        var versionGet = new SqlPointer();
        _(sqlGetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION, versionGet, 0, null));

        expect(versionGet.value, equals(version.value));

        //Connect
        _(sqlAllocHandle(SQL_HANDLE_DBC, hEnv, hConn));
        _(sqlConnect(hConn, _DSN, SQL_NTS, _UID, SQL_NTS, _PWD, SQL_NTS));

        var autocommit = new SqlPointer()..value = SQL_AUTOCOMMIT_OFF;
        _(sqlSetConnectAttr(hConn, SQL_ATTR_AUTOCOMMIT, autocommit, SQL_IS_UINTEGER));

        var autocommitGet = new SqlPointer();
        _(sqlGetConnectAttr(hConn, SQL_ATTR_AUTOCOMMIT, autocommitGet, SQL_IS_UINTEGER, null));

        expect(autocommitGet.value, equals(autocommit.value));

        //Stmt
        _(sqlAllocHandle(SQL_HANDLE_STMT, hConn, hStmt));

        var size = new SqlPointer()..value = 20;
        _(sqlSetStmtAttr(hStmt, SQL_ATTR_ROW_ARRAY_SIZE, size, SQL_IS_UINTEGER));

        var sizeGet = new SqlPointer();
        _(sqlGetStmtAttr(hStmt, SQL_ATTR_ROW_ARRAY_SIZE, sizeGet, SQL_IS_UINTEGER, null));

        expect(size.value, sizeGet.value);

        if (_VERSION >= SQL_OV_ODBC3) {
          var status = new SqlIntBuffer();
          _(sqlParamOptions(hStmt, 30, status.address()));

          var statusGet = new SqlPointer();
          _(sqlGetStmtAttr(hStmt, SQL_ATTR_PARAMS_PROCESSED_PTR, statusGet, SQL_IS_POINTER, null));

          expect(statusGet.value, status.address().value);

          var sizeParamGet = new SqlPointer();
          _(sqlGetStmtAttr(hStmt, SQL_ATTR_PARAMSET_SIZE, sizeParamGet, SQL_IS_UINTEGER, null));

          expect(sizeParamGet.value, 30);
        }

        _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
        _(sqlDisconnect(hConn));
        _(sqlFreeHandle(SQL_HANDLE_DBC, hConn));
        _(sqlFreeHandle(SQL_HANDLE_ENV, hEnv));
      });

      test("sql(Set/Get)(Connect/Stmt)Option", () {
        var hEnv = new SqlHandle();
        var hConn = new SqlHandle();
        var hStmt = new SqlHandle();

        _(sqlAllocHandle(SQL_HANDLE_ENV, null, hEnv));
        var version = new SqlPointer()..value = _VERSION;
        _(sqlSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION, version, 0));

        //Connect
        _(sqlAllocHandle(SQL_HANDLE_DBC, hEnv, hConn));
        _(sqlConnect(hConn, _DSN, SQL_NTS, _UID, SQL_NTS, _PWD, SQL_NTS));

        var autocommit = new SqlPointer()..value = SQL_AUTOCOMMIT_OFF;
        _(sqlSetConnectOption(hConn, SQL_ATTR_AUTOCOMMIT, autocommit));

        var autocommitGet = new SqlPointer();
        _(sqlGetConnectOption(hConn, SQL_ATTR_AUTOCOMMIT, autocommitGet));

        expect(autocommitGet.value, equals(autocommit.value));

        //Stmt
        _(sqlAllocHandle(SQL_HANDLE_STMT, hConn, hStmt));

        var size = new SqlPointer()..value = 20;
        _(sqlSetStmtOption(hStmt, SQL_ATTR_ROW_ARRAY_SIZE, size));

        var sizeGet = new SqlPointer();
        _(sqlGetStmtOption(hStmt, SQL_ATTR_ROW_ARRAY_SIZE, sizeGet));

        expect(size.value, sizeGet.value);

        _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
        _(sqlDisconnect(hConn));
        _(sqlFreeHandle(SQL_HANDLE_DBC, hConn));
        _(sqlFreeHandle(SQL_HANDLE_ENV, hEnv));
      });
    });
  }
}
