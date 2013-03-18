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

abstract class TestFetch {

  static void run() {
    var hStmt = new SqlHandle();

    group("Fetch", () {

      setUp(() {
        _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));
      });

      tearDown(() {
        _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
      });

      test("sqlFetch", () {
        _(sqlPrepare(hStmt, "SELECT order_id, sales_person, open_date, NULL"
                            " FROM orders", SQL_NTS));

        var col1 = new SqlLongBuffer();
        var flags1 = new SqlIntBuffer();
        _(sqlBindCol(hStmt, 1, col1.ctype(), col1.address(), 0, flags1.address()));

        var col2 = new SqlStringBuffer(32);
        var flags2 = new SqlIntBuffer();
        _(sqlBindCol(hStmt, 2, col2.ctype(), col2.address(), col2.length(), flags2.address()));

        var col3 = new SqlDateBuffer();
        var flags3 = new SqlIntBuffer();
        _(sqlBindCol(hStmt, 3, col3.ctype(), col3.address(), 0, flags3.address()));

        var col4 = new SqlLongBuffer();
        var flags4 = new SqlIntBuffer();
        _(sqlBindCol(hStmt, 4, col4.ctype(), col4.address(), 0, flags4.address()));

        _(sqlExecute(hStmt));

        _(sqlFetch(hStmt));

        expect(flags1.peek(), isNot(equals(SQL_NULL_DATA)), reason: "Column 1 is null");
        expect(flags2.peek(), isNot(equals(SQL_NULL_DATA)), reason: "Column 2 is null");
        expect(flags3.peek(), isNot(equals(SQL_NULL_DATA)), reason: "Column 3 is null");
        expect(flags4.peek(), equals(SQL_NULL_DATA), reason: "Column 4 is not null");
        expect(col1.peek(), isNotNull);
        expect(col2.peek(), isNotNull);

        var resultDate = col3.peek();
        expect(resultDate, isNotNull);
        expect(resultDate.year, isNotNull);
        expect(resultDate.month, isNotNull);
        expect(resultDate.day, isNotNull);
      });

      test("sqlFetchScroll", () {
        if (_VERSION >= SQL_OV_ODBC3) {
          var rows = new SqlPointer()..value = 2;
          var name = new SqlStringBuffer(32, rows.value);
          var flags = new SqlIntBuffer(rows.value);

          _(sqlSetStmtAttr(hStmt, SQL_ATTR_ROW_ARRAY_SIZE, rows, SQL_IS_UINTEGER));
          _(sqlPrepare(hStmt, "SELECT name FROM customers", SQL_NTS));
          _(sqlBindCol(hStmt, 1, name.ctype(), name.address(), name.length(),
                       flags.address()));
          _(sqlExecute(hStmt));

          _(sqlFetchScroll(hStmt, SQL_FETCH_NEXT, 0));

          expect(flags.peek(0), isNot(equals(SQL_NULL_DATA)),
              reason: "Column 1 of row 1 is null");
          expect(flags.peek(1), isNot(equals(SQL_NULL_DATA)),
              reason: "Column 1 of row 2 is null");

          expect(name.peek(0), isNotNull);
          expect(name.peek(1), isNotNull);

          _(sqlFetchScroll(hStmt, SQL_FETCH_NEXT, 0));

          expect(flags.peek(0), isNot(equals(SQL_NULL_DATA)),
              reason: "Column 1 of row 1 is null");
          expect(flags.peek(1), isNot(equals(SQL_NULL_DATA)),
              reason: "Column 1 of row 2 is null");

          expect(name.peek(0), isNotNull);
          expect(name.peek(1), isNotNull);
        }
      });

      test("sqlSetScrollOptions", () {
        _(sqlSetScrollOptions(hStmt, SQL_CONCUR_READ_ONLY, SQL_SCROLL_FORWARD_ONLY, 2));
      });

      test("sqlExtendedFetch", () {
        if (_VERSION >= SQL_OV_ODBC3) {
          var rows = new SqlPointer()..value = 2;
          var name = new SqlStringBuffer(32, rows.value);
          var flags = new SqlIntBuffer(rows.value);

          _(sqlSetScrollOptions(hStmt, SQL_CONCUR_READ_ONLY, SQL_SCROLL_FORWARD_ONLY,
                                rows.value));

          _(sqlSetStmtAttr(hStmt, SQL_ATTR_ROW_ARRAY_SIZE, rows, SQL_IS_UINTEGER));
          _(sqlPrepare(hStmt, "SELECT name FROM customers", SQL_NTS));
          _(sqlBindCol(hStmt, 1, name.ctype(), name.address(), name.length(),
                       flags.address()));
          _(sqlExecute(hStmt));

          var rowCount = new SqlIntBuffer();
          var rowStatus = new SqlUSmallIntBuffer(rows.value);

          _(sqlExtendedFetch(hStmt, SQL_FETCH_NEXT, 0, rowCount.address(), rowStatus.address()));

          expect(rowCount.peek(), equals(2));
        }
      });

      test("sqlGetData", () {
        _(sqlExecDirect(hStmt, "SELECT customer_id, name FROM customers", SQL_NTS));

        _(sqlFetch(hStmt));

        var col1 = new SqlULongBox();
        _(sqlGetData(hStmt, 1, col1.ctype, col1, 0, null));

        expect(col1.value, isNotNull);

        var col2 = new SqlString(32);
        _(sqlGetData(hStmt, 2, col2.ctype, col2, col2.length, null));

        expect(col2.value, isNotNull);
      });

      test("sqlCloseCursor", () {
        _(sqlExecDirect(hStmt, "SELECT customer_id, name FROM customers", SQL_NTS));

        _(sqlCloseCursor(hStmt));
      });

    });
  }
}
