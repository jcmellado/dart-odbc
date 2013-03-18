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

abstract class TestBlob {

  static void run() {

    group("Blob", () {

      test("sql(Param/Put)Data", () {
        var hStmt = new SqlHandle();
        _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));

        _(sqlExecDirect(hStmt, "DELETE FROM pictures WHERE part_id = 1", SQL_NTS),
            _successOrNodata);

        _(sqlPrepare(hStmt, "INSERT INTO pictures(part_id, picture) VALUES(1, ?)",
                     SQL_NTS));

        var picture = new SqlBinaryBuffer(16384);
        for (var i = 0; i < picture.rows; ++ i) {
          picture.poke(i & 0xff, i);
        }

        var param = new SqlPointer()..value = 1;
        var flags = new SqlIntBuffer()..poke(sqlLenDataAtExec(picture.rows));

        _(sqlBindParameter(hStmt, 1, SQL_PARAM_INPUT, picture.ctype(),
            SQL_BINARY, picture.rows, 0, param, 0, flags.address()));

        _(sqlExecute(hStmt), _needdata);

        var need = new SqlPointer();
        var retcode = sqlParamData(hStmt, need);

        expect(retcode, equals(SQL_NEED_DATA), reason: "Statement not need data");
        expect(need.value, equals(1), reason: "Parameter that need data is not 1");

        var remainder = picture.rows;
        const chunk = 1000;

        while (remainder > chunk) {
          _(sqlPutData(hStmt, picture.address(), chunk));
          remainder -= chunk;
        }

        if (remainder > 0) {
          _(sqlPutData(hStmt, picture.address(), remainder));
        }

        _(sqlParamData(hStmt, need));

        _(sqlEndTran(SQL_HANDLE_DBC, _hConn, SQL_COMMIT));

        _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
      });

    });
  }
}
