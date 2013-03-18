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

abstract class TestError {

  static void run() {

    group("Error", () {

      test("sqlGetDiag(Rec/Field)", () {
        var hStmt = new SqlHandle();
        _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));

        var state = new SqlString(SQLSTATE);
        var nativeError = new SqlInt();
        var message = new SqlString(256);

        _(sqlGetDiagRec(SQL_HANDLE_STMT, hStmt, 1, state, nativeError,
                        message, message.length, null), _nodata);

        sqlFetch(hStmt); //Forced error

        _(sqlGetDiagRec(SQL_HANDLE_STMT, hStmt, 1, state, nativeError,
                        message, message.length, null));

        expect(state.value, isNotNull);
        expect(nativeError.value, isNotNull);
        expect(message.value, isNotNull);

        var rowNumber = new SqlInt();
        _(sqlGetDiagField(SQL_HANDLE_STMT, hStmt, 1, SQL_DIAG_ROW_NUMBER,
                          rowNumber, SQL_IS_INTEGER, null));

        expect(rowNumber.value, isNotNull);

        var classOrigin = new SqlString(32);
        _(sqlGetDiagField(SQL_HANDLE_STMT, hStmt, 1, SQL_DIAG_CLASS_ORIGIN,
                          classOrigin, classOrigin.length, null));

        expect(classOrigin.value, isNotNull);

        _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
      });

      test("sqlError", () {
        var hStmt = new SqlHandle();
        _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));

        var state = new SqlString(SQLSTATE);
        var nativeError = new SqlInt();
        var message = new SqlString(256);

        _(sqlError(_hEnv, _hConn, hStmt, state, nativeError,
                   message, message.length, null), _nodata);

        sqlFetch(hStmt); //Forced error

        _(sqlError(_hEnv, _hConn, hStmt, state, nativeError,
                   message, message.length, null));

        expect(state.value, isNotNull);
        expect(nativeError.value, isNotNull);
        expect(message.value, isNotNull);

        _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
      });

    });
  }
}
