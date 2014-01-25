**dart-odbc** allows you to connect to any database vendor with your legacy ODBC drivers.

### Usage ###

The library interface looks very similar to the original ODBC API:

<http://msdn.microsoft.com/en-us/library/windows/desktop/ms710252(v=vs.85).aspx>

Connect:

```
// Allocate an environment handle.
var hEnv = new SqlHandle();

sqlAllocHandle(SQL_HANDLE_ENV, null, hEnv);

// Set ODBC version to be used.
var version = new SqlPointer()..value = SQL_OV_ODBC3;

sqlSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION, version, 0);

// Allocate a connection handle.
var hConn = new SqlHandle();

sqlAllocHandle(SQL_HANDLE_DBC, hEnv, hConn);

// Connect.
sqlConnect(hConn, "<YOUR DSN>", SQL_NTS, "<YOUR USER ID>", SQL_NTS, "<YOUR PASSWORD>", SQL_NTS);
```

Retrieve some data:

```
// Allocate a statement handle.
var hStmt = new SqlHandle();

sqlAllocHandle(SQL_HANDLE_STMT, hConn, hStmt);

// Prepare a statement.
sqlPrepare(hStmt, "SELECT name FROM customers WHERE customer_id = ?", SQL_NTS);

// Bind parameters.
var customerId = new SqlIntBuffer()..poke(<YOUR CUSTOMER_ID>);

sqlBindParameter(hStmt, 1, SQL_PARAM_INPUT, customerId.ctype(),
                 SQL_INTEGER, 0, 0, customerId.address(), 0, null);

// Bind result set columns.
var name = new SqlStringBuffer(32);
var flags = new SqlIntBuffer();

sqlBindCol(hStmt, 1, name.ctype(), name.address(), name.length(), flags.address());

// Execute and fetch some data.
sqlExecute(hStmt);

sqlFetch(hStmt);

...

// Free statement handle.
sqlFreeHandle(SQL_HANDLE_STMT, hStmt);
```

Disconnect:

```
// Disconnect.
sqlDisconnect(hConn);

// Free connection handle.
sqlFreeHandle(SQL_HANDLE_DBC, hConn);

// Free environment handle.
sqlFreeHandle(SQL_HANDLE_ENV, hEnv);
```

Note that error handling has been removed for clarity.

Take a look at the `test` folder for more examples.

### Testing ###

`odbc_test`, located at `test` folder, is a command line application that can be used to test the library with any database vendor.

Example:

```
dart odbc_test.dart --driver "Oracle in XE" --version 380 --dsn ODBC_TEST_ORACLE --uid odbc_test --pwd odbc_test
```

Execute `odbc_test.dart` without parameters to see details of usage.

Take a look at the `schema` folder to get the proper database schema to be used for testing.

### Building ###

ODBC binding is made with a Dart native extension, that is, a .dll (Windows), .so (Linux) or .dylib (Mac) file.

The source code is available, so you can build your own version.

#### Windows ####

Instructions to compile the native extension with Microsoft Visual C++ 2010 Express Edition:

- Create a new Win32 DLL empty project  
  _(File | New | Project)_

- Use "Multi-Byte Character Set" instead of "UNICODE"  
  _(Configuration Properties | General | Character Set)_

- Add `<YOUR DART SDK DIRECTORY>/include` to VC++ include directories  
  _(Configuration Properties | VC++ Directories | Include Directories)_

- Add `<YOUR DART SDK DIRECTORY>/bin` to VC++ library directories  
  _(Configuration Properties | VC++ Directories | Library Directories)_

- Add `dart.lib` to additional dependencies  
  _(Configuration Properties | Linker | Input | Additional Dependencies)_

- Add `DART_SHARED_LIB` and `ODBC_EXTENSION_EXPORTS` to preprocessor definitions  
  _(Configuration Properties | C/C++ | Preprocessor | Preprocessor Definitions)_

- Copy all files from the `cpp/src` folder of the dart-odbc project to the "Source Files"

- Compile it!

#### Linux ####

Instructions to compile the native extension with gcc:

- Start a command line console in the `cpp/src` folder of the project

- Compile sources with the following command:  
  _g++ -fPIC -m32 -shared -O2 -I<YOUR DART SDK DIRECTORY>/include -I<YOUR ODBC SDK DIRECTORY>/include -lodbc -o libodbc_ext.so odbc_ext.cc odbc_ext_box.cc odbc_ext_sql.cc_

### Notes ###

- This package only includes the 32 bits Windows dll, but it can be used in 64 bits operating system.

- If you use the Win32 version in a Win64 operating system just remember to use the Win32 ODBC administrator located at `<YOUR WINDOW DIRECTORY>\SysWOW64\odbcad32.exe`, instead of the one available under Windows Control Panel.