const std = @import("std");

const lex = @import("core/lex.zig");
const utils = @import("core/utils.zig");
const parse = @import("core/parse.zig");

pub fn Read(comptime file: []const u8) type {
    @setEvalBranchQuota(100000);
    comptime {
        utils.comptimeLog("{s}", .{"Starting to read..."});

        const lexed = lex.lex(file);

        utils.comptimeLog("{s}", .{"Lexer output..."});
        for (lexed) |entry| {
            if (entry.content) |content| {
                utils.comptimeLog("lex '{}' <=> '{s}'", .{ entry.token, content });
            } else {
                utils.comptimeLog("lex '{}'", .{entry.token});
            }
        }

        return parse.Parse(lexed);
    }
}

test "test.valid.array.array" {}
test "test.valid.array.array-subtables" {}
test "test.valid.array.bool" {}
test "test.valid.array.empty" {}
test "test.valid.array.hetergeneous" {}
test "test.valid.array.mixed-int-array" {}
test "test.valid.array.mixed-int-float" {}
test "test.valid.array.mixed-int-string" {}
test "test.valid.array.mixed-string-table" {}
test "test.valid.array.nested" {}
test "test.valid.array.nested-double" {}
test "test.valid.array.nested-inline-table" {}
test "test.valid.array.nospaces" {}
test "test.valid.array.open-parent-table" {}
test "test.valid.array.string-quote-comma" {}
test "test.valid.array.string-quote-comma-2" {}
test "test.valid.array.string-with-comma" {}
test "test.valid.array.string-with-comma-2" {}
test "test.valid.array.strings" {}
test "test.valid.array.table-array-string-backslash" {}
test "test.valid.array.trailing-comma" {}

test "test.valid.bool.bool" {
    // see: test/valid/bool/bool.json
    const toml = Read(@embedFile("test/valid/bool/bool.toml")) {};
    try std.testing.expect(toml.f == false);
    try std.testing.expect(toml.t == true);
}

test "test.valid.comment.after-literal-no-ws" {
    // TODO
    const toml = Read(@embedFile("test/valid/comment/after-literal-no-ws.toml")) {};
    // see: test/valid/comment/after-literal-no-ws.json
    try std.testing.expect(toml.false == false);
    try std.testing.expect(toml.true == true);
    // try std.testing.expect(toml.inf == std.math.inf(f32));
    // try std.testing.expect(toml.nan == std.math.nan(f32));
}

test "test.valid.comment.at-eof" {
    // TODO
    // see: test/valid/comment/at-eof.json
    // const toml = Read(@embedFile("test/valid/comment/at-eof.toml")) {};
    // try std.testing.expect(std.mem.eql(u8, toml.key, "value"));
}

test "test.valid.comment.at-eof2" {
    // TODO
    // see: test/valid/comment/at-eof2.json
    // const toml = Read(@embedFile("test/valid/comment/at-eof.toml")) {};
    // try std.testing.expect(std.mem.eql(u8, toml.key, "value"));
}

test "test.valid.comment.everywhere" {
    // TODO
    // see: test/valid/comment/everywhere.json
}

test "test.valid.comment.noeol" {
    // TODO
    // see: test/valid/comment/noeol.json
    // const toml = Read(@embedFile("test/valid/comment/noeol.toml")) {};
    // _ = toml;
}

test "test.valid.comment.nonascii" {
    // see: test/valid/comment/nonascii.json
    const toml = Read(@embedFile("test/valid/comment/nonascii.toml")) {};
    _ = toml;
}

test "test.valid.comment.tricky" {
    // TODO
    // see: test/valid/comment/tricky.json
    // const toml = Read(@embedFile("test/valid/comment/tricky.toml")) {};
    // _ = toml;
}

// TODO: No date time support will be included
test "test.valid.datetime.datetime" {}
test "test.valid.datetime.edge" {}
test "test.valid.datetime.leap-year" {}
test "test.valid.datetime.local" {}
test "test.valid.datetime.local-date" {}
test "test.valid.datetime.local-time" {}
test "test.valid.datetime.milliseconds" {}
test "test.valid.datetime.timezone" {}

test "test.valid.empty-file" {
    // see: test/valid/empty-file.json
    const toml = Read(@embedFile("test/valid/empty-file.toml")) {};
    _ = toml;
}

test "test.valid.example" {
    // TODO
    // see: test/valid/example.json
    // const toml = Read(@embedFile("test/valid/comment/example.toml")) {};
    // _ = toml;
}

test "test.valid.float.exponent" {}

test "test.valid.float.float" {}

test "test.valid.float.inf-and-nan" {}

test "test.valid.float.long" {}

test "test.valid.float.max-int" {}

test "test.valid.float.underscore" {}

test "test.valid.float.zero" {}

test "test.valid.implicit-and-explicit-after" {}

test "test.valid.implicit-and-explicit-before" {}

test "test.valid.implicit-groups" {}

test "test.valid.inline-table.array" {}

test "test.valid.inline-table.array-values" {}

test "test.valid.inline-table.bool" {}

test "test.valid.inline-table.empty" {}

test "test.valid.inline-table.end-in-bool" {}

test "test.valid.inline-table.inline-table" {}

test "test.valid.inline-table.key-dotted-1" {}

test "test.valid.inline-table.key-dotted-2" {}

test "test.valid.inline-table.key-dotted-3" {}

test "test.valid.inline-table.key-dotted-4" {}

test "test.valid.inline-table.key-dotted-5" {}

test "test.valid.inline-table.key-dotted-6" {}

test "test.valid.inline-table.key-dotted-7" {}

test "test.valid.inline-table.multiline" {}

test "test.valid.inline-table.nest" {}

test "test.valid.inline-table.spaces" {}

test "test.valid.integer.float64-max" {}

test "test.valid.integer.integer" {
    // TODO
    // see: test/valid/integer/integer.json
    const toml = Read(@embedFile("test/valid/integer/integer.toml")) {};
    try std.testing.expect(toml.answer == 42);
    // try std.testing.expect(toml.neganswer == -42);
    // try std.testing.expect(toml.posanswer == 42);
    try std.testing.expect(toml.zero == 0);
}

test "test.valid.integer.literals" {
    // TODO
    // see: test/valid/integer/literals.json
    // const toml = Read(@embedFile("test/valid/integer/literals.toml")) {};
    // try std.testing.expect(toml.bin1 == 214);
    // try std.testing.expect(toml.bin2 == 5);
    // try std.testing.expect(toml.hex1 == 3735928559);
    // try std.testing.expect(toml.hex2 == 3735928559);
    // try std.testing.expect(toml.hex3 == 3735928559);
    // try std.testing.expect(toml.hex4 == 2439);
    // try std.testing.expect(toml.oct1 == 342391);
    // try std.testing.expect(toml.oct2 == 493);
    // try std.testing.expect(toml.oct3 == 501);
}

test "test.valid.integer.long" {}

test "test.valid.integer.underscore" {}

test "test.valid.integer.zero" {}

test "test.valid.key.alphanum" {}

test "test.valid.key.case-sensitive" {}
test "test.valid.key.dotted-1" {}
test "test.valid.key.dotted-2" {}
test "test.valid.key.dotted-3" {}
test "test.valid.key.dotted-4" {}
test "test.valid.key.dotted-empty" {}
test "test.valid.key.empty-1" {}
test "test.valid.key.empty-2" {}
test "test.valid.key.empty-3" {}
test "test.valid.key.equals-nospace" {}
test "test.valid.key.escapes" {}
test "test.valid.key.numeric" {}
test "test.valid.key.numeric-dotted" {}
test "test.valid.key.quoted-dots" {}
test "test.valid.key.quoted-unicode" {}
test "test.valid.key.space" {}
test "test.valid.key.special-chars" {}
test "test.valid.key.special-word" {}
test "test.valid.key.start" {}
test "test.valid.key.zero" {}
test "test.valid.newline-crlf" {}
test "test.valid.newline-lf" {}
test "test.valid.spec-example-1" {}
test "test.valid.spec-example-1-compact" {}
test "test.valid.spec.array-0" {}
test "test.valid.spec.array-1" {}
test "test.valid.spec.array-of-tables-0" {}
test "test.valid.spec.array-of-tables-1" {}
test "test.valid.spec.array-of-tables-2" {}
test "test.valid.spec.boolean-0" {}
test "test.valid.spec.comment-0" {}
test "test.valid.spec.float-0" {}
test "test.valid.spec.float-1" {}
test "test.valid.spec.float-2" {}
test "test.valid.spec.inline-table-0" {}
test "test.valid.spec.inline-table-1" {}
test "test.valid.spec.inline-table-2" {}
test "test.valid.spec.inline-table-3" {}
test "test.valid.spec.integer-0" {}
test "test.valid.spec.integer-1" {}
test "test.valid.spec.integer-2" {}
test "test.valid.spec.key-value-pair-0" {}
test "test.valid.spec.keys-0" {}
test "test.valid.spec.keys-1" {}
test "test.valid.spec.keys-3" {}
test "test.valid.spec.keys-4" {}
test "test.valid.spec.keys-5" {}
test "test.valid.spec.keys-6" {}
test "test.valid.spec.keys-7" {}
test "test.valid.spec.local-date-0" {}
test "test.valid.spec.local-date-time-0" {}
test "test.valid.spec.local-time-0" {}
test "test.valid.spec.offset-date-time-0" {}
test "test.valid.spec.offset-date-time-1" {}
test "test.valid.spec.string-0" {}
test "test.valid.spec.string-1" {}
test "test.valid.spec.string-2" {}
test "test.valid.spec.string-3" {}
test "test.valid.spec.string-4" {}
test "test.valid.spec.string-5" {}
test "test.valid.spec.string-6" {}
test "test.valid.spec.string-7" {}
test "test.valid.spec.table-0" {}
test "test.valid.spec.table-1" {}
test "test.valid.spec.table-2" {}
test "test.valid.spec.table-3" {}
test "test.valid.spec.table-4" {}
test "test.valid.spec.table-5" {}
test "test.valid.spec.table-6" {}
test "test.valid.spec.table-7" {}
test "test.valid.spec.table-8" {}
test "test.valid.spec.table-9" {}
test "test.valid.string.double-quote-escape" {}
test "test.valid.string.empty" {}
test "test.valid.string.ends-in-whitespace-escape" {}
test "test.valid.string.escape-tricky" {}
test "test.valid.string.escaped-escape" {}
test "test.valid.string.escapes" {}
test "test.valid.string.multiline" {}
test "test.valid.string.multiline-empty" {}
test "test.valid.string.multiline-escaped-crlf" {}
test "test.valid.string.multiline-quotes" {}
test "test.valid.string.nl" {}
test "test.valid.string.quoted-unicode" {}
test "test.valid.string.raw" {}
test "test.valid.string.raw-multiline" {}
test "test.valid.string.simple" {}
test "test.valid.string.start-mb" {}
test "test.valid.string.unicode-escape" {}
test "test.valid.string.unicode-literal" {}
test "test.valid.string.with-pound" {}
test "test.valid.table.array-implicit" {}
test "test.valid.table.array-implicit-and-explicit-after" {}
test "test.valid.table.array-many" {}
test "test.valid.table.array-nest" {}
test "test.valid.table.array-one" {}
test "test.valid.table.array-table-array" {}
test "test.valid.table.array-within-dotted" {}
test "test.valid.table.empty" {}
test "test.valid.table.empty-name" {}
test "test.valid.table.keyword" {}
test "test.valid.table.names" {}
test "test.valid.table.no-eol" {}
test "test.valid.table.sub" {}
test "test.valid.table.sub-empty" {}
test "test.valid.table.whitespace" {}
test "test.valid.table.with-literal-string" {}
test "test.valid.table.with-pound" {}
test "test.valid.table.with-single-quotes" {}
test "test.valid.table.without-super" {}

test "test.invalid.array.double-comma-1" {}
test "test.invalid.array.double-comma-2" {}
test "test.invalid.array.extend-defined-aot" {}
test "test.invalid.array.extending-table" {}
test "test.invalid.array.missing-separator-1" {}
test "test.invalid.array.missing-separator-2" {}
test "test.invalid.array.no-close-1" {}
test "test.invalid.array.no-close-2" {}
test "test.invalid.array.no-close-3" {}
test "test.invalid.array.no-close-4" {}
test "test.invalid.array.no-close-5" {}
test "test.invalid.array.no-close-6" {}
test "test.invalid.array.no-close-7" {}
test "test.invalid.array.no-close-8" {}
test "test.invalid.array.no-close-table-1" {}
test "test.invalid.array.no-close-table-2" {}
test "test.invalid.array.no-comma-1" {}
test "test.invalid.array.no-comma-2" {}
test "test.invalid.array.no-comma-3" {}
test "test.invalid.array.only-comma-1" {}
test "test.invalid.array.only-comma-2" {}
test "test.invalid.array.tables-1" {}
test "test.invalid.array.tables-2" {}
test "test.invalid.array.text-after-array-entries" {}
test "test.invalid.array.text-before-array-separator" {}
test "test.invalid.array.text-in-array" {}
test "test.invalid.bool.almost-false" {}
test "test.invalid.bool.almost-false-with-extra" {}
test "test.invalid.bool.almost-true" {}
test "test.invalid.bool.almost-true-with-extra" {}
test "test.invalid.bool.capitalized-false" {}
test "test.invalid.bool.capitalized-true" {}
test "test.invalid.bool.just-f" {}
test "test.invalid.bool.just-t" {}
test "test.invalid.bool.mixed-case" {}
test "test.invalid.bool.mixed-case-false" {}
test "test.invalid.bool.mixed-case-true" {}
test "test.invalid.bool.starting-same-false" {}
test "test.invalid.bool.starting-same-true" {}
test "test.invalid.bool.wrong-case-false" {}
test "test.invalid.bool.wrong-case-true" {}
test "test.invalid.control.bare-cr" {}
test "test.invalid.control.bare-formfeed" {}
test "test.invalid.control.bare-null" {}
test "test.invalid.control.bare-vertical-tab" {}
test "test.invalid.control.comment-cr" {}
test "test.invalid.control.comment-del" {}
test "test.invalid.control.comment-ff" {}
test "test.invalid.control.comment-lf" {}
test "test.invalid.control.comment-null" {}
test "test.invalid.control.comment-us" {}
test "test.invalid.control.multi-cr" {}
test "test.invalid.control.multi-del" {}
test "test.invalid.control.multi-lf" {}
test "test.invalid.control.multi-null" {}
test "test.invalid.control.multi-us" {}
test "test.invalid.control.rawmulti-cd" {}
test "test.invalid.control.rawmulti-del" {}
test "test.invalid.control.rawmulti-lf" {}
test "test.invalid.control.rawmulti-null" {}
test "test.invalid.control.rawmulti-us" {}
test "test.invalid.control.rawstring-cr" {}
test "test.invalid.control.rawstring-del" {}
test "test.invalid.control.rawstring-lf" {}
test "test.invalid.control.rawstring-null" {}
test "test.invalid.control.rawstring-us" {}
test "test.invalid.control.string-bs" {}
test "test.invalid.control.string-cr" {}
test "test.invalid.control.string-del" {}
test "test.invalid.control.string-lf" {}
test "test.invalid.control.string-null" {}
test "test.invalid.control.string-us" {}
test "test.invalid.datetime.feb-29" {}
test "test.invalid.datetime.feb-30" {}
test "test.invalid.datetime.hour-over" {}
test "test.invalid.datetime.mday-over" {}
test "test.invalid.datetime.mday-under" {}
test "test.invalid.datetime.minute-over" {}
test "test.invalid.datetime.month-over" {}
test "test.invalid.datetime.month-under" {}
test "test.invalid.datetime.no-leads" {}
test "test.invalid.datetime.no-leads-month" {}
test "test.invalid.datetime.no-leads-with-milli" {}
test "test.invalid.datetime.no-secs" {}
test "test.invalid.datetime.no-t" {}
test "test.invalid.datetime.offset-overflow-hour" {}
test "test.invalid.datetime.offset-overflow-minute" {}
test "test.invalid.datetime.second-over" {}
test "test.invalid.datetime.time-no-leads" {}
test "test.invalid.datetime.y10k" {}
test "test.invalid.encoding.bad-codepoint" {}
test "test.invalid.encoding.bad-utf8-at-end" {}
test "test.invalid.encoding.bad-utf8-in-comment" {}
test "test.invalid.encoding.bad-utf8-in-multiline" {}
test "test.invalid.encoding.bad-utf8-in-multiline-literal" {}
test "test.invalid.encoding.bad-utf8-in-string" {}
test "test.invalid.encoding.bad-utf8-in-string-literal" {}
test "test.invalid.encoding.bom-not-at-start-1" {}
test "test.invalid.encoding.bom-not-at-start-2" {}
test "test.invalid.encoding.utf16-bom" {}
test "test.invalid.encoding.utf16-comment" {}
test "test.invalid.encoding.utf16-key" {}
test "test.invalid.float.double-point-1" {}
test "test.invalid.float.double-point-2" {}
test "test.invalid.float.exp-double-e-1" {}
test "test.invalid.float.exp-double-e-2" {}
test "test.invalid.float.exp-double-us" {}
test "test.invalid.float.exp-leading-us" {}
test "test.invalid.float.exp-point-1" {}
test "test.invalid.float.exp-point-2" {}
test "test.invalid.float.exp-point-3" {}
test "test.invalid.float.exp-trailing-us" {}
test "test.invalid.float.exp-trailing-us-1" {}
test "test.invalid.float.exp-trailing-us-2" {}
test "test.invalid.float.inf-capital" {}
test "test.invalid.float.inf-incomplete-1" {}
test "test.invalid.float.inf-incomplete-2" {}
test "test.invalid.float.inf-incomplete-3" {}
test "test.invalid.float.inf_underscore" {}
test "test.invalid.float.leading-point" {}
test "test.invalid.float.leading-point-neg" {}
test "test.invalid.float.leading-point-plus" {}
test "test.invalid.float.leading-us" {}
test "test.invalid.float.leading-zero" {}
test "test.invalid.float.leading-zero-neg" {}
test "test.invalid.float.leading-zero-plus" {}
test "test.invalid.float.nan-capital" {}
test "test.invalid.float.nan-incomplete-1" {}
test "test.invalid.float.nan-incomplete-2" {}
test "test.invalid.float.nan-incomplete-3" {}
test "test.invalid.float.nan_underscore" {}
test "test.invalid.float.trailing-point" {}
test "test.invalid.float.trailing-point-min" {}
test "test.invalid.float.trailing-point-plus" {}
test "test.invalid.float.trailing-us" {}
test "test.invalid.float.trailing-us-exp-1" {}
test "test.invalid.float.trailing-us-exp-2" {}
test "test.invalid.float.us-after-point" {}
test "test.invalid.float.us-before-point" {}
test "test.invalid.inline-table.bad-key-syntax" {}
test "test.invalid.inline-table.double-comma" {}
test "test.invalid.inline-table.duplicate-key-1" {}
test "test.invalid.inline-table.duplicate-key-2" {}
test "test.invalid.inline-table.duplicate-key-3" {}
test "test.invalid.inline-table.duplicate-key-4" {}
test "test.invalid.inline-table.empty-1" {}
test "test.invalid.inline-table.empty-2" {}
test "test.invalid.inline-table.empty-3" {}
test "test.invalid.inline-table.linebreak-1" {}
test "test.invalid.inline-table.linebreak-2" {}
test "test.invalid.inline-table.linebreak-3" {}
test "test.invalid.inline-table.linebreak-4" {}
test "test.invalid.inline-table.no-close-1" {}
test "test.invalid.inline-table.no-close-2" {}
test "test.invalid.inline-table.no-comma-1" {}
test "test.invalid.inline-table.no-comma-2" {}
test "test.invalid.inline-table.overwrite-01" {}
test "test.invalid.inline-table.overwrite-02" {}
test "test.invalid.inline-table.overwrite-03" {}
test "test.invalid.inline-table.overwrite-04" {}
test "test.invalid.inline-table.overwrite-05" {}
test "test.invalid.inline-table.overwrite-06" {}
test "test.invalid.inline-table.overwrite-07" {}
test "test.invalid.inline-table.overwrite-08" {}
test "test.invalid.inline-table.overwrite-09" {}
test "test.invalid.inline-table.overwrite-10" {}
test "test.invalid.inline-table.trailing-comma" {}
test "test.invalid.integer.capital-bin" {}
test "test.invalid.integer.capital-hex" {}
test "test.invalid.integer.capital-oct" {}
test "test.invalid.integer.double-sign-nex" {}
test "test.invalid.integer.double-sign-plus" {}
test "test.invalid.integer.double-us" {}
test "test.invalid.integer.incomplete-bin" {}
test "test.invalid.integer.incomplete-hex" {}
test "test.invalid.integer.incomplete-oct" {}
test "test.invalid.integer.invalid-bin" {}
test "test.invalid.integer.invalid-hex" {}
test "test.invalid.integer.invalid-hex-1" {}
test "test.invalid.integer.invalid-hex-2" {}
test "test.invalid.integer.invalid-oct" {}
test "test.invalid.integer.leading-us" {}
test "test.invalid.integer.leading-us-bin" {}
test "test.invalid.integer.leading-us-hex" {}
test "test.invalid.integer.leading-us-oct" {}
test "test.invalid.integer.leading-zero-1" {}
test "test.invalid.integer.leading-zero-2" {}
test "test.invalid.integer.leading-zero-3" {}
test "test.invalid.integer.leading-zero-sign-1" {}
test "test.invalid.integer.leading-zero-sign-2" {}
test "test.invalid.integer.leading-zero-sign-3" {}
test "test.invalid.integer.negative-bin" {}
test "test.invalid.integer.negative-hex" {}
test "test.invalid.integer.negative-oct" {}
test "test.invalid.integer.positive-bin" {}
test "test.invalid.integer.positive-hex" {}
test "test.invalid.integer.positive-oct" {}
test "test.invalid.integer.text-after-integer" {}
test "test.invalid.integer.trailing-us" {}
test "test.invalid.integer.trailing-us-bin" {}
test "test.invalid.integer.trailing-us-hex" {}
test "test.invalid.integer.trailing-us-oct" {}
test "test.invalid.integer.us-after-bin" {}
test "test.invalid.integer.us-after-hex" {}
test "test.invalid.integer.us-after-oct" {}
test "test.invalid.key.after-array" {}
test "test.invalid.key.after-table" {}
test "test.invalid.key.after-value" {}
test "test.invalid.key.bare-invalid-character" {}
test "test.invalid.key.dotted-redefine-table-1" {}
test "test.invalid.key.dotted-redefine-table-2" {}
test "test.invalid.key.duplicate-keys-1" {}
test "test.invalid.key.duplicate-keys-2" {}
test "test.invalid.key.duplicate-keys-3" {}
test "test.invalid.key.duplicate-keys-4" {}
test "test.invalid.key.empty" {}
test "test.invalid.key.end-in-escape" {}
test "test.invalid.key.escape" {}
test "test.invalid.key.hash" {}
test "test.invalid.key.newline-1" {}
test "test.invalid.key.newline-2" {}
test "test.invalid.key.newline-3" {}
test "test.invalid.key.newline-4" {}
test "test.invalid.key.newline-5" {}
test "test.invalid.key.no-eol" {}
test "test.invalid.key.open-bracket" {}
test "test.invalid.key.partial-quoted" {}
test "test.invalid.key.quoted-unclosed-1" {}
test "test.invalid.key.quoted-unclosed-2" {}
test "test.invalid.key.single-open-bracket" {}
test "test.invalid.key.space" {}
test "test.invalid.key.special-character" {}
test "test.invalid.key.start-bracket" {}
test "test.invalid.key.start-dot" {}
test "test.invalid.key.two-equals-1" {}
test "test.invalid.key.two-equals-2" {}
test "test.invalid.key.two-equals-3" {}
test "test.invalid.key.without-value-1" {}
test "test.invalid.key.without-value-2" {}
test "test.invalid.key.without-value-3" {}
test "test.invalid.key.without-value-4" {}
test "test.invalid.key.without-value-5" {}
test "test.invalid.key.without-value-6" {}
test "test.invalid.key.without-value-7" {}
test "test.invalid.local-date.feb-29" {}
test "test.invalid.local-date.feb-30" {}
test "test.invalid.local-date.mday-over" {}
test "test.invalid.local-date.mday-under" {}
test "test.invalid.local-date.month-over" {}
test "test.invalid.local-date.month-under" {}
test "test.invalid.local-date.no-leads" {}
test "test.invalid.local-date.no-leads-with-milli" {}
test "test.invalid.local-date.trailing-t" {}
test "test.invalid.local-date.y10k" {}
test "test.invalid.local-datetime.feb-29" {}
test "test.invalid.local-datetime.feb-30" {}
test "test.invalid.local-datetime.hour-over" {}
test "test.invalid.local-datetime.mday-over" {}
test "test.invalid.local-datetime.mday-under" {}
test "test.invalid.local-datetime.minute-over" {}
test "test.invalid.local-datetime.month-over" {}
test "test.invalid.local-datetime.month-under" {}
test "test.invalid.local-datetime.no-leads" {}
test "test.invalid.local-datetime.no-leads-with-milli" {}
test "test.invalid.local-datetime.no-secs" {}
test "test.invalid.local-datetime.no-t" {}
test "test.invalid.local-datetime.second-over" {}
test "test.invalid.local-datetime.time-no-leads" {}
test "test.invalid.local-datetime.y10k" {}
test "test.invalid.local-time.hour-over" {}
test "test.invalid.local-time.minute-over" {}
test "test.invalid.local-time.no-secs" {}
test "test.invalid.local-time.second-over" {}
test "test.invalid.local-time.time-no-leads" {}
test "test.invalid.local-time.time-no-leads-2" {}
test "test.invalid.spec.inline-table-2-0" {}
test "test.invalid.spec.inline-table-3-0" {}
test "test.invalid.spec.key-value-pair-1" {}
test "test.invalid.spec.keys-2" {}
test "test.invalid.spec.string-4-0" {}
test "test.invalid.spec.string-7-0" {}
test "test.invalid.spec.table-9-0" {}
test "test.invalid.spec.table-9-1" {}
test "test.invalid.string.bad-byte-escape" {}
test "test.invalid.string.bad-concat" {}
test "test.invalid.string.bad-escape-1" {}
test "test.invalid.string.bad-escape-2" {}
test "test.invalid.string.bad-escape-3" {}
test "test.invalid.string.bad-hex-esc-1" {}
test "test.invalid.string.bad-hex-esc-2" {}
test "test.invalid.string.bad-hex-esc-3" {}
test "test.invalid.string.bad-hex-esc-4" {}
test "test.invalid.string.bad-hex-esc-5" {}
test "test.invalid.string.bad-multiline" {}
test "test.invalid.string.bad-slash-escape" {}
test "test.invalid.string.bad-uni-esc-1" {}
test "test.invalid.string.bad-uni-esc-2" {}
test "test.invalid.string.bad-uni-esc-3" {}
test "test.invalid.string.bad-uni-esc-4" {}
test "test.invalid.string.bad-uni-esc-5" {}
test "test.invalid.string.bad-uni-esc-6" {}
test "test.invalid.string.bad-uni-esc-7" {}
test "test.invalid.string.basic-byte-escapes" {}
test "test.invalid.string.basic-multiline-out-of-range-unicode-escape-1" {}
test "test.invalid.string.basic-multiline-out-of-range-unicode-escape-2" {}
test "test.invalid.string.basic-multiline-quotes" {}
test "test.invalid.string.basic-multiline-unknown-escape" {}
test "test.invalid.string.basic-out-of-range-unicode-escape-1" {}
test "test.invalid.string.basic-out-of-range-unicode-escape-2" {}
test "test.invalid.string.basic-unknown-escape" {}
test "test.invalid.string.literal-multiline-quotes-1" {}
test "test.invalid.string.literal-multiline-quotes-2" {}
test "test.invalid.string.missing-quotes" {}
test "test.invalid.string.multiline-bad-escape-1" {}
test "test.invalid.string.multiline-bad-escape-2" {}
test "test.invalid.string.multiline-bad-escape-3" {}
test "test.invalid.string.multiline-bad-escape-4" {}
test "test.invalid.string.multiline-escape-space-1" {}
test "test.invalid.string.multiline-escape-space-2" {}
test "test.invalid.string.multiline-lit-no-close-1" {}
test "test.invalid.string.multiline-lit-no-close-2" {}
test "test.invalid.string.multiline-lit-no-close-3" {}
test "test.invalid.string.multiline-lit-no-close-4" {}
test "test.invalid.string.multiline-no-close-1" {}
test "test.invalid.string.multiline-no-close-2" {}
test "test.invalid.string.multiline-no-close-3" {}
test "test.invalid.string.multiline-no-close-4" {}
test "test.invalid.string.multiline-no-close-5" {}
test "test.invalid.string.multiline-quotes-1" {}
test "test.invalid.string.no-close-1" {}
test "test.invalid.string.no-close-2" {}
test "test.invalid.string.no-close-3" {}
test "test.invalid.string.no-close-4" {}
test "test.invalid.string.text-after-string" {}
test "test.invalid.string.wrong-close" {}
test "test.invalid.table.append-to-array-with-dotted-keys" {}
test "test.invalid.table.append-with-dotted-keys-1" {}
test "test.invalid.table.append-with-dotted-keys-2" {}
test "test.invalid.table.array-empty" {}
test "test.invalid.table.array-implicit" {}
test "test.invalid.table.array-no-close-1" {}
test "test.invalid.table.array-no-close-2" {}
test "test.invalid.table.duplicate" {}
test "test.invalid.table.duplicate-key-dotted-array" {}
test "test.invalid.table.duplicate-key-dotted-table" {}
test "test.invalid.table.duplicate-key-dotted-table2" {}
test "test.invalid.table.duplicate-key-table" {}
test "test.invalid.table.duplicate-table-array" {}
test "test.invalid.table.duplicate-table-array2" {}
test "test.invalid.table.empty" {}
test "test.invalid.table.empty-implicit-table" {}
test "test.invalid.table.equals-sign" {}
test "test.invalid.table.llbrace" {}
test "test.invalid.table.nested-brackets-close" {}
test "test.invalid.table.nested-brackets-open" {}
test "test.invalid.table.no-close-1" {}
test "test.invalid.table.no-close-2" {}
test "test.invalid.table.no-close-3" {}
test "test.invalid.table.no-close-4" {}
test "test.invalid.table.no-close-5" {}
test "test.invalid.table.overwrite-array-in-parent" {}
test "test.invalid.table.overwrite-bool-with-array" {}
test "test.invalid.table.overwrite-with-deep-table" {}
test "test.invalid.table.redefine-1" {}
test "test.invalid.table.redefine-2" {}
test "test.invalid.table.redefine-3" {}
test "test.invalid.table.rrbrace" {}
test "test.invalid.table.super-twice" {}
test "test.invalid.table.text-after-table" {}
test "test.invalid.table.whitespace" {}
test "test.invalid.table.with-pound" {}
