Here's a clean and organized list of tokens you can lex for your TOML lexer:

---

### **TOML Lexer Tokens**

#### **1. Whitespace and Newlines**
- **Whitespace (`WS`)**: Space and tab characters.
- **Newline (`NEWLINE`)**: Line feed (`\n`) and carriage return + line feed (`\r\n`).

#### **2. Comments**
- **Comment (`COMMENT`)**: Lines starting with `#`.

#### **3. Identifiers (Keys)**
- **Unquoted Key (`UNQUOTED_KEY`)**: Alphanumeric characters, underscores, and hyphens.
- **Quoted Key (`QUOTED_KEY`)**: Keys enclosed in basic or literal strings.
- **Dotted Key Separator (`DOT`)**: The dot `.` used in dotted keys.

#### **4. Key-Value Separator**
- **Equal Sign (`EQUALS`)**: The `=` symbol.

#### **5. Strings**
- **Basic String (`BASIC_STRING`)**: Enclosed in double quotes (`"`), allowing escape sequences.
- **Multiline Basic String (`ML_BASIC_STRING`)**: Enclosed in triple double quotes (`"""`).
- **Literal String (`LITERAL_STRING`)**: Enclosed in single quotes (`'`), no escape sequences.
- **Multiline Literal String (`ML_LITERAL_STRING`)**: Enclosed in triple single quotes (`'''`).

#### **6. Numbers**
- **Integer (`INTEGER`)**: Decimal, hexadecimal, octal, and binary integers.
- **Float (`FLOAT`)**: Decimal numbers with fractional parts and/or exponents.
- **Special Float (`SPECIAL_FLOAT`)**: Values like `inf`, `+inf`, `-inf`, `nan`.

#### **7. Booleans**
- **Boolean (`BOOLEAN`)**: The literals `true` and `false`.

#### **8. Date-Times**
- **Date-Time (`DATE_TIME`)**: ISO 8601 date-time formats (RFC 3339).

#### **9. Punctuation and Delimiters**
- **Left Square Bracket (`LBRACKET`)**: `[`
- **Right Square Bracket (`RBRACKET`)**: `]`
- **Double Left Square Bracket (`DOUBLE_LBRACKET`)**: `[[`
- **Double Right Square Bracket (`DOUBLE_RBRACKET`)**: `]]`
- **Left Curly Brace (`LBRACE`)**: `{`
- **Right Curly Brace (`RBRACE`)**: `}`
- **Comma (`COMMA`)**: `,`
- **Dot (`DOT`)**: `.` (for dotted keys).
- **Key-Value Separator (`EQUALS`)**: `=`

#### **10. Operators**
- **Plus (`PLUS`)**: `+` (used in numbers and date-times).
- **Minus (`MINUS`)**: `-` (used in numbers and date-times).
- **Underscore (`UNDERSCORE`)**: `_` (digit separator in numbers).

#### **11. Escape Sequences**
- **Escape Character (`ESCAPE`)**: `\` (for escape sequences in basic strings).

#### **12. Array and Inline Table Elements**
- **Array Delimiters**:
  - **Left Square Bracket (`LBRACKET`)**: `[`
  - **Right Square Bracket (`RBRACKET`)**: `]`
  
- **Inline Table Delimiters**:
  - **Left Curly Brace (`LBRACE`)**: `{`
  - **Right Curly Brace (`RBRACE`)**: `}`

- **Value Separator (`COMMA`)**: `,` (for separating values in arrays and inline tables).

---

### **Additional Considerations**
- Handle **whitespace** appropriately: skip or tokenize depending on whether it's significant.
- Consider **contextual tokens**: some characters like `-` and `.` may have different meanings depending on context (numbers, date-times, keys).

---

This should give you a comprehensive list of tokens to lex as part of your TOML lexer development.
