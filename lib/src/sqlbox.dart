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

part of odbc;

//
// Type and length.
//
class TypeLen {
  final int _ctype;
  final int _length;

  TypeLen(this._ctype, [this._length = 1]) {
    assert(_ctype != null);
    assert((_length != null) && (_length > 0));
  }

  factory TypeLen.clone(TypeLen object) {
    assert(object != null);

    return new TypeLen(object._ctype, object._length);
  }

  int get ctype => _ctype;
  int get length => _length;
}

// Instant values.
abstract class SqlBox<T> extends TypeLen {
  T value;

  SqlBox(int ctype, [int length = 1]) : super(ctype, length);

  String toString() => value.toString();
}

// Deferred buffers.
abstract class SqlBuffer<T> {
  final List<TypeLen> _types;
  final int _rows;

  dynamic _buffer;

  SqlBuffer(int ctype, [int length = 1, this._rows = 1])
      : this._types = <TypeLen>[new TypeLen(ctype, length)] {
    assert((_rows != null) && (_rows > 0));

    _sqlAllocate(this);
  }

  SqlBuffer.array(List<TypeLen> types, [this._rows = 1])
      : this._types = types.map((e) => new TypeLen.clone(e)).toList() {
    assert(!types.isEmpty);
    assert((_rows != null) && (_rows > 0));

    _sqlAllocate(this);
  }

  int get rows => _rows;
  int get cols => _types.length;

  int rowSize() => _sqlRowSize(this);

  int ctype([int col = 0]) {
    assert((col != null) && (col >= 0) && (col < _types.length));

    return _types[col].ctype;
  }

  int length([int col = 0]) {
    assert((col != null) && (col >= 0) && (col < _types.length));

    return _types[col].length;
  }

  void poke(T value, [int row = 0, int col = 0]) {
    assert((row != null) && (row >= 0) && (row < _rows));
    assert((col != null) && (col >= 0) && (col < _types.length));

    _sqlPoke(this, row, col, value);
  }

  T peek([int row = 0, int col = 0]) {
    assert((row != null) && (row >= 0) && (row < _rows));
    assert((col != null) && (col >= 0) && (col < _types.length));

    return _sqlPeek(this, row, col);
  }

  SqlPointer address([int row = 0, int col = 0]) {
    assert((row != null) && (row >= 0) && (row < _rows));
    assert((col != null) && (col >= 0) && (col < _types.length));

    return new SqlPointer()..value = _sqlAddress(this, row, col);
  }

  String toString() => _buffer.toString();
}

//
// Convenient types, use them as much as possible.
//
class SqlInt extends SqlBox<int> {
  SqlInt() : super(SQL_C_SLONG);
}

class SqlString extends SqlBox<String> {
  SqlString(int length) : super(SQL_C_TCHAR, length);
}

class SqlHandle extends SqlBox<int> {
  SqlHandle() : super(SQL_C_ULONG);

  bool isValid() => value != null;

  void invalidate() {
    value = null;
  }
}

class SqlPointer extends SqlBox<int> {
  SqlPointer() : super(SQL_C_ULONG);
}

class SqlIntBuffer extends SqlBuffer<int> {
  SqlIntBuffer([int rows = 1]) : super(SQL_C_SLONG, 1, rows);
}

class SqlStringBuffer extends SqlBuffer<String> {
  SqlStringBuffer(int length, [int rows = 1]) : super(SQL_C_TCHAR, length, rows);
}

class SqlArrayBuffer extends SqlBuffer<dynamic> {
  SqlArrayBuffer(List<TypeLen> types, [int rows = 1]) : super.array(types, rows);
}

//
// Instant values.
//
class SqlCharBox extends SqlBox<String> {
  SqlCharBox(int length) : super(SQL_C_CHAR, length);
}
class SqlWCharBox extends SqlBox<String> {
  SqlWCharBox(int length) : super(SQL_C_WCHAR, length);
}
class SqlShortBox extends SqlBox<int> {
  SqlShortBox() : super(SQL_C_SHORT);
}
class SqlSShortBox extends SqlBox<int> {
  SqlSShortBox() : super(SQL_C_SSHORT);
}
class SqlSmallIntBox extends SqlBox<int> {
  SqlSmallIntBox() : super(SQL_C_SSHORT);
}
class SqlUShortBox extends SqlBox<int> {
  SqlUShortBox() : super(SQL_C_USHORT);
}
class SqlUSmallIntBox extends SqlBox<int> {
  SqlUSmallIntBox() : super(SQL_C_USHORT);
}
class SqlLongBox extends SqlBox<int> {
  SqlLongBox() : super(SQL_C_LONG);
}
class SqlSLongBox extends SqlBox<int> {
  SqlSLongBox() : super(SQL_C_SLONG);
}
class SqlIntegerBox extends SqlBox<int> {
  SqlIntegerBox() : super(SQL_C_SLONG);
}
class SqlULongBox extends SqlBox<int> {
  SqlULongBox() : super(SQL_C_ULONG);
}
class SqlUIntegerBox extends SqlBox<int> {
  SqlUIntegerBox() : super(SQL_C_ULONG);
}
class SqlFloatBox extends SqlBox<double> {
  SqlFloatBox() : super(SQL_C_FLOAT);
}
class SqlRealBox extends SqlBox<double> {
  SqlRealBox() : super(SQL_C_FLOAT);
}
class SqlDoubleBox extends SqlBox<double> {
  SqlDoubleBox() : super(SQL_C_DOUBLE);
}
class SqlBitBox extends SqlBox<int> {
  SqlBitBox() : super(SQL_C_BIT);
}
class SqlTinyIntBox extends SqlBox<int> {
  SqlTinyIntBox() : super(SQL_C_TINYINT);
}
class SqlSTinyIntBox extends SqlBox<int> {
  SqlSTinyIntBox() : super(SQL_C_STINYINT);
}
class SqlUTinyIntBox extends SqlBox<int> {
  SqlUTinyIntBox() : super(SQL_C_UTINYINT);
}
class SqlSBigIntBox extends SqlBox<int> {
  SqlSBigIntBox() : super(SQL_C_SBIGINT);
}
class SqlUBigIntBox extends SqlBox<int> {
  SqlUBigIntBox() : super(SQL_C_UBIGINT);
}
class SqlBinaryBox extends SqlBox<int> {
  SqlBinaryBox(int length) : super(SQL_C_CHAR, length);
}
class SqlBookmarkBox extends SqlBox<int> {
  SqlBookmarkBox() : super(SQL_C_BOOKMARK);
}
class SqlVarBookmarkBox extends SqlBox<String> {
  SqlVarBookmarkBox(int length) : super(SQL_C_VARBOOKMARK, length);
}
class SqlDateBox extends SqlBox<SqlDate> {
  SqlDateBox() : super(ODBC_VERSION < 0x0300 ? SQL_C_DATE : SQL_C_TYPE_DATE);
}
class SqlTimeBox extends SqlBox<SqlTime> {
  SqlTimeBox() : super(ODBC_VERSION < 0x0300 ? SQL_C_TIME : SQL_C_TYPE_TIME);
}
class SqlTimestampBox extends SqlBox<SqlTimestamp> {
  SqlTimestampBox() : super(ODBC_VERSION < 0x0300 ? SQL_C_TIMESTAMP : SQL_C_TYPE_TIMESTAMP);
}
class SqlNumericBox extends SqlBox<SqlNumeric> {
  SqlNumericBox() : super(SQL_C_NUMERIC);
}
class SqlGuidBox extends SqlBox<SqlGuid> {
  SqlGuidBox() : super(SQL_C_GUID);
}
class SqlIntervalBox extends SqlBox<SqlInterval> {
  SqlIntervalBox(int type) : super(type);
}

//
// Deferred buffers.
//
class SqlCharBuffer extends SqlBuffer<String> {
  SqlCharBuffer(int length, [int rows = 1]) : super(SQL_C_CHAR, length, rows);
}
class SqlWCharBuffer extends SqlBuffer<String> {
  SqlWCharBuffer(int length, [int rows = 1]) : super(SQL_C_WCHAR, length, rows);
}
class SqlShortBuffer extends SqlBuffer<int> {
  SqlShortBuffer([int rows = 1]) : super(SQL_C_SHORT, 1, rows);
}
class SqlSShortBuffer extends SqlBuffer<int> {
  SqlSShortBuffer([int rows = 1]) : super(SQL_C_SSHORT, 1, rows);
}
class SqlSmallIntBuffer extends SqlBuffer<int> {
  SqlSmallIntBuffer([int rows = 1]) : super(SQL_C_SSHORT, 1, rows);
}
class SqlUShortBuffer extends SqlBuffer<int> {
  SqlUShortBuffer([int rows = 1]) : super(SQL_C_USHORT, 1, rows);
}
class SqlUSmallIntBuffer extends SqlBuffer<int> {
  SqlUSmallIntBuffer([int rows = 1]) : super(SQL_C_USHORT, 1, rows);
}
class SqlLongBuffer extends SqlBuffer<int> {
  SqlLongBuffer([int rows = 1]) : super(SQL_C_LONG, 1, rows);
}
class SqlSLongBuffer extends SqlBuffer<int> {
  SqlSLongBuffer([int rows = 1]) : super(SQL_C_SLONG, 1, rows);
}
class SqlIntegerBuffer extends SqlBuffer<int> {
  SqlIntegerBuffer([int rows = 1]) : super(SQL_C_SLONG, 1, rows);
}
class SqlULongBuffer extends SqlBuffer<int> {
  SqlULongBuffer([int rows = 1]) : super(SQL_C_ULONG, 1, rows);
}
class SqlUIntegerBuffer extends SqlBuffer<int> {
  SqlUIntegerBuffer([int rows = 1]) : super(SQL_C_ULONG, 1, rows);
}
class SqlFloatBuffer extends SqlBuffer<double> {
  SqlFloatBuffer([int rows = 1]) : super(SQL_C_FLOAT, 1, rows);
}
class SqlRealBuffer extends SqlBuffer<double> {
  SqlRealBuffer([int rows = 1]) : super(SQL_C_FLOAT, 1, rows);
}
class SqlDoubleBuffer extends SqlBuffer<double> {
  SqlDoubleBuffer([int rows = 1]) : super(SQL_C_DOUBLE, 1, rows);
}
class SqlBitBuffer extends SqlBuffer<int> {
  SqlBitBuffer([int rows = 1]) : super(SQL_C_BIT, 1, rows);
}
class SqlTinyIntBuffer extends SqlBuffer<int> {
  SqlTinyIntBuffer([int rows = 1]) : super(SQL_C_TINYINT, 1, rows);
}
class SqlSTinyIntBuffer extends SqlBuffer<int> {
  SqlSTinyIntBuffer([int rows = 1]) : super(SQL_C_STINYINT, 1, rows);
}
class SqlUTinyIntBuffer extends SqlBuffer<int> {
  SqlUTinyIntBuffer([int rows = 1]) : super(SQL_C_UTINYINT, 1, rows);
}
class SqlSBigIntBuffer extends SqlBuffer<int> {
  SqlSBigIntBuffer([int rows = 1]) : super(SQL_C_SBIGINT, 1, rows);
}
class SqlUBigIntBuffer extends SqlBuffer<int> {
  SqlUBigIntBuffer([int rows = 1]) : super(SQL_C_UBIGINT, 1, rows);
}
class SqlBinaryBuffer extends SqlBuffer<int> {
  SqlBinaryBuffer([int rows = 1]) : super(SQL_C_BINARY, 1, rows);
}
class SqlBookmarkBuffer extends SqlBuffer<int> {
  SqlBookmarkBuffer([int rows = 1]) : super(SQL_C_BOOKMARK, 1, rows);
}
class SqlVarBookmarkBuffer extends SqlBuffer<String> {
  SqlVarBookmarkBuffer(int length, [int rows = 1])
    : super(SQL_C_VARBOOKMARK, length, rows);
}
class SqlDateBuffer extends SqlBuffer<SqlDate> {
  SqlDateBuffer([int rows = 1])
    : super(ODBC_VERSION < 0x0300 ? SQL_C_DATE : SQL_C_TYPE_DATE, 1, rows);
}
class SqlTimeBuffer extends SqlBuffer<SqlTime> {
  SqlTimeBuffer([int rows = 1])
    : super(ODBC_VERSION < 0x0300 ? SQL_C_TIME : SQL_C_TYPE_TIME, 1, rows);
}
class SqlTimestampBuffer extends SqlBuffer<SqlTimestamp> {
  SqlTimestampBuffer([int rows = 1])
    : super(ODBC_VERSION < 0x0300 ? SQL_C_TIMESTAMP : SQL_C_TYPE_TIMESTAMP, 1, rows);
}
class SqlNumericBuffer extends SqlBuffer<SqlNumeric> {
  SqlNumericBuffer([int rows = 1]) : super(SQL_C_NUMERIC, 1, rows);
}
class SqlGuidBuffer extends SqlBuffer<SqlGuid> {
  SqlGuidBuffer([int rows = 1]) : super(SQL_C_GUID, 1, rows);
}
class SqlIntervalBuffer extends SqlBuffer<SqlInterval> {
  SqlIntervalBuffer(int type, [int rows = 1]) : super(type, 1, rows);
}

//
// Window handle.
//
class SqlHWnd extends SqlBox<int> {
  SqlHWnd() : super(SQL_C_ULONG);
}
