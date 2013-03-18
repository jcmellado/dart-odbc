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

abstract class TestCatalog {

  static void run() {
    var hStmt = new SqlHandle();

    group("Catalog", () {

      setUp(() {
        _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));
      });

      tearDown(() {
        _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
      });

      test("sqlTables", () {
        _(sqlTables(hStmt, null, 0, "", SQL_NTS, "", SQL_NTS,
                    SQL_ALL_TABLE_TYPES, SQL_NTS));
      });

      test("sqlColumns", () {
        _(sqlColumns(hStmt, null, 0, "", SQL_NTS, "", SQL_NTS, "", SQL_NTS));
      });

      test("sqlPrimaryKeys", () {
        _(sqlPrimaryKeys(hStmt, null, 0, "", SQL_NTS, "customers", SQL_NTS));
      });

      test("sqlForeignKeys", () {
        _(sqlForeignKeys(hStmt, null, 0, "", SQL_NTS, "", SQL_NTS, null, 0,
                         "", SQL_NTS, "", SQL_NTS));
      });

      test("sqlSpecialColumns", () {
        _(sqlSpecialColumns(hStmt, SQL_BEST_ROWID, null, 0, "", SQL_NTS,
                            "customers", SQL_NTS, SQL_SCOPE_CURROW, SQL_NULLABLE));
      });

      test("sqlStatistics", () {
        _(sqlStatistics(hStmt,null, 0, "", SQL_NTS, "customers", SQL_NTS,
                        SQL_INDEX_ALL, SQL_QUICK));
      });

      test("sqlTablePrivileges", () {
        _(sqlTablePrivileges(hStmt, null, 0, "", SQL_NTS, "", SQL_NTS));
      });

      test("sqlColumnPrivileges", () {
        _(sqlColumnPrivileges(hStmt, null, 0, "", SQL_NTS, "customers", SQL_NTS,
                              "", SQL_NTS));
      });

      test("sqlProcedures", () {
        _(sqlProcedures(hStmt, null, 0, "", SQL_NTS, "", SQL_NTS));
      });

      test("sqlProcedureColumns", () {
        _(sqlProcedureColumns(hStmt, null, 0, "", SQL_NTS, "", SQL_NTS,
                              "", SQL_NTS));
      });

    });
  }
}
