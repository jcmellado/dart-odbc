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

abstract class TestParameter {

  static void run() {

    group("Parameter", () {

      test("sqlBindParameter", () {
        var hStmt = new SqlHandle();
        _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));

        var maxId = new SqlIntBuffer();
        var flags = new SqlIntBuffer();
        _(sqlExecDirect(hStmt, "SELECT MAX(customer_id) FROM customers", SQL_NTS));
        _(sqlBindCol(hStmt, 1, maxId.ctype(), maxId.address(), 0, flags.address()));
        _(sqlFetch(hStmt));
        _(sqlCloseCursor(hStmt));

        _(sqlPrepare(hStmt, "INSERT INTO customers(customer_id, name)"
                     " VALUES(?, ?)", SQL_NTS));

        var id = flags.peek() == SQL_NULL_DATA ? 1 : maxId.peek() + 1;
        var customerId = new SqlIntBuffer()..poke(id);
        var name = new SqlStringBuffer(16)..poke("John");

        _(sqlBindParameter(hStmt, 1, SQL_PARAM_INPUT, customerId.ctype(),
                           SQL_INTEGER, 0, 0, customerId.address(), 0, null));

        _(sqlBindParameter(hStmt, 2, SQL_PARAM_INPUT, name.ctype(),
                           SQL_VARCHAR, 0, 0, name.address(), name.length(), null));

        _(sqlExecute(hStmt));

        _(sqlEndTran(SQL_HANDLE_DBC, _hConn, SQL_COMMIT));

        _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
      });

      test("sqlSetParam", () {
        var hStmt = new SqlHandle();
        _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));

        var maxId = new SqlIntBuffer();
        var flags = new SqlIntBuffer();
        _(sqlExecDirect(hStmt, "SELECT MAX(customer_id) FROM customers", SQL_NTS));
        _(sqlBindCol(hStmt, 1, maxId.ctype(), maxId.address(), 0, flags.address()));
        _(sqlFetch(hStmt));
        _(sqlCloseCursor(hStmt));

        _(sqlPrepare(hStmt, "INSERT INTO customers(customer_id, name)"
                     " VALUES(?, ?)", SQL_NTS));

        var id = flags.peek() == SQL_NULL_DATA ? 1 : maxId.peek() + 1;
        var customerId = new SqlIntBuffer()..poke(id);
        var name = new SqlStringBuffer(16)..poke("John");

        _(sqlSetParam(hStmt, 1, customerId.ctype(), SQL_INTEGER, 0, 0,
                      customerId.address(), null));

        _(sqlSetParam(hStmt, 2, name.ctype(), SQL_VARCHAR, 0, 0,
                      name.address(), null));

        _(sqlExecute(hStmt));

        _(sqlEndTran(SQL_HANDLE_DBC, _hConn, SQL_COMMIT));

        _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
      });

      test("sqlBindParameter - Column-wise binding", () {
        if (_VERSION >= SQL_OV_ODBC3) {
          var hStmt = new SqlHandle();
          _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));

          var maxId = new SqlIntBuffer();
          var flags = new SqlIntBuffer();
          _(sqlExecDirect(hStmt, "SELECT MAX(customer_id) FROM customers", SQL_NTS));
          _(sqlBindCol(hStmt, 1, maxId.ctype(), maxId.address(), 0, flags.address()));
          _(sqlFetch(hStmt));
          _(sqlCloseCursor(hStmt));

          var rows = new SqlPointer()..value = 3;
          var status = new SqlIntBuffer(rows.value);
          var processed = new SqlIntBuffer();

          var par1 = new SqlIntBuffer(rows.value);
          var par2 = new SqlStringBuffer(16, rows.value);
          var flags1 = new SqlIntBuffer(rows.value);
          var flags2 = new SqlIntBuffer(rows.value);

          var id = flags.peek() == SQL_NULL_DATA ? 0 : maxId.peek();
          par1.poke(id + 1, 0);
          par1.poke(id + 2, 1);
          par1.poke(id + 3, 2);
          par2.poke("Emma", 0);
          par2.poke("Jane", 1);
          par2.poke("Sue",  2);
          flags2.poke(SQL_NTS, 0);
          flags2.poke(SQL_NTS, 1);
          flags2.poke(SQL_NTS, 2);

          var bindType = new SqlPointer()..value = SQL_PARAM_BIND_BY_COLUMN;

          _(sqlSetStmtAttr(hStmt, SQL_ATTR_PARAM_BIND_TYPE, bindType, SQL_IS_UINTEGER));
          _(sqlSetStmtAttr(hStmt, SQL_ATTR_PARAMSET_SIZE, rows, SQL_IS_UINTEGER));
          _(sqlSetStmtAttr(hStmt, SQL_ATTR_PARAM_STATUS_PTR, status.address(), SQL_IS_POINTER));
          _(sqlSetStmtAttr(hStmt, SQL_ATTR_PARAMS_PROCESSED_PTR, processed.address(), SQL_IS_POINTER));

          _(sqlBindParameter(hStmt, 1, SQL_PARAM_INPUT, par1.ctype(), SQL_INTEGER,
                             0, 0, par1.address(), 0, flags1.address()));
          _(sqlBindParameter(hStmt, 2, SQL_PARAM_INPUT, par2.ctype(), SQL_VARCHAR,
                             0, 0, par2.address(), par2.length(), flags2.address()));

          _(sqlExecDirect(hStmt, "INSERT INTO customers(customer_id, name)"
                          " VALUES(?, ?)", SQL_NTS));

          expect(processed.peek(), equals(3), reason: "Processed rows value is not 3");

          var rowCount = new SqlInt();
          _(sqlRowCount(hStmt, rowCount));

          expect(rowCount.value, equals(3), reason: "Affected rows value is not 3");

          _(sqlEndTran(SQL_HANDLE_DBC, _hConn, SQL_COMMIT));

          _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
        }
      });

      test("sqlBindParameter - Row-wise binding", () {
        if (_VERSION >= SQL_OV_ODBC3) {
          var hStmt = new SqlHandle();
          _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));

          var maxId = new SqlIntBuffer();
          var flags = new SqlIntBuffer();
          _(sqlExecDirect(hStmt, "SELECT MAX(customer_id) FROM customers", SQL_NTS));
          _(sqlBindCol(hStmt, 1, maxId.ctype(), maxId.address(), 0, flags.address()));
          _(sqlFetch(hStmt));
          _(sqlCloseCursor(hStmt));

          var types = <TypeLen>[new TypeLen(SQL_C_SLONG), new TypeLen(SQL_C_SLONG),
                                new TypeLen(SQL_C_CHAR, 16), new TypeLen(SQL_C_SLONG)];

          var rows = new SqlPointer()..value = 3;
          var buffer = new SqlArrayBuffer(types, rows.value);
          var status = new SqlSmallIntBuffer(rows.value);
          var processed = new SqlIntBuffer();

          var id = flags.peek() == SQL_NULL_DATA ? 0 : maxId.peek();
          buffer.poke(id + 1, 0, 0);
          buffer.poke(id + 2, 1, 0);
          buffer.poke(id + 3, 2, 0);
          buffer.poke("Tom",  0, 2);
          buffer.poke("Joe",  1, 2);
          buffer.poke("Carl", 2, 2);
          buffer.poke(SQL_NTS, 0, 3);
          buffer.poke(SQL_NTS, 1, 3);
          buffer.poke(SQL_NTS, 2, 3);

          var bindType = new SqlPointer()..value = buffer.rowSize();

          _(sqlSetStmtAttr(hStmt, SQL_ATTR_PARAM_BIND_TYPE, bindType, SQL_IS_UINTEGER));
          _(sqlSetStmtAttr(hStmt, SQL_ATTR_PARAMSET_SIZE, rows, SQL_IS_UINTEGER));
          _(sqlSetStmtAttr(hStmt, SQL_ATTR_PARAM_STATUS_PTR, status.address(), SQL_IS_POINTER));
          _(sqlSetStmtAttr(hStmt, SQL_ATTR_PARAMS_PROCESSED_PTR, processed.address(), SQL_IS_POINTER));

          _(sqlBindParameter(hStmt, 1, SQL_PARAM_INPUT, buffer.ctype(0), SQL_INTEGER,
                             0, 0, buffer.address(0, 0), 0, buffer.address(0, 1)));

          _(sqlBindParameter(hStmt, 2, SQL_PARAM_INPUT, buffer.ctype(2), SQL_VARCHAR,
                             0, 0, buffer.address(0, 2), buffer.length(2), buffer.address(0, 3)));

          _(sqlExecDirect(hStmt, "INSERT INTO customers(customer_id, name)"
                          " VALUES(?, ?)", SQL_NTS));

          expect(processed.peek(), equals(3), reason: "Processed rows value is not 3");

          var rowCount = new SqlInt();
          _(sqlRowCount(hStmt, rowCount));

          expect(rowCount.value, equals(3), reason: "Affected rows value is not 3");

          _(sqlEndTran(SQL_HANDLE_DBC, _hConn, SQL_COMMIT));

          _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
        }
      });

      test("sqlBindParameter - Procedure", () {
        var hStmt = new SqlHandle();
        _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));

        var orderId = new SqlIntBuffer()..poke(1);
        var amount = new SqlDoubleBuffer();
        var flags = new SqlIntBuffer();

        _(sqlPrepare(hStmt, "{? = CALL order_amount(?)}", SQL_NTS));

        _(sqlBindParameter(hStmt, 1, SQL_PARAM_OUTPUT, amount.ctype(),
                           SQL_DOUBLE, 0, 0, amount.address(), 0, flags.address()));

        _(sqlBindParameter(hStmt, 2, SQL_PARAM_INPUT, orderId.ctype(),
                           SQL_INTEGER, 0, 0, orderId.address(), 0, null));

        _(sqlExecute(hStmt));

        expect(flags.peek(), isNot(equals(SQL_NULL_DATA)));
        expect(amount.peek(), isNotNull);

        _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
      });

    });
  }
}
