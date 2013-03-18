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

abstract class TestConnect {

  static void run() {
    var hEnv = new SqlHandle();
    var hConn = new SqlHandle();

    group("Connect", () {

      setUp(() {
        var version = new SqlPointer()..value = _VERSION;

        _(sqlAllocHandle(SQL_HANDLE_ENV, null, hEnv));
        _(sqlSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION, version, 0));
        _(sqlAllocHandle(SQL_HANDLE_DBC, hEnv, hConn));
      });

      tearDown(() {
        _(sqlFreeHandle(SQL_HANDLE_DBC, hConn));
        _(sqlFreeHandle(SQL_HANDLE_ENV, hEnv));
      });

      test("sql(Connect/Disconnect)", () {
        _(sqlConnect(hConn, _DSN, SQL_NTS, _UID, SQL_NTS, _PWD, SQL_NTS));

        _(sqlDisconnect(hConn));
      });

      test("sqlDriverConnect", () {
        var connectString = new SqlString(2048);

        var uid = _UID == null ? "" : "UID=${_UID};";
        var pwd = _PWD == null ? "" : "PWD=${_PWD};";
        var server = _SERVER == null ? "" : "SERVER=${_SERVER};";
        var database = _DATABASE == null ? "" : "DATABASE=${_DATABASE};";

        _(sqlDriverConnect(hConn, null, "DRIVER=${_DRIVER};${server}${database}${uid}${pwd}",
            SQL_NTS, connectString, connectString.length, null, SQL_DRIVER_NOPROMPT),
            _successOrNeeddata);

        expect(connectString.value, isNotNull, reason: "Connect String is null");

        _(sqlDisconnect(hConn));
      });

      test("sqlBrowseConnect", () {
        var connectString = new SqlString(2048);

        var result = sqlBrowseConnect(hConn, "DSN=${_DSN};", SQL_NTS,
                                      connectString, connectString.length, null);

        _(result, _successOrNeeddata);

        expect(connectString.value, isNotNull, reason: "Connect String is null");

        if (result == SQL_NEED_DATA) {
          var uid = _UID == null ? "" : "UID=${_UID};";
          var pwd = _PWD == null ? "" : "PWD=${_PWD};";

          _(sqlBrowseConnect(hConn, "${uid}${pwd}", SQL_NTS,
                             connectString, connectString.length, null),
                             _successOrNeeddata);

          expect(connectString.value, isNotNull, reason: "Connect String is null");
        }

        _(sqlDisconnect(hConn));
      });

    });
  }
}
