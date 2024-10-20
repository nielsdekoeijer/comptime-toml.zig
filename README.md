# TODO Features:
- [ ] Table
- [ ] ArrayTable
- [ ] DottedKey

# Structure of TOML

```
toml
├── expression
│   ├── ws [comment]
│   ├── ws keyval ws [comment]
│   └── ws table ws [comment]
├── ws
│   └── *wschar        # ( [\x20\x09]* )
├── newline
│   ├── LF (\x0A)
│   └── CRLF (\x0D\x0A)
├── comment
│   ├── comment-start-symbol (#)
│   └── *allowed-comment-char  # ( [\x01-\x09\x0E-\x7F\x80-\uD7FF\uE000-\U0010FFFF]* )
├── keyval
│   ├── key
│   │   ├── simple-key
│   │   │   ├── quoted-key      # ( basic-string | literal-string )
│   │   │   └── unquoted-key    # ( [unquoted-key-char]+ )
│   │   └── dotted-key          # ( simple-key ( dot-sep simple-key )+ )
│   ├── keyval-sep (=)          # ( \s*=\s* )
│   └── val
│       ├── string
│       │   ├── ml-basic-string
│       │   ├── basic-string
│       │   ├── ml-literal-string
│       │   └── literal-string
│       ├── boolean             # ( true | false )
│       ├── array
│       ├── inline-table
│       ├── date-time
│       ├── float
│       └── integer
├── table
│   ├── std-table
│   │   ├── std-table-open ([)
│   │   ├── key
│   │   └── std-table-close (])
│   └── array-table
│       ├── array-table-open ([[)
│       ├── key
│       └── array-table-close (]])
├── string
│   ├── ml-basic-string
│   │   ├── ml-basic-string-delim (""")
│   │   ├── [newline] ml-basic-body
│   │   └── ml-basic-string-delim (""")
│   ├── basic-string
│   │   ├── quotation-mark (")
│   │   ├── *basic-char
│   │   └── quotation-mark (")
│   ├── ml-literal-string
│   │   ├── ml-literal-string-delim (''')
│   │   ├── [newline] ml-literal-body
│   │   └── ml-literal-string-delim (''')
│   └── literal-string
│       ├── apostrophe (')
│       ├── *literal-char
│       └── apostrophe (')
├── integer
│   ├── dec-int         # ( [+-]?unsigned-dec-int )
│   ├── hex-int         # ( 0x[0-9A-Fa-f_]+ )
│   ├── oct-int         # ( 0o[0-7_]+ )
│   └── bin-int         # ( 0b[01_]+ )
├── float
│   ├── float-int-part
│   │   └── dec-int
│   ├── frac
│   │   └── decimal-point zero-prefixable-int
│   ├── [exp]
│   └── special-float   # ( [+-]?(inf|nan) )
├── boolean
│   ├── true            # ( true )
│   └── false           # ( false )
├── date-time
│   ├── offset-date-time
│   ├── local-date-time
│   ├── local-date
│   └── local-time
├── array
│   ├── array-open ([)
│   ├── [array-values]
│   ├── ws-comment-newline
│   └── array-close (])
└── inline-table
    ├── inline-table-open ({)
    ├── [inline-table-keyvals]
    ├── ws-comment-newline
    └── inline-table-close (})
```
