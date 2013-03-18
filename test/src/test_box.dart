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

abstract class TestBox {

  static void run() {

    group("Box", () {

      test("SqlIntBox", () {
        var box = new SqlInt();

        expect(box.ctype, isNotNull, reason: "C type value is no set");
        expect(box.length, equals(1), reason: "length value is not 1");
        expect(box.value, isNull, reason: "Initial value is not null");

        box.value = 123;
        expect(box.value, equals(123));
        box.value = -123;
        expect(box.value, equals(-123));
        box.value = null;
        expect(box.value, isNull);
      });

      test("SqlStringBox", () {
        var box = new SqlString(16);

        expect(box.ctype, isNotNull, reason: "C type value is no set");
        expect(box.length, equals(16), reason: "length value is not set");
        expect(box.value, isNull, reason: "Initial value is not null");

        box.value = "text";
        expect(box.value, equals("text"));
        box.value = "";
        expect(box.value, equals(""));
        box.value = null;
        expect(box.value, isNull);
      });

      test("SqlHandle", () {
        var handle = new SqlHandle();

        expect(handle.isValid(), isFalse, reason: "Initial handle is valid");
        handle.value = 123;
        expect(handle.isValid(), isTrue, reason: "Handle is not valid");
        handle.invalidate();
        expect(handle.isValid(), isFalse, reason: "Handle is still valid");
      });

      test("SqlIntBuffer", () {
        var buffer = new SqlIntBuffer();

        expect(buffer.rows, equals(1), reason: "rows value is not 1");
        expect(buffer.cols, equals(1), reason: "cols value is not 1");

        expect(buffer.ctype, isNotNull, reason: "C type value is no set");
        expect(buffer.ctype(), equals(buffer.ctype(0)));

        expect(buffer.length(), equals(1), reason: "length value is not 1");
        expect(buffer.length(0), equals(buffer.length()));

        expect(buffer.rowSize(), isNotNull, reason: "Row size value is null");
        expect(buffer.rowSize(), greaterThan(0), reason: "Row size value is negative");

        expect(buffer.address().value, isNotNull, reason: "Buffer address value is null");
        expect(buffer.address().value, isNonZero, reason: "Buffer address value is 0");
        expect(buffer.address().value, equals(buffer.address(0).value));
        expect(buffer.address(0).value, equals(buffer.address(0, 0).value));

        expect(buffer.peek(), equals(0), reason: "Initial value is not set");
        expect(buffer.peek(0), equals(buffer.peek()));
        expect(buffer.peek(0, 0), equals(buffer.peek(0)));

        buffer.poke(123);
        expect(buffer.peek(), equals(123));
        expect(buffer.peek(0), equals(buffer.peek()));
        expect(buffer.peek(0, 0), equals(buffer.peek(0)));
        buffer.poke(-123);
        expect(buffer.peek(), equals(-123));
        expect(buffer.peek(0), equals(buffer.peek()));
        expect(buffer.peek(0, 0), equals(buffer.peek(0)));
        buffer.poke(123, 0);
        expect(buffer.peek(), equals(123));
        expect(buffer.peek(0), equals(buffer.peek()));
        expect(buffer.peek(0, 0), equals(buffer.peek(0)));
        buffer.poke(-123, 0, 0);
        expect(buffer.peek(), equals(-123));
        expect(buffer.peek(0), equals(buffer.peek()));
        expect(buffer.peek(0, 0), equals(buffer.peek(0)));
        buffer.poke(null);
        expect(buffer.peek(), equals(0));
        expect(buffer.peek(0), equals(buffer.peek()));
        expect(buffer.peek(0, 0), equals(buffer.peek(0)));

        expect(() => buffer.ctype(-1), throws);
        expect(() => buffer.ctype(1), throws);
        expect(() => buffer.length(-1), throws);
        expect(() => buffer.length(1), throws);
        expect(() => buffer.address(-1), throws);
        expect(() => buffer.address(1), throws);
        expect(() => buffer.peek(-1), throws);
        expect(() => buffer.peek(1), throws);
        expect(() => buffer.poke(null, -1), throws);
        expect(() => buffer.poke(null, 1), throws);
      });

      test("SqlStringBuffer", () {
        var buffer = new SqlStringBuffer(16);

        expect(buffer.rows, equals(1), reason: "rows value is not 1");
        expect(buffer.cols, equals(1), reason: "cols value is not 1");

        expect(buffer.ctype, isNotNull, reason: "C type value is no set");
        expect(buffer.ctype(), equals(buffer.ctype(0)));

        expect(buffer.length(), equals(16), reason: "length value is not set");
        expect(buffer.length(0), equals(buffer.length()));

        expect(buffer.rowSize(), isNotNull, reason: "Row size value is null");
        expect(buffer.rowSize(), isPositive, reason: "Row size value is negative");

        expect(buffer.address().value, isNotNull, reason: "Buffer address value is null");
        expect(buffer.address().value, isNonZero, reason: "Buffer address value is 0");
        expect(buffer.address().value, equals(buffer.address(0).value));
        expect(buffer.address(0).value, equals(buffer.address(0, 0).value));

        expect(buffer.peek(), equals(""), reason: "Initial value is not set");
        expect(buffer.peek(0), equals(buffer.peek()));
        expect(buffer.peek(0, 0), equals(buffer.peek(0)));

        buffer.poke("text");
        expect(buffer.peek(), equals("text"));
        expect(buffer.peek(0), equals(buffer.peek()));
        expect(buffer.peek(0, 0), equals(buffer.peek(0)));
        buffer.poke("abc");
        expect(buffer.peek(), equals("abc"));
        expect(buffer.peek(0), equals(buffer.peek()));
        expect(buffer.peek(0, 0), equals(buffer.peek(0)));
        buffer.poke("text", 0);
        expect(buffer.peek(), equals("text"));
        expect(buffer.peek(0), equals(buffer.peek()));
        expect(buffer.peek(0, 0), equals(buffer.peek(0)));
        buffer.poke("abc", 0, 0);
        expect(buffer.peek(), equals("abc"));
        expect(buffer.peek(0), equals(buffer.peek()));
        expect(buffer.peek(0, 0), equals(buffer.peek(0)));
        buffer.poke(null);
        expect(buffer.peek(), equals(""));
        expect(buffer.peek(0), equals(buffer.peek()));
        expect(buffer.peek(0, 0), equals(buffer.peek(0)));

        expect(() => buffer.ctype(-1), throws);
        expect(() => buffer.ctype(1), throws);
        expect(() => buffer.length(-1), throws);
        expect(() => buffer.length(1), throws);
        expect(() => buffer.address(-1), throws);
        expect(() => buffer.address(1), throws);
        expect(() => buffer.peek(-1), throws);
        expect(() => buffer.peek(1), throws);
        expect(() => buffer.poke(null, -1), throws);
        expect(() => buffer.poke(null, 1), throws);
      });

      test("SqlIntBuffer - N rows", () {
        var buffer = new SqlIntBuffer(3);

        expect(buffer.rows, equals(3), reason: "rows value is not set");
        expect(buffer.cols, equals(1), reason: "cols value is not 1");

        expect(buffer.ctype, isNotNull, reason: "C type value is no set");
        expect(buffer.ctype(), equals(buffer.ctype(0)));

        expect(buffer.length(), equals(1), reason: "length value is not 1");
        expect(buffer.length(), equals(buffer.length(0)));

        expect(buffer.rowSize(), isNotNull, reason: "Row size value is null");
        expect(buffer.rowSize(), greaterThan(0), reason: "Row size value is negative");

        expect(buffer.address().value, isNotNull, reason: "Buffer address value is null");
        expect(buffer.address().value, isNonZero, reason: "Buffer address value is 0");
        expect(buffer.address().value, equals(buffer.address(0).value));
        expect(buffer.address(0).value, equals(buffer.address(0, 0).value));
        expect(buffer.address(1).value, equals(buffer.address(1, 0).value));
        expect(buffer.address(2).value, equals(buffer.address(2, 0).value));

        expect(buffer.peek(), equals(0), reason: "Initial value is not set");
        expect(buffer.peek(0), equals(buffer.peek()));
        expect(buffer.peek(0, 0), equals(buffer.peek(0)));
        expect(buffer.peek(1), equals(0), reason: "Initial value is not set");
        expect(buffer.peek(1, 0), equals(buffer.peek(1)));
        expect(buffer.peek(2), equals(0), reason: "Initial value is not set");
        expect(buffer.peek(2, 0), equals(buffer.peek(2)));

        buffer.poke(123);
        expect(buffer.peek(), equals(123));
        expect(buffer.peek(0), equals(buffer.peek()));
        expect(buffer.peek(0, 0), equals(buffer.peek(0)));
        expect(buffer.peek(1), equals(0));
        expect(buffer.peek(2), equals(0));
        buffer.poke(-123, 0);
        expect(buffer.peek(), equals(-123));
        expect(buffer.peek(1), equals(0));
        expect(buffer.peek(2), equals(0));
        buffer.poke(123, 0, 0);
        expect(buffer.peek(), equals(123));
        expect(buffer.peek(1), equals(0));
        expect(buffer.peek(2), equals(0));
        buffer.poke(999, 2);
        expect(buffer.peek(), equals(123));
        expect(buffer.peek(1), equals(0));
        expect(buffer.peek(2), equals(999));
        expect(buffer.peek(2, 0), equals(buffer.peek(2)));
        buffer.poke(-999, 2, 0);
        expect(buffer.peek(), equals(123));
        expect(buffer.peek(1), equals(0));
        expect(buffer.peek(2), equals(-999));
        expect(buffer.peek(2, 0), equals(buffer.peek(2)));
        buffer.poke(null);
        expect(buffer.peek(), equals(0));
        expect(buffer.peek(0, 0), equals(buffer.peek(0)));
        expect(buffer.peek(1), equals(0));
        expect(buffer.peek(2), equals(-999));

        expect(() => buffer.ctype(-1), throws);
        expect(() => buffer.ctype(3), throws);
        expect(() => buffer.length(-1), throws);
        expect(() => buffer.length(3), throws);
        expect(() => buffer.address(-1), throws);
        expect(() => buffer.address(3), throws);
        expect(() => buffer.peek(-1), throws);
        expect(() => buffer.peek(3), throws);
        expect(() => buffer.poke(null, -1), throws);
        expect(() => buffer.poke(null, 3), throws);
      });

      test("SqlStringBuffer - N rows", () {
        var buffer = new SqlStringBuffer(16, 3);

        expect(buffer.rows, equals(3), reason: "rows value is not set");
        expect(buffer.cols, equals(1), reason: "cols value is not 1");

        expect(buffer.ctype, isNotNull, reason: "C type value is no set");
        expect(buffer.ctype(), equals(buffer.ctype(0)));

        expect(buffer.length(), equals(16), reason: "length value is not set");
        expect(buffer.length(), equals(buffer.length(0)));

        expect(buffer.rowSize(), isNotNull, reason: "Row size value is null");
        expect(buffer.rowSize(), greaterThan(0), reason: "Row size value is negative");

        expect(buffer.address().value, isNotNull, reason: "Buffer address value is null");
        expect(buffer.address().value, isNonZero, reason: "Buffer address value is 0");
        expect(buffer.address().value, equals(buffer.address(0).value));
        expect(buffer.address(0).value, equals(buffer.address(0, 0).value));
        expect(buffer.address(1).value, equals(buffer.address(1, 0).value));
        expect(buffer.address(2).value, equals(buffer.address(2, 0).value));

        expect(buffer.peek(), equals(""), reason: "Initial value is not set");
        expect(buffer.peek(0), equals(buffer.peek()));
        expect(buffer.peek(0, 0), equals(buffer.peek(0)));
        expect(buffer.peek(1), equals(""), reason: "Initial value is not set");
        expect(buffer.peek(1, 0), equals(buffer.peek(1)));
        expect(buffer.peek(2), equals(""), reason: "Initial value is not set");
        expect(buffer.peek(2, 0), equals(buffer.peek(2)));

        buffer.poke("text");
        expect(buffer.peek(), equals("text"));
        expect(buffer.peek(0), equals(buffer.peek()));
        expect(buffer.peek(0, 0), equals(buffer.peek(0)));
        expect(buffer.peek(1), equals(""));
        expect(buffer.peek(2), equals(""));
        buffer.poke("abc", 0);
        expect(buffer.peek(), equals("abc"));
        expect(buffer.peek(1), equals(""));
        expect(buffer.peek(2), equals(""));
        buffer.poke("text", 0, 0);
        expect(buffer.peek(), equals("text"));
        expect(buffer.peek(1), equals(""));
        expect(buffer.peek(2), equals(""));
        buffer.poke("one", 2);
        expect(buffer.peek(), equals("text"));
        expect(buffer.peek(1), equals(""));
        expect(buffer.peek(2), equals("one"));
        expect(buffer.peek(2, 0), equals(buffer.peek(2)));
        buffer.poke("two", 2, 0);
        expect(buffer.peek(), equals("text"));
        expect(buffer.peek(1), equals(""));
        expect(buffer.peek(2), equals("two"));
        expect(buffer.peek(2, 0), equals(buffer.peek(2)));
        buffer.poke(null);
        expect(buffer.peek(), equals(""));
        expect(buffer.peek(0, 0), equals(buffer.peek(0)));
        expect(buffer.peek(1), equals(""));
        expect(buffer.peek(2), equals("two"));

        expect(() => buffer.ctype(-1), throws);
        expect(() => buffer.ctype(3), throws);
        expect(() => buffer.length(-1), throws);
        expect(() => buffer.length(3), throws);
        expect(() => buffer.address(-1), throws);
        expect(() => buffer.address(3), throws);
        expect(() => buffer.peek(-1), throws);
        expect(() => buffer.peek(3), throws);
        expect(() => buffer.poke(null, -1), throws);
        expect(() => buffer.poke(null, 3), throws);
      });

      test("SqlArrayBuffer", () {
        var types = <TypeLen>[new TypeLen(SQL_C_CHAR, 16), new TypeLen(SQL_C_SLONG)];
        var buffer = new SqlArrayBuffer(types, 3);

        expect(buffer.rows, equals(3), reason: "rows value is not set");
        expect(buffer.cols, equals(2), reason: "cols value is not set");

        expect(buffer.ctype(0), isNotNull, reason: "C type value is not set");
        expect(buffer.ctype(1), isNotNull, reason: "C type value is not set");

        expect(buffer.length(0), equals(16), reason: "length value is not set");
        expect(buffer.length(1), equals(1), reason: "length value is not set");

        expect(buffer.rowSize(), isNotNull, reason: "Row size value is null");
        expect(buffer.rowSize(), greaterThan(0), reason: "Row size value is negative");

        var rowSize = buffer.address(1, 0).value - buffer.address(0, 0).value;
        expect(buffer.rowSize(), equals(rowSize), reason: "Row size value seems incorrect");

        expect(buffer.address(0, 0).value, isNotNull, reason: "Buffer address value is null");
        expect(buffer.address(0, 1).value, isNotNull, reason: "Buffer address value is null");
        expect(buffer.address(1, 0).value, isNotNull, reason: "Buffer address value is null");
        expect(buffer.address(1, 1).value, isNotNull, reason: "Buffer address value is null");
        expect(buffer.address(2, 0).value, isNotNull, reason: "Buffer address value is null");
        expect(buffer.address(2, 1).value, isNotNull, reason: "Buffer address value is null");

        expect(buffer.address(0, 0).value, isNonZero, reason: "Buffer address value is 0");
        expect(buffer.address(0, 1).value, isNonZero, reason: "Buffer address value is 0");
        expect(buffer.address(1, 0).value, isNonZero, reason: "Buffer address value is 0");
        expect(buffer.address(1, 1).value, isNonZero, reason: "Buffer address value is 0");
        expect(buffer.address(2, 0).value, isNonZero, reason: "Buffer address value is 0");
        expect(buffer.address(2, 1).value, isNonZero, reason: "Buffer address value is 0");

        expect(buffer.address(0, 0).value, isNot(equals(buffer.address(0, 1).value)),
            reason: "Buffer addresses are the same");
        expect(buffer.address(0, 0).value, isNot(equals(buffer.address(1, 0).value)),
            reason: "Buffer addresses are the same");
        expect(buffer.address(0, 0).value, isNot(equals(buffer.address(1, 1).value)),
            reason: "Buffer addresses are the same");
        expect(buffer.address(0, 0).value, isNot(equals(buffer.address(2, 0).value)),
            reason: "Buffer addresses are the same");
        expect(buffer.address(0, 0).value, isNot(equals(buffer.address(2, 1).value)),
            reason: "Buffer addresses are the same");
        expect(buffer.address(0, 1).value, isNot(equals(buffer.address(1, 0).value)),
            reason: "Buffer addresses are the same");
        expect(buffer.address(0, 1).value, isNot(equals(buffer.address(1, 1).value)),
            reason: "Buffer addresses are the same");
        expect(buffer.address(0, 1).value, isNot(equals(buffer.address(2, 0).value)),
            reason: "Buffer addresses are the same");
        expect(buffer.address(0, 1).value, isNot(equals(buffer.address(2, 1).value)),
            reason: "Buffer addresses are the same");
        expect(buffer.address(1, 0).value, isNot(equals(buffer.address(1, 1).value)),
            reason: "Buffer addresses are the same");
        expect(buffer.address(1, 0).value, isNot(equals(buffer.address(2, 0).value)),
            reason: "Buffer addresses are the same");
        expect(buffer.address(1, 0).value, isNot(equals(buffer.address(2, 1).value)),
            reason: "Buffer addresses are the same");
        expect(buffer.address(1, 1).value, isNot(equals(buffer.address(2, 0).value)),
            reason: "Buffer addresses are the same");
        expect(buffer.address(1, 1).value, isNot(equals(buffer.address(2, 1).value)),
            reason: "Buffer addresses are the same");
        expect(buffer.address(2, 0).value, isNot(equals(buffer.address(2, 1).value)),
            reason: "Buffer addresses are the same");

        expect(buffer.peek(0, 0), equals(""), reason: "Initial value is not set");
        expect(buffer.peek(0, 1), equals(0), reason: "Initial value is not set");
        expect(buffer.peek(1, 0), equals(""), reason: "Initial value is not set");
        expect(buffer.peek(1, 1), equals(0), reason: "Initial value is not set");
        expect(buffer.peek(2, 0), equals(""), reason: "Initial value is not set");
        expect(buffer.peek(2, 1), equals(0), reason: "Initial value is not set");

        buffer.poke("ab", 0, 0);
        buffer.poke(11, 0, 1);
        buffer.poke("cd", 1, 0);
        buffer.poke(22, 1, 1);
        buffer.poke("ef", 2, 0);
        buffer.poke(33, 2, 1);
        expect(buffer.peek(0, 0), equals("ab"));
        expect(buffer.peek(0, 1), equals(11));
        expect(buffer.peek(1, 0), equals("cd"));
        expect(buffer.peek(1, 1), equals(22));
        expect(buffer.peek(2, 0), equals("ef"));
        expect(buffer.peek(2, 1), equals(33));

        expect(() => buffer.ctype(-1), throws);
        expect(() => buffer.ctype(3), throws);
        expect(() => buffer.length(-1), throws);
        expect(() => buffer.length(3), throws);
        expect(() => buffer.address(-1, 0), throws);
        expect(() => buffer.address(3, 0), throws);
        expect(() => buffer.address(0, -1), throws);
        expect(() => buffer.address(0, 2), throws);
        expect(() => buffer.peek(-1, 0), throws);
        expect(() => buffer.peek(3, 0), throws);
        expect(() => buffer.peek(0, -1), throws);
        expect(() => buffer.peek(0, 2), throws);
        expect(() => buffer.poke(null, -1, 0), throws);
        expect(() => buffer.poke(null, 3, 0), throws);
        expect(() => buffer.poke(null, 0, -1), throws);
        expect(() => buffer.poke(null, 0, 2), throws);
      });

    });
  }
}
