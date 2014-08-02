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

#ifndef INCLUDE_ODBC_EXT_H_
#include "odbc_ext.h"
#endif

#ifndef INCLUDE_ODBC_EXT_SQL_H_
#include "odbc_ext_sql.h"
#endif

Dart_NativeFunction nativeResolver(Dart_Handle name, int argc, bool * autoSetupScope) {
  Dart_EnterScope();
  Dart_NativeFunction result = odbcResolver(name, argc);
  Dart_ExitScope();

  return result;
}

DART_EXPORT Dart_Handle odbc_ext_Init(Dart_Handle library) {
  if (Dart_IsError(library)) {
    return library;
  }
  Dart_Handle result = Dart_SetNativeResolver(library, nativeResolver, NULL);
  if (Dart_IsError(result)) {
    return result;
  }
  return Dart_Null();
}
