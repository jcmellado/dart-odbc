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

class SqlDate {
  int year;
  int month;
  int day;

  SqlDate(this.year, this.month, this.day);
}

class SqlTime {
  int hour;
  int minute;
  int second;

  SqlTime(this.hour, this.minute, this.second);
}

class SqlTimestamp {
  int year;
  int month;
  int day;
  int hour;
  int minute;
  int second;
  int fraction;

  SqlTimestamp(this.year, this.month, this.day,
               this.hour, this.minute, this.second,
               this.fraction);
}

const int SQL_IS_YEAR             = 1;
const int SQL_IS_MONTH            = 2;
const int SQL_IS_DAY              = 3;
const int SQL_IS_HOUR             = 4;
const int SQL_IS_MINUTE           = 5;
const int SQL_IS_SECOND           = 6;
const int SQL_IS_YEAR_TO_MONTH    = 7;
const int SQL_IS_DAY_TO_HOUR      = 8;
const int SQL_IS_DAY_TO_MINUTE    = 9;
const int SQL_IS_DAY_TO_SECOND    = 10;
const int SQL_IS_HOUR_TO_MINUTE   = 11;
const int SQL_IS_HOUR_TO_SECOND   = 12;
const int SQL_IS_MINUTE_TO_SECOND = 13;

class SqlYearMonth {
  int year;
  int month;

  SqlYearMonth(this.year, this.month);
}

class SqlDaySecond {
  int day;
  int hour;
  int minute;
  int second;
  int fraction;

  SqlDaySecond(this.day, this.hour, this.minute, this.second, this.fraction);
}

class SqlInterval {
  int type;
  int sign;

  SqlYearMonth yearMonth;
  SqlDaySecond daySecond;

  SqlInterval(this.type, this.sign, this.yearMonth, this.daySecond);
}

const int SQL_MAX_NUMERIC_LEN = 16;

class SqlNumeric {
  int precision;
  int scale;
  int sign;
  List<int> value;

  SqlNumeric(this.precision, this.scale, this.sign, this.value);
}

class SqlGuid {
  int data1;
  int data2;
  int data3;
  List<int> data4;

  SqlGuid(this.data1, this.data2, this.data3, this.data4);
}

