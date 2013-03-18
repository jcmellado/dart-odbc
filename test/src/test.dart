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

// Global shared handles for testing.
var _hEnv = new SqlHandle();
var _hConn = new SqlHandle();

// Custom SQL expect.
void _(int result, [bool eval(int) = sqlSucceeded]) =>
    expect(eval(result), isTrue, reason: "SQLRETURN is ${result}");

bool _nodata(int result) => result == SQL_NO_DATA;

bool _needdata(int result) => result == SQL_NEED_DATA;

bool _successOrNodata(int result) => sqlSucceeded(result) || _nodata(result);

bool _successOrNeeddata(int result) => sqlSucceeded(result) || _needdata(result);
