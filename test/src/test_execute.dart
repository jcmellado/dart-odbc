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

abstract class TestExecute {

  static void run() {
    var hStmt = new SqlHandle();

    group("Execute", () {

      setUp(() {
        _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));
      });

      tearDown(() {
        _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
      });

      test("sqlNativeSql", () {
        var nativeSql = new SqlString(128);
        _(sqlNativeSql(_hConn,
                       "SELECT { fn CONVERT(price, SQL_SMALLINT) } FROM parts",
                       SQL_NTS, nativeSql, nativeSql.length, null));

        expect(nativeSql.value, isNotNull, reason: "Native SQL is null");
      });

      test("sqlExecDirect", () {
        _(sqlExecDirect(hStmt, "SELECT customer_id, name FROM customers", SQL_NTS));
      });

      test("sqlExecute", () {
        _(sqlPrepare(hStmt, "SELECT customer_id, name FROM customers", SQL_NTS));

        _(sqlExecute(hStmt));
      });

      test("sqlNumParams", () {
        _(sqlPrepare(hStmt, "SELECT name FROM customers WHERE customer_id = ?",
                     SQL_NTS));

        var params = new SqlInt();
        _(sqlNumParams(hStmt, params));

        expect(params.value, equals(1), reason: "Number of parameters is not 1");
      });

      test("sqlNumResultCols", () {
        _(sqlPrepare(hStmt, "SELECT name FROM customers WHERE customer_id = ?",
                     SQL_NTS));

        var columns = new SqlInt();
        _(sqlNumResultCols(hStmt, columns));

        expect(columns.value, equals(1), reason: "Number of columns is not 1");
      });

      test("sqlDescribeParam", () {
        _(sqlPrepare(hStmt, "SELECT name FROM customers WHERE customer_id = ?",
                     SQL_NTS));

        var dataType = new SqlInt();
        var parameterSize = new SqlInt();
        var decimalInteger = new SqlInt();
        var nullable = new SqlInt();

        _(sqlDescribeParam(hStmt, 1, dataType, parameterSize, decimalInteger,
                           nullable));

        expect(dataType.value, isNotNull, reason: "Parameter data type is null");
        expect(parameterSize.value, isNotNull, reason: "Parameter size is null");
        expect(decimalInteger.value, isNotNull, reason: "Decimal digits is null");
        expect(nullable.value, isNotNull, reason: "Nullable is null");
      });

      test("sqlDescribeCol", () {
        _(sqlPrepare(hStmt, "SELECT customer_id FROM customers", SQL_NTS));

        var name = new SqlString(128);
        var dataType = new SqlInt();
        var size = new SqlInt();
        var decimalDigits = new SqlInt();
        var nullable = new SqlInt();

        _(sqlDescribeCol(hStmt, 1, name, name.length, null, dataType, size,
                         decimalDigits, nullable));

        expect(name.value, isNotNull, reason: "Column name is null");
        expect(dataType.value, isNotNull, reason: "Column data type is null");
        expect(size.value, isNotNull, reason: "Column size is null");
        expect(decimalDigits.value, isNotNull, reason: "Number of decimal digits is null");
        expect(nullable.value, isNotNull, reason: "Column nullable flag is null");
      });

      test("sqlRowCount", () {
        _(sqlExecDirect(hStmt,
            "DELETE FROM customers WHERE customer_id <> customer_id", SQL_NTS),
            _successOrNodata);

        var count = new SqlInt();
        _(sqlRowCount(hStmt, count));

        expect(count.value, equals(0), reason: "Row count is not 0");
      });

      test("sqlCancelHandle", () {
        var hStmt = new SqlHandle();
        _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));

        _(sqlPrepare(hStmt, "INSERT INTO pictures(part_id, picture) VALUES(1, ?)",
                     SQL_NTS));

        var picture = new SqlBinaryBuffer(16384);
        var param = new SqlPointer()..value = 1;
        var flags = new SqlIntBuffer()..poke(sqlLenDataAtExec(picture.rows));

        _(sqlBindParameter(hStmt, 1, SQL_PARAM_INPUT, picture.ctype(),
            SQL_BINARY, picture.rows, 0, param, 0, flags.address()));

        _(sqlExecute(hStmt), _needdata);

        _(sqlCancelHandle(SQL_HANDLE_STMT, hStmt));

        _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
      });

      test("sqlCancel", () {
        var hStmt = new SqlHandle();
        _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));

        _(sqlPrepare(hStmt, "INSERT INTO pictures(part_id, picture) VALUES(1, ?)",
                     SQL_NTS));

        var picture = new SqlBinaryBuffer(16384);
        var param = new SqlPointer()..value = 1;
        var flags = new SqlIntBuffer()..poke(sqlLenDataAtExec(picture.rows));

        _(sqlBindParameter(hStmt, 1, SQL_PARAM_INPUT, picture.ctype(),
            SQL_BINARY, picture.rows, 0, param, 0, flags.address()));

        _(sqlExecute(hStmt), _needdata);

        _(sqlCancel(hStmt));

        _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
      });

    });
  }
}
