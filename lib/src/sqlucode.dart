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

/*
References:
- Microsoft Open Database Connectivity (ODBC)
  http://msdn.microsoft.com/en-us/library/windows/desktop/ms710252(v=vs.85).aspx
*/

part of odbc;

const int SQL_WCHAR        =  -8;
const int SQL_WVARCHAR     =  -9;
const int SQL_WLONGVARCHAR = -10;
const int SQL_C_WCHAR      = SQL_WCHAR;

int get SQL_C_TCHAR => ODBC_UNICODE ? SQL_C_WCHAR : SQL_C_CHAR;

const int SQL_SQLSTATE_SIZEW = 10;
