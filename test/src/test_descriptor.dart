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

abstract class TestDescriptor {

  static void run() {

    group("Descriptor", () {

      test("sqlGetDesc(Rec/Field)", () {
        if (_VERSION >= SQL_OV_ODBC3) {
          var hStmt = new SqlHandle();
          _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));
          _(sqlExecDirect(hStmt, "SELECT price FROM parts", SQL_NTS));

          var hDesc = new SqlHandle();
          _(sqlGetStmtAttr(hStmt, SQL_ATTR_IMP_ROW_DESC, hDesc, 0, null));

          expect(hDesc.value, isNotNull);

          var name = new SqlString(32);
          var type = new SqlInt();
          var subtype = new SqlInt();
          var length = new SqlInt();
          var precision = new SqlInt();
          var scale = new SqlInt();
          var nullable = new SqlInt();

          _(sqlGetDescRec(hDesc, 1, name, name.length, null, type, subtype,
                          length, precision, scale, nullable));

          expect(name.value, isNotNull);
          expect(type.value, isNotNull);
          expect(subtype.value, isNotNull);
          expect(length.value, isNotNull);
          expect(precision.value, isNotNull);
          expect(scale.value, isNotNull);
          expect(nullable.value, isNotNull);

          var nameField = new SqlString(32);
          _(sqlGetDescField(hDesc, 1, SQL_DESC_NAME, nameField, nameField.length, null));

          expect(nameField.value, equals(name.value));

          var typeField = new SqlSmallIntBox();
          _(sqlGetDescField(hDesc, 1, SQL_DESC_TYPE, typeField, SQL_IS_SMALLINT, null));

          expect(typeField.value, equals(type.value));

          _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
        }
      });

      test("sqlSetDesc(Rec/Field)", () {
        if (_VERSION >= SQL_OV_ODBC3) {
          var hStmt = new SqlHandle();
          _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));
          _(sqlPrepare(hStmt, "SELECT price FROM parts WHERE part_id = ?", SQL_NTS));

          var hDesc = new SqlHandle();
          _(sqlGetStmtAttr(hStmt, SQL_ATTR_IMP_PARAM_DESC, hDesc, 0, null));

          _(sqlSetDescRec(hDesc, 1, 3, 0, 0, 15, 0, null, null, null));

          var precision = new SqlPointer()..value = 20;
          _(sqlSetDescField(hDesc, 1, SQL_DESC_PRECISION, precision, SQL_IS_SMALLINT));

          _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
        }
      });

      test("sqlCopyDesc", () {
        if (_VERSION >= SQL_OV_ODBC3) {
          var hDescSource = new SqlHandle();
          var hDescTarget = new SqlHandle();

          _(sqlAllocHandle(SQL_HANDLE_DESC, _hConn, hDescSource));
          _(sqlAllocHandle(SQL_HANDLE_DESC, _hConn, hDescTarget));

          _(sqlCopyDesc(hDescSource, hDescTarget));

          _(sqlFreeHandle(SQL_HANDLE_DESC, hDescSource));
          _(sqlFreeHandle(SQL_HANDLE_DESC, hDescTarget));
        }
      });

    });
  }
}

