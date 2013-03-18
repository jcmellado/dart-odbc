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

#ifndef INCLUDE_ODBC_EXT_BOX_H_
#define INCLUDE_ODBC_EXT_BOX_H_

#ifndef INCLUDE_ODBC_EXT_H_
#include "odbc_ext.h"
#endif

//
// Accessors/Mutators.
//
#define GET_FIELD(container, name) \
  Dart_GetField(container, Dart_NewStringFromCString(name))

#define SET_FIELD(container, name, value) \
  Dart_SetField(container, Dart_NewStringFromCString(name), value)

#define UNBOX_TYPES(container)  GET_FIELD(container, "_types")
#define UNBOX_CTYPE(container)  getInteger(GET_FIELD(container, "_ctype"))
#define UNBOX_LENGTH(container) (intptr_t)getInteger(GET_FIELD(container, "_length"))
#define UNBOX_ROWS(container)   (intptr_t)getInteger(GET_FIELD(container, "_rows"))
#define UNBOX_BUFFER(container) GET_FIELD(container, "_buffer")
#define UNBOX_VALUE(container)  GET_FIELD(container, "value")
 
#define BOX_BUFFER(container, value) SET_FIELD(container, "_buffer", value)
#define BOX_VALUE(container, value)  SET_FIELD(container, "value", value)

//
// Basic type extraction.
//
int64_t getInteger(Dart_Handle object);

double getDouble(Dart_Handle object);

const char* getStringA(Dart_Handle object);

#define getSqlChar(object)       (SQLCHAR)getInteger(object)
#define getSqlSChar(object)      (SQLSCHAR)getInteger(object)
#define getSqlSmallInt(object)   (SQLSMALLINT)getInteger(object)
#define getSqlUSmallInt(object)  (SQLUSMALLINT)getInteger(object)
#define getSqlInteger(object)    (SQLINTEGER)getInteger(object)
#define getSqlUInteger(object)   (SQLUINTEGER)getInteger(object)
#define getSqlLen(object)        (SQLLEN)getInteger(object)
#define getSqlULen(object)       (SQLULEN)getInteger(object)
#define getSqlSetPosIRow(object) (SQLSETPOSIROW)getInteger(object)

#define getString(object)        getStringA(object)
#define getSqlTChar(object)      (SQLTCHAR*)getString(object)

//
// Unboxing.
//
int64_t unboxInteger(Dart_Handle container);

double unboxDouble(Dart_Handle container);

const char* unboxStringA(Dart_Handle container);

#define unboxSqlSmallInt(container)     (SQLSMALLINT)unboxInteger(container)
#define unboxSqlUSmallInt(container)    (SQLUSMALLINT)unboxInteger(container)
#define unboxSqlInteger(container)      (SQLINTEGER)unboxInteger(container)
#define unboxSqlUInteger(container)     (SQLUINTEGER)unboxInteger(container)
#define unboxSqlLen(container)          (SQLLEN)unboxInteger(container)
#define unboxSqlULen(container)         (SQLULEN)unboxInteger(container)

#define unboxString(container)          unboxStringA(container)
#define unboxSqlTChar(container)        (SQLTCHAR*)unboxString(container)

#define unboxSqlSmallIntPtr(container)  (SQLSMALLINT*)unboxInteger(container)
#define unboxSqlUSmallIntPtr(container) (SQLUSMALLINT*)unboxInteger(container)
#define unboxSqlIntegerPtr(container)   (SQLINTEGER*)unboxInteger(container)
#define unboxSqlUIntegerPtr(container)  (SQLUINTEGER*)unboxInteger(container)
#define unboxSqlLenPtr(container)       (SQLLEN*)unboxInteger(container)
#define unboxSqlULenPtr(container)      (SQLULEN*)unboxInteger(container)

#define unboxSqlHandle(container)       (SQLHANDLE)unboxInteger(container)
#define unboxSqlHWnd(container)         (SQLHWND)unboxInteger(container)

//
// Boxing.
//
void boxInteger(Dart_Handle container, int64_t value);

void boxDouble(Dart_Handle container, double value);

void boxStringA(Dart_Handle container, const char* text);

#define boxSqlSmallInt(container, value)  boxInteger(container, (int64_t)value)
#define boxSqlUSmallInt(container, value) boxInteger(container, (int64_t)value)
#define boxSqlInteger(container, value)   boxInteger(container, (int64_t)value)
#define boxSqlUInteger(container, value)  boxInteger(container, (int64_t)value)
#define boxSqlLen(container, value)       boxInteger(container, (int64_t)value)
#define boxSqlULen(container, value)      boxInteger(container, (int64_t)value)
#define boxSqlHandle(container, value)    boxInteger(container, (int64_t)value)

#define boxString(container, value)       boxStringA(container, value)
#define boxSqlTChar(container, value)     boxString(container, (const char*)value)

#define boxSqlPointer(container, value)   boxInteger(container, (int64_t)value)

//
// Pointers.
//
SQLPOINTER unboxSqlPointer(Dart_Handle container);

SQLPOINTER unboxSqlBoxPtr(Dart_Handle container);

void boxSqlBoxPtr(Dart_Handle container, SQLPOINTER pointer);

//
// Peek/Poke.
//
size_t sizeofCType(int64_t ctype);

Dart_Handle peek(void* peer, int64_t ctype, intptr_t length);

void poke(void* peer, Dart_Handle object, int64_t ctype, intptr_t length);

//
// Deferred buffers.
//
uint8_t* allocate(size_t size);

void deallocate(void* peer);

void finalizerCallback(Dart_Handle handle, void* peer);

intptr_t rowSize(Dart_Handle container);

void* address(Dart_Handle container, int64_t row, int64_t col, int64_t& ctype, intptr_t& length);

#endif //INCLUDE_ODBC_EXT_BOX_H_
