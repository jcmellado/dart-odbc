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

abstract class TestColumn {

  static void run() {
    var hStmt = new SqlHandle();

    group("Column", () {

      setUp(() {
        _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));
      });

      tearDown(() {
        _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
      });

      test("sqlBindCol", () {
        _(sqlPrepare(hStmt, "SELECT customer_id, name FROM customers", SQL_NTS));

        var col1 = new SqlLongBuffer();
        var flags1 = new SqlIntBuffer();
        _(sqlBindCol(hStmt, 1, col1.ctype(), col1.address(), null, flags1.address()));

        var col2 = new SqlStringBuffer(32);
        var flags2 = new SqlIntBuffer();
        _(sqlBindCol(hStmt, 2, col2.ctype(), col2.address(), col2.length(), flags2.address()));
      });

      test("sqlBindCol - Column-wise binding", () {
        if (_VERSION >= SQL_OV_ODBC3) {
          _(sqlPrepare(hStmt, "SELECT 'row1' FROM customers WHERE customer_id ="
                              " (SELECT MIN(customer_id) FROM customers)"
                              " UNION ALL"
                              " SELECT 'row2' FROM customers WHERE customer_id ="
                              " (SELECT MAX(customer_id) FROM customers)", SQL_NTS));

          var rows = new SqlPointer()..value = 20;
          _(sqlSetStmtAttr(hStmt, SQL_ATTR_ROW_ARRAY_SIZE, rows, SQL_IS_UINTEGER));

          var col1 = new SqlStringBuffer(32, rows.value);
          var flags1 = new SqlIntBuffer(rows.value);
          _(sqlBindCol(hStmt, 1, col1.ctype(), col1.address(), col1.length(), flags1.address()));

          _(sqlExecute(hStmt));

          _(sqlFetch(hStmt));

          expect(flags1.peek(0), isNot(equals(SQL_NULL_DATA)),
              reason: "Column 1 of row 1 is null");
          expect(flags1.peek(1), isNot(equals(SQL_NULL_DATA)),
              reason: "Column 1 of row 2 is null");

          expect(col1.peek(0), equals("row1"));
          expect(col1.peek(1), equals("row2"));
        }
      });

      test("sqlBindCol - Row-wise binding", () {
        if (_VERSION >= SQL_OV_ODBC3) {
          var types = <TypeLen>[new TypeLen(SQL_C_CHAR, 32), new TypeLen(SQL_C_SLONG)];
          var rows = new SqlPointer()..value = 20;
          var buffer = new SqlArrayBuffer(types, rows.value);
          var status = new SqlSmallIntBuffer(rows.value);
          var fetched = new SqlIntBuffer();

          var bindType = new SqlPointer()..value = buffer.rowSize();

          _(sqlSetStmtAttr(hStmt, SQL_ATTR_ROW_BIND_TYPE, bindType, SQL_IS_UINTEGER));
          _(sqlSetStmtAttr(hStmt, SQL_ATTR_ROW_ARRAY_SIZE, rows, SQL_IS_UINTEGER));
          _(sqlSetStmtAttr(hStmt, SQL_ATTR_ROW_STATUS_PTR, status.address(), SQL_IS_POINTER));
          _(sqlSetStmtAttr(hStmt, SQL_ATTR_ROWS_FETCHED_PTR, fetched.address(), SQL_IS_POINTER));

          _(sqlBindCol(hStmt, 1, buffer.ctype(0), buffer.address(0, 0),
                       buffer.length(0), buffer.address(0, 1)));

          _(sqlExecDirect(hStmt, "SELECT 'row1' FROM customers WHERE customer_id ="
                                 " (SELECT MIN(customer_id) FROM customers)"
                                 " UNION ALL"
                                 " SELECT 'row2' FROM customers WHERE customer_id ="
                                 " (SELECT MAX(customer_id) FROM customers)", SQL_NTS));

          _(sqlFetch(hStmt));

          expect(fetched.peek(), equals(2), reason: "Fetched rows is not 2");

          expect(sqlSucceeded(status.peek(0)), isTrue,
              reason: "Status flag of row 1 is ${status.peek(0)}");
          expect(buffer.peek(0, 1), isNot(equals(SQL_NULL_DATA)),
              reason: "Column 1 of row 1 is null");
          expect(buffer.peek(0, 0), equals("row1"));

          expect(sqlSucceeded(status.peek(1)), isTrue,
              reason: "Status flag of row 2 is ${status.peek(1)}");
          expect(buffer.peek(1, 1), isNot(equals(SQL_NULL_DATA)),
              reason: "Column 1 of row 2 is null");
          expect(buffer.peek(1, 0), equals("row2"));

          expect(status.peek(2), equals(SQL_ROW_NOROW),
              reason: "Status flag of row 2 is ${status.peek(2)}");
        }
      });

    });
  }
}


