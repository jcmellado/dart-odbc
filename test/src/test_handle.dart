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

abstract class TestHandle {

  static void run() {

    group("Handle", () {

      test("sql(Alloc/Free)Handle", () {
        var hEnv = new SqlHandle();
        _(sqlAllocHandle(SQL_HANDLE_ENV, null, hEnv));

        expect(hEnv.isValid(), isTrue, reason: "Handle is not valid");

        var version = new SqlPointer()..value = _VERSION;
        _(sqlSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION, version, 0));

        var hConn = new SqlHandle();
        _(sqlAllocHandle(SQL_HANDLE_DBC, hEnv, hConn));

        expect(hConn.isValid(), isTrue, reason: "Handle is not valid");

        _(sqlFreeHandle(SQL_HANDLE_DBC, hConn));

        _(sqlFreeHandle(SQL_HANDLE_ENV, hEnv));
      });

      test("sql(Alloc/Free)(Env/Conn/Stmt)", () {
        var hEnv = new SqlHandle();
        _(sqlAllocEnv(hEnv));

        expect(hEnv.isValid(), isTrue, reason: "Handle is not valid");

        var hConn = new SqlHandle();
        _(sqlAllocConnect(hEnv, hConn));

        expect(hConn.isValid(), isTrue, reason: "Handle is not valid");

        _(sqlConnect(hConn, _DSN, SQL_NTS, _UID, SQL_NTS, _PWD, SQL_NTS));

        var hStmt = new SqlHandle();
        _(sqlAllocStmt(hConn, hStmt));

        expect(hStmt.isValid(), isTrue, reason: "Handle is not valid");

        _(sqlFreeStmt(hStmt, SQL_DROP));

        _(sqlDisconnect(hConn));

        _(sqlFreeConnect(hConn));

        _(sqlFreeEnv(hEnv));
      });

    });
  }
}
