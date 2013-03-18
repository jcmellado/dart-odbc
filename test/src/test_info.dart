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

abstract class TestInfo {

  static void run() {

    group("Info", () {

      test("sqlDataSources", () {
        var server = new SqlString(256);
        var description = new SqlString(256);
        _(sqlDataSources(_hEnv, SQL_FETCH_FIRST, server, server.length, null,
                         description, description.length, null));

        expect(server.value, isNotNull, reason: "Server name is null");
        expect(description.value, isNotNull, reason: "Server description is null");
      });

      test("sqlDrivers", () {
        var description = new SqlString(256);
        var attributes = new SqlString(256);
        _(sqlDrivers(_hEnv, SQL_FETCH_FIRST, description, description.length, null,
                     attributes, attributes.length, null));

        expect(description.value, isNotNull, reason: "Driver description is null");
        expect(attributes.value, isNotNull, reason: "Driver attributes are null");
      });

      test("sqlGetInfo", () {
        var name = new SqlString(256);
        _(sqlGetInfo(_hConn, SQL_DBMS_NAME, name, name.length, null));

        expect(name.value, isNotNull, reason: "DBMS name is null");

        var len = new SqlUSmallIntBox();
        _(sqlGetInfo(_hConn, SQL_MAX_TABLE_NAME_LEN, len, 0, null));

        expect(len.value, isNotNull, reason: "Max table name length is null");
      });

      test("sqlGetFunctions", () {
        var function = new SqlUSmallIntBuffer();
        _(sqlGetFunctions(_hConn, SQL_API_SQLCONNECT, function.address()));

        expect(function.peek(), equals(SQL_TRUE));

        var functionsv2 = new SqlUSmallIntBuffer(100);
        _(sqlGetFunctions(_hConn, SQL_API_ALL_FUNCTIONS, functionsv2.address()));

        expect(functionsv2.peek(SQL_API_SQLCONNECT), equals(SQL_TRUE));

        var functionsv3 = new SqlUSmallIntBuffer(SQL_API_ODBC3_ALL_FUNCTIONS_SIZE);
        _(sqlGetFunctions(_hConn, SQL_API_ODBC3_ALL_FUNCTIONS, functionsv3.address()));

        expect(sqlFunctionExists(functionsv3, SQL_API_SQLCONNECT), isTrue);
      });

      test("sqlGetTypeInfo", () {
        var hStmt = new SqlHandle();

        _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));

        _(sqlGetTypeInfo(hStmt, SQL_ALL_TYPES));

        _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
      });

    });
  }
}
