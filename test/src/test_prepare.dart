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

abstract class TestPrepare {

  static void run() {
    var hStmt = new SqlHandle();

    group("Prepare", () {

      setUp(() {
        _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));
      });

      tearDown(() {
        _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
      });

      test("sqlPrepare", () {
        _(sqlPrepare(hStmt,"SELECT name FROM customers WHERE customer_id = ?", SQL_NTS));
      });

      test("sqlColAttribute", () {
        _(sqlPrepare(hStmt, "SELECT customer_id FROM customers", SQL_NTS));

        var string = new SqlString(128);
        var length = new SqlInt();
        _(sqlColAttribute(hStmt, 1, SQL_DESC_TYPE_NAME, string, string.length,
                          length, null));

        expect(string.value, isNotNull, reason: "Column type name is null");

        var number = new SqlInt();
        _(sqlColAttribute(hStmt, 1, SQL_DESC_CONCISE_TYPE, null, SQL_IS_INTEGER,
                          length, number));

        expect(number.value, isNotNull, reason: "Column type ordinal is null");
      });

      test("sqlColAttributes", () {
        _(sqlPrepare(hStmt, "SELECT customer_id FROM customers", SQL_NTS));

        var string = new SqlString(128);
        var length = new SqlInt();
        _(sqlColAttributes(hStmt, 1, SQL_DESC_TYPE_NAME, string, string.length,
                          length, null));

        expect(string.value, isNotNull, reason: "Column type name is null");

        var number = new SqlInt();
        _(sqlColAttributes(hStmt, 1, SQL_DESC_CONCISE_TYPE, null, SQL_IS_INTEGER,
                           length, number));

        expect(number.value, isNotNull, reason: "Column type ordinal is null");
      });

      test("sql(Set/Get)CursorName", () {
        _(sqlSetCursorName(hStmt, "C1", SQL_NTS));

        var name = new SqlString(128);
        _(sqlGetCursorName(hStmt, name, name.length, null));

        expect(name.value, equals("C1"));
      });

    });
  }
}
