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

library odbc_test;

import "dart:io";

import "package:odbc/odbc.dart";
import "package:args/args.dart";
import "package:unittest/unittest.dart";

part "src/test.dart";
part "src/test_box.dart";
part "src/test_handle.dart";
part "src/test_connect.dart";
part "src/test_attribute.dart";
part "src/test_info.dart";
part "src/test_catalog.dart";
part "src/test_prepare.dart";
part "src/test_parameter.dart";
part "src/test_execute.dart";
part "src/test_fetch.dart";
part "src/test_column.dart";
part "src/test_blob.dart";
part "src/test_descriptor.dart";
part "src/test_transaction.dart";
part "src/test_error.dart";

// Parameters used for testing, see also schemas folder.
var _DRIVER;
var _VERSION;
var _DSN;
var _UID;
var _PWD;
var _SERVER;
var _DATABASE;
var _CATALOG;

// Test all.
void main() {
  if (_readArgs()) {
    _runTests();
  }
}

bool _readArgs() {
  var parser = new ArgParser();
  parser.addOption("driver", help: "Driver name (e.g. \"Oracle ODBC\")",
      callback: (driver) => _DRIVER = driver);
  parser.addOption("version", help: "ODBC version (1, 2, 3, ...)",
      callback: (version) => _VERSION = int.parse(version));
  parser.addOption("dsn", help: "Data Source Name", callback: (dsn) => _DSN = dsn);
  parser.addOption("uid", help: "User",  callback: (uid) => _UID = uid);
  parser.addOption("pwd", help: "Password", callback: (pwd) => _PWD = pwd);
  parser.addOption("server", help: "Server (e.g. localhost)",
      callback: (server) => _SERVER = server);
  parser.addOption("database", help: "Database name (e.g. postgres)",
      callback: (database) => _DATABASE = database);
  parser.addOption("catalog", help: "Catalog name",
      callback: (catalog) => _CATALOG = catalog);

  var args = new Options().arguments;

  if (args.isEmpty) {
    print("Usage: odbc_test --option value ...\n${parser.getUsage()}");
    return false;
  }

  parser.parse(args);
  return true;
}

void _runTests() {
  var hStmt = new SqlHandle();

  TestBox.run();
  TestHandle.run();
  TestConnect.run();
  TestAttribute.run();

  test("#connect#", () {
    var version = new SqlPointer()..value = _VERSION;
    var autocommit = new SqlPointer()..value = SQL_AUTOCOMMIT_OFF;
    var catalog = new SqlString(128)..value = _CATALOG;

    _(sqlAllocHandle(SQL_HANDLE_ENV, null, _hEnv));
    _(sqlSetEnvAttr(_hEnv, SQL_ATTR_ODBC_VERSION, version, 0));
    _(sqlAllocHandle(SQL_HANDLE_DBC, _hEnv, _hConn));
    _(sqlSetConnectAttr(_hConn, SQL_ATTR_AUTOCOMMIT, autocommit, SQL_IS_UINTEGER));
    _(sqlConnect(_hConn, _DSN, SQL_NTS, _UID, SQL_NTS, _PWD, SQL_NTS));
    _(sqlAllocHandle(SQL_HANDLE_STMT, _hConn, hStmt));
    if (catalog.value != null) {
      _(sqlExecDirect(hStmt, "USE ${catalog}", SQL_NTS));
    }
  });

  TestInfo.run();
  TestCatalog.run();
  TestPrepare.run();
  TestParameter.run();
  TestExecute.run();
  TestFetch.run();
  TestColumn.run();
  TestBlob.run();
  TestDescriptor.run();
  TestTransaction.run();
  TestError.run();

  test("#disconnect#", () {
    _(sqlFreeHandle(SQL_HANDLE_STMT, hStmt));
    _(sqlEndTran(SQL_HANDLE_DBC, _hConn, SQL_ROLLBACK));
    _(sqlDisconnect(_hConn));
    _(sqlFreeHandle(SQL_HANDLE_DBC, _hConn));
    _(sqlFreeHandle(SQL_HANDLE_ENV, _hEnv));
  });
}
