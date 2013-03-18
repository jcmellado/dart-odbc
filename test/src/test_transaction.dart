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

abstract class TestTransaction {

  static void run() {

    group("Transaction", () {

      test("sqlEndTran", () {
        _(sqlEndTran(SQL_HANDLE_DBC, _hConn, SQL_ROLLBACK));

        _(sqlEndTran(SQL_HANDLE_DBC, _hConn, SQL_COMMIT));
      });

      test("sqlEndTran - Rollback", () {
        var hStmt = new SqlHandle();
        _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));

        _(sqlExecDirect(hStmt, "SELECT MAX(customer_id) FROM customers", SQL_NTS));

        var maxId = new SqlIntBuffer();
        var flags = new SqlIntBuffer();
        _(sqlBindCol(hStmt, 1, maxId.ctype(), maxId.address(), 0, flags.address()));

        _(sqlFetch(hStmt));

        _(sqlCloseCursor(hStmt));

        var customerId = flags.peek() == SQL_NULL_DATA ? 1 : maxId.peek() + 1;
        _(sqlExecDirect(hStmt, "INSERT INTO customers(customer_id, name)"
                        " VALUES(${customerId}, 'John')", SQL_NTS));

        _(sqlEndTran(SQL_HANDLE_DBC, _hConn, SQL_ROLLBACK));

        _(sqlExecDirect(hStmt, "SELECT name FROM customers"
                        " WHERE customer_id = ${customerId}", SQL_NTS));

        _(sqlFetch(hStmt), _nodata);

        _(sqlEndTran(SQL_HANDLE_DBC, _hConn, SQL_ROLLBACK));

        _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
      });


      test("sqlTransact", () {
        _(sqlTransact(_hEnv, _hConn, SQL_ROLLBACK));

        _(sqlTransact(_hEnv, _hConn, SQL_COMMIT));
      });

      test("sqlTransac - Rollback", () {
        var hStmt = new SqlHandle();
        _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));

        _(sqlExecDirect(hStmt, "SELECT MAX(customer_id) FROM customers", SQL_NTS));

        var maxId = new SqlIntBuffer();
        var flags = new SqlIntBuffer();
        _(sqlBindCol(hStmt, 1, maxId.ctype(), maxId.address(), 0, flags.address()));

        _(sqlFetch(hStmt));

        _(sqlCloseCursor(hStmt));

        var customerId = flags.peek() == SQL_NULL_DATA ? 1 : maxId.peek() + 1;
        _(sqlExecDirect(hStmt, "INSERT INTO customers(customer_id, name)"
                        " VALUES(${customerId}, 'John')", SQL_NTS));

        _(sqlTransact(_hEnv, _hConn, SQL_ROLLBACK));

        _(sqlExecDirect(hStmt, "SELECT name FROM customers"
                        " WHERE customer_id = ${customerId}", SQL_NTS));

        _(sqlFetch(hStmt), _nodata);

        _(sqlTransact(_hEnv, _hConn, SQL_ROLLBACK));

        _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
      });

    });
  }
}
