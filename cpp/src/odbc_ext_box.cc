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
#include "odbc_ext_box.h"
#endif

#define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))

//
// Basic type extraction.
//
int64_t getInteger(Dart_Handle object) {
  int64_t value = 0;
  if (!Dart_IsNull(object) && Dart_IsInteger(object)) {
    bool fits;
    Dart_IntegerFitsIntoInt64(object, &fits); 
    if (fits) {
      Dart_IntegerToInt64(object, &value);
    }
  }
  return value;
}

double getDouble(Dart_Handle object) {
  double value = 0.0;
  if (!Dart_IsNull(object) && Dart_IsDouble(object)) {
    Dart_DoubleValue(object, &value);
  }
  return value;
}

const char* getStringA(Dart_Handle object) {
  const char* text = NULL;
  if (!Dart_IsNull(object) && Dart_IsString(object)) {
    Dart_StringToCString(object, &text);
  }
  return text;
}

//
// Unboxing.
//
int64_t unboxInteger(Dart_Handle container) {
  return Dart_IsNull(container) ? 0 : getInteger(UNBOX_VALUE(container));
}

double unboxDouble(Dart_Handle container) {
  return Dart_IsNull(container) ? 0.0 : getDouble(UNBOX_VALUE(container));
}

const char* unboxStringA(Dart_Handle container) {
  char* string = NULL;
  if (!Dart_IsNull(container)) {
    intptr_t length = UNBOX_LENGTH(container);
    if (length > 0) {
      string = (char*)Dart_ScopeAllocate(length);
      memset((void*)string, 0, length);
      Dart_Handle value = UNBOX_VALUE(container);
      if (!Dart_IsNull(value)) {
        strncpy(string, getString(value), length);
        string[length - 1] = '\0';
      }
    }
  }
  return string;
}

//
// Boxing.
//
void boxInteger(Dart_Handle container, int64_t value) {
  if (!Dart_IsNull(container)) {
    BOX_VALUE(container, Dart_NewInteger(value));
  }
}

void boxDouble(Dart_Handle container, double value) {
  if (!Dart_IsNull(container)) {
    BOX_VALUE(container, Dart_NewDouble(value));
  }
}

void boxStringA(Dart_Handle container, const char* text) {
  if (!Dart_IsNull(container)) {
    intptr_t length = UNBOX_LENGTH(container);
    if ((text == NULL) || (length <= 0)) {
      BOX_VALUE(container, Dart_Null());
    } else {
      char* string = (char*)Dart_ScopeAllocate(length);
      strncpy(string, text, length);
      string[length - 1] = '\0';
      BOX_VALUE(container, Dart_NewStringFromCString(string));
    }
  }
}

//
// Pointers.
//
SQLPOINTER unboxSqlPointer(Dart_Handle container) {
  SQLPOINTER pointer = NULL;
  if (!Dart_IsNull(container)) {
    Dart_Handle value = UNBOX_VALUE(container);
    if (Dart_IsInteger(value)) {
      pointer = (SQLPOINTER)getInteger(value);
    }
    if (Dart_IsString(value)) {
      pointer = (SQLPOINTER)getString(value);
    }
  }
  return pointer;
}

SQLPOINTER unboxSqlBoxPtr(Dart_Handle container) {
  SQLPOINTER pointer = NULL;
  if (!Dart_IsNull(container)) {
    int64_t ctype = UNBOX_CTYPE(container);
    intptr_t length = UNBOX_LENGTH(container);
    intptr_t size = sizeofCType(ctype) * length;
    if (size > 0) {
      pointer = Dart_ScopeAllocate(size);
      memset(pointer, 0, size);
      Dart_Handle value = UNBOX_VALUE(container);
      if (!Dart_IsNull(value)) {
        poke(pointer, value, ctype, length);
      }
    }
  }
  return pointer;
}

void boxSqlBoxPtr(Dart_Handle container, SQLPOINTER pointer) {
  if (!Dart_IsNull(container)) {
    if (pointer == NULL) {
      BOX_VALUE(container, Dart_Null());
    } else {
      int64_t ctype = UNBOX_CTYPE(container);
      intptr_t length = UNBOX_LENGTH(container);
      BOX_VALUE(container, peek(pointer, ctype, length));
    }
  }
}

//
// C type sizes.
//
size_t sizeofCType(int64_t ctype) {
  switch(ctype) {
    //case SQL_C_TCHAR:
    case SQL_C_CHAR:
    case SQL_C_BINARY:
    //case SQL_C_VARBOOKMARK:
    case SQL_C_BIT:
    case SQL_C_TINYINT:
    case SQL_C_UTINYINT:
      return sizeof(SQLCHAR);
    case SQL_C_STINYINT:
      return sizeof(SQLSCHAR);
    //case SQL_C_TCHAR:
    case SQL_C_WCHAR:
      return sizeof(SQLWCHAR);
    case SQL_C_SHORT:
    case SQL_C_SSHORT:
      return sizeof(SQLSMALLINT);
    case SQL_C_USHORT:
      return sizeof(SQLUSMALLINT);
    case SQL_C_LONG:
    case SQL_C_SLONG:
      return sizeof(SQLINTEGER);
    case SQL_C_ULONG:
    //case SQL_C_BOOKMARK:
      return sizeof(SQLUINTEGER);
    case SQL_C_FLOAT:
      return sizeof(SQLREAL);
    case SQL_C_DOUBLE:
      return sizeof(SQLDOUBLE);
    case SQL_C_SBIGINT:
      return sizeof(SQLBIGINT);
    case SQL_C_UBIGINT:
      return sizeof(SQLUBIGINT);
    case SQL_C_DATE:
    case SQL_C_TYPE_DATE:
      return sizeof(SQL_DATE_STRUCT);
    case SQL_C_TIME:
    case SQL_C_TYPE_TIME:
      return sizeof(SQL_TIME_STRUCT);
    case SQL_C_TIMESTAMP:
    case SQL_C_TYPE_TIMESTAMP:
      return sizeof(SQL_TIMESTAMP_STRUCT);
    case SQL_C_NUMERIC:
      return sizeof(SQL_NUMERIC_STRUCT);
    case SQL_C_GUID:
      return sizeof(SQLGUID);
    case SQL_C_INTERVAL_YEAR:
    case SQL_C_INTERVAL_MONTH:
    case SQL_C_INTERVAL_DAY:
    case SQL_C_INTERVAL_HOUR:
    case SQL_C_INTERVAL_MINUTE:
    case SQL_C_INTERVAL_SECOND:
    case SQL_C_INTERVAL_YEAR_TO_MONTH:
    case SQL_C_INTERVAL_DAY_TO_HOUR:
    case SQL_C_INTERVAL_DAY_TO_MINUTE:
    case SQL_C_INTERVAL_DAY_TO_SECOND:
    case SQL_C_INTERVAL_HOUR_TO_MINUTE:
    case SQL_C_INTERVAL_HOUR_TO_SECOND:
    case SQL_C_INTERVAL_MINUTE_TO_SECOND:
      return sizeof(SQL_INTERVAL_STRUCT);
  }
  return 0;
}

//
// Creates a new Dart object calling default constructor with given parameters.
//
Dart_Handle newObject(const char* className, Dart_Handle* args, int argCount) {
  Dart_Handle library = Dart_RootLibrary();
  Dart_Handle name = Dart_NewStringFromCString(className);
  Dart_Handle clazz = Dart_GetClass(library, name);
  return Dart_New(clazz, Dart_Null(), argCount, args);
}

//
// Peek.
//
Dart_Handle peekStringA(const char* text, intptr_t length) {
  char* string = NULL;
  if (length > 0) {
    string = (char*)Dart_ScopeAllocate(length);
    strncpy(string, text, length);
    string[length - 1] = '\0';
  }
  return string == NULL ? Dart_Null() : Dart_NewStringFromCString(string);
}

Dart_Handle peekSqlDate(SQL_DATE_STRUCT* date) {
  Dart_Handle args[] = {
    Dart_NewInteger(date->year),
    Dart_NewInteger(date->month),
    Dart_NewInteger(date->day)
  };
  return newObject("SqlDate", args, ARRAY_SIZE(args));
}

Dart_Handle peekSqlTime(SQL_TIME_STRUCT* time) {
  Dart_Handle args[] = {
    Dart_NewInteger(time->hour),
    Dart_NewInteger(time->minute),
    Dart_NewInteger(time->second)
  };
  return newObject("SqlTime", args, ARRAY_SIZE(args));
}

Dart_Handle peekSqlTimestamp(SQL_TIMESTAMP_STRUCT* timestamp) {
  Dart_Handle args[] = {
    Dart_NewInteger(timestamp->year),
    Dart_NewInteger(timestamp->month),
    Dart_NewInteger(timestamp->day),
    Dart_NewInteger(timestamp->hour),
    Dart_NewInteger(timestamp->minute),
    Dart_NewInteger(timestamp->second),
    Dart_NewInteger(timestamp->fraction)
  };
  return newObject("SqlTimestamp", args, ARRAY_SIZE(args));
}

Dart_Handle peekSqlNumeric(SQL_NUMERIC_STRUCT* numeric) {
  intptr_t length = ARRAY_SIZE(numeric->val);
  Dart_Handle val = Dart_NewList(length);
  for (int i = 0; i < length; ++ i) {
    Dart_ListSetAt(val, i, Dart_NewInteger(numeric->val[i]));
  }
  Dart_Handle args[] = {
    Dart_NewInteger(numeric->precision),
    Dart_NewInteger(numeric->scale),
    Dart_NewInteger(numeric->sign),
    val
  };
  return newObject("SqlNumeric", args, ARRAY_SIZE(args));
}

Dart_Handle peekSqlGuid(SQLGUID* guid) {
  intptr_t length = ARRAY_SIZE(guid->Data4);
  Dart_Handle data4 = Dart_NewList(length);
  for (int i = 0; i < length; ++ i) {
    Dart_ListSetAt(data4, i, Dart_NewInteger(guid->Data4[i]));
  }
  Dart_Handle args[] = {
    Dart_NewInteger(guid->Data1),
    Dart_NewInteger(guid->Data2),
    Dart_NewInteger(guid->Data3),
    data4
  };
  return newObject("SqlGuid", args, ARRAY_SIZE(args));
}

Dart_Handle peekSqlInterval(SQL_INTERVAL_STRUCT* interval) {
  Dart_Handle yearMonth = Dart_Null();
  Dart_Handle daySecond = Dart_Null();
  switch(interval->interval_sign) {
    case SQL_IS_YEAR:
    case SQL_IS_MONTH:
    case SQL_IS_YEAR_TO_MONTH: {
        Dart_Handle args[] = {
          Dart_NewInteger(interval->intval.year_month.year),
          Dart_NewInteger(interval->intval.year_month.month)
        };
        yearMonth = newObject("SqlYearMonth", args, ARRAY_SIZE(args));
      }
      break;
    default: {
        Dart_Handle args[] = {
          Dart_NewInteger(interval->intval.day_second.day),
          Dart_NewInteger(interval->intval.day_second.hour),
          Dart_NewInteger(interval->intval.day_second.minute),
          Dart_NewInteger(interval->intval.day_second.second),
          Dart_NewInteger(interval->intval.day_second.fraction)
        };
        daySecond = newObject("SqlDaySecond", args, ARRAY_SIZE(args));
      }
      break;
  }
  Dart_Handle args[] = {
    Dart_NewInteger(interval->interval_type),
    Dart_NewInteger(interval->interval_sign),
    yearMonth,
    daySecond
  };
  return newObject("SqlInterval", args, ARRAY_SIZE(args));
}

Dart_Handle peek(void* peer, int64_t ctype, intptr_t length) {
  switch(ctype) {
    //case SQL_C_TCHAR:
    case SQL_C_CHAR:
      return peekStringA((const char*)peer, length);
    case SQL_C_BINARY:
    //case SQL_C_VARBOOKMARK:
      return Dart_NewInteger(*(SQLCHAR*)peer);
    case SQL_C_BIT:
    case SQL_C_TINYINT:
    case SQL_C_UTINYINT:
      return Dart_NewInteger(*(SQLCHAR*)peer); 
    case SQL_C_STINYINT:
      return Dart_NewInteger(*(SQLSCHAR*)peer);
    //case SQL_C_TCHAR:
    case SQL_C_WCHAR:
      return Dart_Null(); //TODO peekStringW
    case SQL_C_SHORT:
    case SQL_C_SSHORT:
      return Dart_NewInteger(*(SQLSMALLINT*)peer);
    case SQL_C_USHORT:
      return Dart_NewInteger(*(SQLUSMALLINT*)peer);
    case SQL_C_LONG:
    case SQL_C_SLONG:
      return Dart_NewInteger(*(SQLINTEGER*)peer);
    case SQL_C_ULONG:
    //case SQL_C_BOOKMARK:
      return Dart_NewInteger(*(SQLUINTEGER*)peer);
    case SQL_C_FLOAT:
      return Dart_NewDouble(*(SQLREAL*)peer);
    case SQL_C_DOUBLE:
      return Dart_NewDouble(*(SQLDOUBLE*)peer);
    case SQL_C_SBIGINT:
      return Dart_NewInteger(*(SQLBIGINT*)peer);
    case SQL_C_UBIGINT:
      return Dart_NewInteger(*(SQLUBIGINT*)peer);
    case SQL_C_DATE:
    case SQL_C_TYPE_DATE:
      return peekSqlDate((SQL_DATE_STRUCT*)peer);
    case SQL_C_TIME:
    case SQL_C_TYPE_TIME:
      return peekSqlTime((SQL_TIME_STRUCT*)peer);
    case SQL_C_TIMESTAMP:
    case SQL_C_TYPE_TIMESTAMP:
      return peekSqlTimestamp((SQL_TIMESTAMP_STRUCT*)peer);
    case SQL_C_NUMERIC:
      return peekSqlNumeric((SQL_NUMERIC_STRUCT*)peer);
    case SQL_C_GUID:
      return peekSqlGuid((SQLGUID*)peer);
    case SQL_C_INTERVAL_YEAR:
    case SQL_C_INTERVAL_MONTH:
    case SQL_C_INTERVAL_DAY:
    case SQL_C_INTERVAL_HOUR:
    case SQL_C_INTERVAL_MINUTE:
    case SQL_C_INTERVAL_SECOND:
    case SQL_C_INTERVAL_YEAR_TO_MONTH:
    case SQL_C_INTERVAL_DAY_TO_HOUR:
    case SQL_C_INTERVAL_DAY_TO_MINUTE:
    case SQL_C_INTERVAL_DAY_TO_SECOND:
    case SQL_C_INTERVAL_HOUR_TO_MINUTE:
    case SQL_C_INTERVAL_HOUR_TO_SECOND:
    case SQL_C_INTERVAL_MINUTE_TO_SECOND:
      return peekSqlInterval((SQL_INTERVAL_STRUCT*)peer);
  }
  return Dart_Null();
}

//
// Poke.
//
void pokeStringA(Dart_Handle object, SQLCHAR* peer, intptr_t length) {
  const char* value = getString(object);
  if (length > 0) {
    memset((void*)peer, 0, length);
    if (value != NULL) {
      strncpy((char*)peer, value, length);
      peer[length - 1] = '\0';
    }
  }
}

void pokeSqlDate(SQL_DATE_STRUCT* date, Dart_Handle object) {
  date->year = getSqlSmallInt(GET_FIELD(object, "year"));
  date->month = getSqlUSmallInt(GET_FIELD(object, "month"));
  date->day = getSqlUSmallInt(GET_FIELD(object, "day"));
}

void pokeSqlTime(SQL_TIME_STRUCT* time, Dart_Handle object) {
  time->hour = getSqlUSmallInt(GET_FIELD(object, "hour"));
  time->minute = getSqlUSmallInt(GET_FIELD(object, "minute"));
  time->second = getSqlUSmallInt(GET_FIELD(object, "second"));
}

void pokeSqlTimestamp(SQL_TIMESTAMP_STRUCT* timestamp, Dart_Handle object) {
  timestamp->year = getSqlSmallInt(GET_FIELD(object, "year"));
  timestamp->month = getSqlUSmallInt(GET_FIELD(object, "month"));
  timestamp->day = getSqlUSmallInt(GET_FIELD(object, "day"));
  timestamp->hour = getSqlUSmallInt(GET_FIELD(object, "hour"));
  timestamp->minute = getSqlUSmallInt(GET_FIELD(object, "minute"));
  timestamp->second = getSqlUSmallInt(GET_FIELD(object, "second"));
  timestamp->fraction = getSqlUInteger(GET_FIELD(object, "fraction"));
}

void pokeSqlNumeric(SQL_NUMERIC_STRUCT* numeric, Dart_Handle object) {
  numeric->precision = getSqlChar(GET_FIELD(object, "precision"));
  numeric->scale = getSqlSChar(GET_FIELD(object, "scale"));
  numeric->sign = getSqlChar(GET_FIELD(object, "sign"));

  Dart_Handle list = GET_FIELD(object, "value");
  intptr_t length = ARRAY_SIZE(numeric->val);
  for (int i = 0; i < length; ++ i) {
    numeric->val[i] = getSqlChar(Dart_ListGetAt(list, i));
  }
}

void pokeSqlGuid(SQLGUID* guid, Dart_Handle object) {
  guid->Data1 = (unsigned long)getInteger(GET_FIELD(object, "data1"));
  guid->Data2 = (unsigned short)getInteger(GET_FIELD(object, "data2"));
  guid->Data3 = (unsigned short)getInteger(GET_FIELD(object, "data3"));

  Dart_Handle list = GET_FIELD(object, "data4");
  intptr_t length = ARRAY_SIZE(guid->Data4);
  for (int i = 0; i < length; ++ i) {
    guid->Data4[i] = (unsigned char)getInteger(Dart_ListGetAt(list, i));
  }
}

void pokeSqlInterval(SQL_INTERVAL_STRUCT* interval, Dart_Handle object) {
  interval->interval_type = (SQLINTERVAL)getInteger(GET_FIELD(object, "type"));
  interval->interval_sign = getSqlUSmallInt(GET_FIELD(object, "sign"));

  switch(interval->interval_sign) {
    case SQL_IS_YEAR:
    case SQL_IS_MONTH:
    case SQL_IS_YEAR_TO_MONTH: {
        Dart_Handle yearMonth = GET_FIELD(object, "yearMonth");
        if (!Dart_IsNull(yearMonth)) {
          interval->intval.year_month.year = getSqlUInteger(GET_FIELD(yearMonth, "year"));
          interval->intval.year_month.month = getSqlUInteger(GET_FIELD(yearMonth, "month"));
        }
      }
      break;
    default: {
        Dart_Handle daySecond = GET_FIELD(object, "daySecond");
        if (!Dart_IsNull(daySecond)) {
          interval->intval.day_second.day = getSqlUInteger(GET_FIELD(daySecond, "day"));
          interval->intval.day_second.hour = getSqlUInteger(GET_FIELD(daySecond, "hour"));
          interval->intval.day_second.minute = getSqlUInteger(GET_FIELD(daySecond, "minute"));
          interval->intval.day_second.second = getSqlUInteger(GET_FIELD(daySecond, "second"));
          interval->intval.day_second.fraction = getSqlUInteger(GET_FIELD(daySecond, "fraction"));
        }
      }
      break;
  }
}

void poke(void* peer, Dart_Handle object, int64_t ctype, intptr_t length) {
  switch(ctype) {
    //case SQL_C_TCHAR:
    case SQL_C_CHAR:
      pokeStringA(object, (SQLCHAR*)peer, length);
      break;
    case SQL_C_BINARY:
    //case SQL_C_VARBOOKMARK:
      *(SQLCHAR*)peer = (SQLCHAR)getInteger(object);
      break;
    case SQL_C_BIT:
    case SQL_C_TINYINT:
    case SQL_C_UTINYINT:
      *(SQLCHAR*)peer = (SQLCHAR)getInteger(object);
      break;
    case SQL_C_STINYINT:
      *(SQLSCHAR*)peer = (SQLSCHAR)getInteger(object);
      break;
    //case SQL_C_TCHAR:
    case SQL_C_WCHAR:
      break; //TODO pokeStringW
    case SQL_C_SHORT:
    case SQL_C_SSHORT:
      *(SQLSMALLINT*)peer = (SQLSMALLINT)getInteger(object);
      break;
    case SQL_C_USHORT:
      *(SQLUSMALLINT*)peer = (SQLUSMALLINT)getInteger(object);
      break;
    case SQL_C_LONG:
    case SQL_C_SLONG:
      *(SQLINTEGER*)peer = (SQLINTEGER)getInteger(object);
      break;
    case SQL_C_ULONG:
    //case SQL_C_BOOKMARK:
      *(SQLUINTEGER*)peer = (SQLUINTEGER)getInteger(object);
      break;
    case SQL_C_FLOAT:
      *(SQLREAL*)peer = (SQLREAL)getDouble(object);
      break;
    case SQL_C_DOUBLE:
      *(SQLDOUBLE*)peer = (SQLDOUBLE)getDouble(object);
      break;
    case SQL_C_SBIGINT:
      *(SQLBIGINT*)peer = (SQLBIGINT)getInteger(object);
      break;
    case SQL_C_UBIGINT:
      *(SQLUBIGINT*)peer = (SQLUBIGINT)getInteger(object);
      break;
    case SQL_C_DATE:
    case SQL_C_TYPE_DATE:
      pokeSqlDate((SQL_DATE_STRUCT*)peer, object);
      break;
    case SQL_C_TIME:
    case SQL_C_TYPE_TIME:
      pokeSqlTime((SQL_TIME_STRUCT*)peer, object);
      break;
    case SQL_C_TIMESTAMP:
    case SQL_C_TYPE_TIMESTAMP:
      pokeSqlTimestamp((SQL_TIMESTAMP_STRUCT*)peer, object);
      break;
    case SQL_C_NUMERIC:
      pokeSqlNumeric((SQL_NUMERIC_STRUCT*)peer, object);
      break;
    case SQL_C_GUID:
      pokeSqlGuid((SQLGUID*)peer, object);
      break;
    case SQL_C_INTERVAL_YEAR:
    case SQL_C_INTERVAL_MONTH:
    case SQL_C_INTERVAL_DAY:
    case SQL_C_INTERVAL_HOUR:
    case SQL_C_INTERVAL_MINUTE:
    case SQL_C_INTERVAL_SECOND:
    case SQL_C_INTERVAL_YEAR_TO_MONTH:
    case SQL_C_INTERVAL_DAY_TO_HOUR:
    case SQL_C_INTERVAL_DAY_TO_MINUTE:
    case SQL_C_INTERVAL_DAY_TO_SECOND:
    case SQL_C_INTERVAL_HOUR_TO_MINUTE:
    case SQL_C_INTERVAL_HOUR_TO_SECOND:
    case SQL_C_INTERVAL_MINUTE_TO_SECOND:
      pokeSqlInterval((SQL_INTERVAL_STRUCT*)peer, object);
      break;
  }
}

//
// Memory allocation/deallocation.
//
uint8_t* allocate(size_t size) {
  return new uint8_t[size]();
}

void deallocate(void* peer) {
  delete [] (uint8_t*)(peer);
}

void finalizerCallback(Dart_Handle handle, void* peer) {
  if (peer != NULL) {
    deallocate(peer);
  }
  Dart_DeletePersistentHandle(handle);
}

//
// Deferred buffers.
//
intptr_t rowSize(Dart_Handle container) {
  intptr_t size = 0;

  Dart_Handle types = UNBOX_TYPES(container);
  intptr_t cols = 0;
  Dart_ListLength(types, &cols);
  for (intptr_t i = 0; i < cols; ++ i) {
    Dart_Handle typelen = Dart_ListGetAt(types, i);
    int64_t type = UNBOX_CTYPE(typelen);
    intptr_t len = UNBOX_LENGTH(typelen);

    size += sizeofCType(type) * len;
  }

  return size;
}

void* address(Dart_Handle container, int64_t row, int64_t col,
              int64_t& ctype, intptr_t& length) {
  void* peer = NULL;
  Dart_Handle buffer = UNBOX_BUFFER(container);
  Dart_ExternalTypedDataGetPeer(buffer, &peer);

  intptr_t size = 0;
  intptr_t colOffset = 0;

  Dart_Handle types = UNBOX_TYPES(container);
  intptr_t cols = 0;
  Dart_ListLength(types, &cols);
  for (intptr_t i = 0; i < cols; ++ i) {
    Dart_Handle typelen = Dart_ListGetAt(types, i);
    int64_t type = UNBOX_CTYPE(typelen);
    intptr_t len = UNBOX_LENGTH(typelen);

    intptr_t colSize = sizeofCType(type) * len;
    if (i < col) {
      colOffset += colSize;
    }
    if (i == col) {
      ctype = type;
      length = len;
    }
    size += colSize;
  }

  return (uint8_t*)peer + (size * row) + colOffset;
}
