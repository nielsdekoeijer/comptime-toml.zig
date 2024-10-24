pub const files = .{
// "valid/array/array",
// "valid/array/array-subtables",
// "valid/array/bool",
// "valid/array/empty",
// "valid/array/hetergeneous",
// "valid/array/mixed-int-array",
// "valid/array/mixed-int-float",
// "valid/array/mixed-int-string",
// "valid/array/mixed-string-table",
// "valid/array/nested",
// "valid/array/nested-double",
// "valid/array/nested-inline-table",
// "valid/array/nospaces",
// "valid/array/open-parent-table",
// "valid/array/string-quote-comma",
// "valid/array/string-quote-comma-2",
// "valid/array/string-with-comma",
// "valid/array/string-with-comma-2",
// "valid/array/strings",
// "valid/array/table-array-string-backslash",
// "valid/array/trailing-comma",
"valid/bool/bool",
"valid/comment/after-literal-no-ws",
// "valid/comment/at-eof",
// "valid/comment/at-eof2",
// "valid/comment/everywhere",
// "valid/comment/noeol",
// "valid/comment/nonascii",
// "valid/comment/tricky",
// "valid/datetime/datetime",
// "valid/datetime/edge",
// "valid/datetime/leap-year",
// "valid/datetime/local",
// "valid/datetime/local-date",
// "valid/datetime/local-time",
// "valid/datetime/milliseconds",
// "valid/datetime/timezone",
"valid/empty-file",
// "valid/example",
// "valid/float/exponent",
// "valid/float/float",
// "valid/float/inf-and-nan",
// "valid/float/long",
// "valid/float/max-int",
// "valid/float/underscore",
// "valid/float/zero",
// "valid/implicit-and-explicit-after",
// "valid/implicit-and-explicit-before",
// "valid/implicit-groups",
// "valid/inline-table/array",
// "valid/inline-table/array-values",
// "valid/inline-table/bool",
// "valid/inline-table/empty",
// "valid/inline-table/end-in-bool",
// "valid/inline-table/inline-table",
// "valid/inline-table/key-dotted-1",
// "valid/inline-table/key-dotted-2",
// "valid/inline-table/key-dotted-3",
// "valid/inline-table/key-dotted-4",
// "valid/inline-table/key-dotted-5",
// "valid/inline-table/key-dotted-6",
// "valid/inline-table/key-dotted-7",
// "valid/inline-table/multiline",
// "valid/inline-table/nest",
// "valid/inline-table/spaces",
// "valid/integer/float64-max",
// "valid/integer/integer",
// "valid/integer/literals",
// "valid/integer/long",
// "valid/integer/underscore",
// "valid/integer/zero",
// "valid/key/alphanum",
// "valid/key/case-sensitive",
// "valid/key/dotted-1",
// "valid/key/dotted-2",
// "valid/key/dotted-3",
// "valid/key/dotted-4",
// "valid/key/dotted-empty",
// "valid/key/empty-1",
// "valid/key/empty-2",
// "valid/key/empty-3",
// "valid/key/equals-nospace",
// "valid/key/escapes",
// "valid/key/numeric",
// "valid/key/numeric-dotted",
// "valid/key/quoted-dots",
// "valid/key/quoted-unicode",
// "valid/key/space",
// "valid/key/special-chars",
// "valid/key/special-word",
// "valid/key/start",
// "valid/key/zero",
// "valid/newline-crlf",
// "valid/newline-lf",
// "valid/spec-example-1",
// "valid/spec-example-1-compact",
// "valid/spec/array-0",
// "valid/spec/array-1",
// "valid/spec/array-of-tables-0",
// "valid/spec/array-of-tables-1",
// "valid/spec/array-of-tables-2",
// "valid/spec/boolean-0",
// "valid/spec/comment-0",
// "valid/spec/float-0",
// "valid/spec/float-1",
// "valid/spec/float-2",
// "valid/spec/inline-table-0",
// "valid/spec/inline-table-1",
// "valid/spec/inline-table-2",
// "valid/spec/inline-table-3",
// "valid/spec/integer-0",
// "valid/spec/integer-1",
// "valid/spec/integer-2",
// "valid/spec/key-value-pair-0",
// "valid/spec/keys-0",
// "valid/spec/keys-1",
// "valid/spec/keys-3",
// "valid/spec/keys-4",
// "valid/spec/keys-5",
// "valid/spec/keys-6",
// "valid/spec/keys-7",
// "valid/spec/local-date-0",
// "valid/spec/local-date-time-0",
// "valid/spec/local-time-0",
// "valid/spec/offset-date-time-0",
// "valid/spec/offset-date-time-1",
// "valid/spec/string-0",
// "valid/spec/string-1",
// "valid/spec/string-2",
// "valid/spec/string-3",
// "valid/spec/string-4",
// "valid/spec/string-5",
// "valid/spec/string-6",
// "valid/spec/string-7",
// "valid/spec/table-0",
// "valid/spec/table-1",
// "valid/spec/table-2",
// "valid/spec/table-3",
// "valid/spec/table-4",
// "valid/spec/table-5",
// "valid/spec/table-6",
// "valid/spec/table-7",
// "valid/spec/table-8",
// "valid/spec/table-9",
// "valid/string/double-quote-escape",
// "valid/string/empty",
// "valid/string/ends-in-whitespace-escape",
// "valid/string/escape-tricky",
// "valid/string/escaped-escape",
// "valid/string/escapes",
// "valid/string/multiline",
// "valid/string/multiline-empty",
// "valid/string/multiline-escaped-crlf",
// "valid/string/multiline-quotes",
// "valid/string/nl",
// "valid/string/quoted-unicode",
// "valid/string/raw",
// "valid/string/raw-multiline",
// "valid/string/simple",
// "valid/string/start-mb",
// "valid/string/unicode-escape",
// "valid/string/unicode-literal",
// "valid/string/with-pound",
// "valid/table/array-implicit",
// "valid/table/array-implicit-and-explicit-after",
// "valid/table/array-many",
// "valid/table/array-nest",
// "valid/table/array-one",
// "valid/table/array-table-array",
// "valid/table/array-within-dotted",
// "valid/table/empty",
// "valid/table/empty-name",
// "valid/table/keyword",
// "valid/table/names",
// "valid/table/no-eol",
// "valid/table/sub",
// "valid/table/sub-empty",
// "valid/table/whitespace",
// "valid/table/with-literal-string",
// "valid/table/with-pound",
// "valid/table/with-single-quotes",
// "valid/table/without-super",
};
