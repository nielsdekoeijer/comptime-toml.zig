const std = @import("std");

const lex = @import("core/lex.zig");
const utils = @import("core/utils.zig");
const parse = @import("core/parse.zig");
const TOMLError = @import("core/error.zig").TOMLError;

pub fn Read(comptime file: []const u8) type {
    comptime {
        const Type = errorRead(file) catch {
            @compileError("Failed to read toml file");
        };

        return Type;
    }
}

fn errorRead(comptime file: []const u8) TOMLError!type {
    @setEvalBranchQuota(100000);
    comptime {
        const lexed = try lex.lex(file);

        for (lexed) |entry| {
            if (entry.content) |content| {
                utils.comptimeLog("lex '{}' <=> '{s}'", .{ entry.token, content });
            } else {
                utils.comptimeLog("lex '{}'", .{entry.token});
            }
        }

        return try parse.parse(lexed);
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
    if (errorRead(@embedFile("test/valid/bool/bool.toml"))) |TOML| {
        const toml = TOML {};
        try std.testing.expect(toml.f == false);
        try std.testing.expect(toml.t == true);
    } else |err| {
        return err;
    }
}

test "test.valid.comment.after-literal-no-ws" {
    // see: test/valid/comment/after-literal-no-ws.json
    if (errorRead(@embedFile("test/valid/comment/after-literal-no-ws.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        try std.testing.expect(toml.false == false);
        try std.testing.expect(toml.true == true);
        // try std.testing.expect(toml.inf == std.math.inf(f32));
        // try std.testing.expect(toml.nan == std.math.nan(f32));
    } else |err| {
        return err;
    }
}

test "test.valid.comment.at-eof" {
    // see: test/valid/comment/at-eof.json
    if (errorRead(@embedFile("test/valid/comment/at-eof.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.comment.at-eof2" {
    // see: test/valid/comment/at-eof2.json
    if (errorRead(@embedFile("test/valid/comment/at-eof2.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.comment.everywhere" {
    // see: test/valid/comment/everywhere.json
    if (errorRead(@embedFile("test/valid/comment/everywhere.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.comment.noeol" {
    // see: test/valid/comment/noeol.json
    if (errorRead(@embedFile("test/valid/comment/noeol.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.comment.nonascii" {
    // see: test/valid/comment/nonascii.json
    if (errorRead(@embedFile("test/valid/comment/nonascii.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.comment.tricky" {
    // see: test/valid/comment/tricky.json
    if (errorRead(@embedFile("test/valid/comment/tricky.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

// TODO: No date time support will be included
test "test.valid.datetime.datetime" {
    // see: test/valid/datetime/datetime.json
    if (errorRead(@embedFile("test/valid/datetime/datetime.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.datetime.edge" {
    // see: test/valid/datetime/edge.json
    if (errorRead(@embedFile("test/valid/datetime/edge.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.datetime.leap-year" {
    // see: test/valid/datetime/leap-year.json
    if (errorRead(@embedFile("test/valid/datetime/leap-year.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.datetime.local" {
    // see: test/valid/datetime/local.json
    if (errorRead(@embedFile("test/valid/datetime/local.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.datetime.local-date" {
    // see: test/valid/datetime/local-date.json
    if (errorRead(@embedFile("test/valid/datetime/local-date.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.datetime.local-time" {
    // see: test/valid/datetime/local-time.json
    if (errorRead(@embedFile("test/valid/datetime/local-time.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.datetime.milliseconds" {
    // see: test/valid/datetime/milliseconds.json
    if (errorRead(@embedFile("test/valid/datetime/milliseconds.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.datetime.timezone" {
    // see: test/valid/datetime/timezone.json
    if (errorRead(@embedFile("test/valid/datetime/timezone.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.empty-file" {
    // see: test/valid/empty-file.json
    if (errorRead(@embedFile("test/valid/empty-file.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.example" {
    // see: test/valid/example.json
    if (errorRead(@embedFile("test/valid/example.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.float.exponent" {
    // see: test/valid/float/exponent.json
    if (errorRead(@embedFile("test/valid/float/exponent.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.float.float" {
    // see: test/valid/float/float.json
    if (errorRead(@embedFile("test/valid/float/float.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.float.inf-and-nan" {
    // see: test/valid/float/inf-and-nan.json
    if (errorRead(@embedFile("test/valid/float/inf-and-nan.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.float.long" {
    // see: test/valid/float/long.json
    if (errorRead(@embedFile("test/valid/float/long.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.float.max-int" {
    // see: test/valid/float/max-int.json
    if (errorRead(@embedFile("test/valid/float/max-int.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.float.underscore" {
    // see: test/valid/float/underscore.json
    if (errorRead(@embedFile("test/valid/float/underscore.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.float.zero" {
    // see: test/valid/float/zero.json
    if (errorRead(@embedFile("test/valid/float/zero.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.implicit-and-explicit-after" {
    // see: test/valid/implicit-and-explicit-after.json
    if (errorRead(@embedFile("test/valid/implicit-and-explicit-after.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.implicit-and-explicit-before" {
    // see: test/valid/implicit-and-explicit-before.json
    if (errorRead(@embedFile("test/valid/implicit-and-explicit-before.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.implicit-groups" {
    // see: test/valid/implicit-groups.json
    if (errorRead(@embedFile("test/valid/implicit-groups.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.inline-table.array" {
    // see: test/valid/inline-table/array.json
    if (errorRead(@embedFile("test/valid/inline-table/array.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.inline-table.array-values" {
    // see: test/valid/inline-table/array-values.json
    if (errorRead(@embedFile("test/valid/inline-table/array-values.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.inline-table.bool" {
    // see: test/valid/inline-table/bool.json
    if (errorRead(@embedFile("test/valid/inline-table/bool.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.inline-table.empty" {
    // see: test/valid/inline-table/empty.json
    if (errorRead(@embedFile("test/valid/inline-table/empty.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.inline-table.end-in-bool" {
    // see: test/valid/inline-table/end-in-bool.json
    if (errorRead(@embedFile("test/valid/inline-table/end-in-bool.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.inline-table.inline-table" {
    // see: test/valid/inline-table/inline-table.json
    if (errorRead(@embedFile("test/valid/inline-table/inline-table.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.inline-table.key-dotted-1" {
    // see: test/valid/inline-table/key-dotted-1.json
    if (errorRead(@embedFile("test/valid/inline-table/key-dotted-1.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.inline-table.key-dotted-2" {
    // see: test/valid/inline-table/key-dotted-2.json
    if (errorRead(@embedFile("test/valid/inline-table/key-dotted-2.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.inline-table.key-dotted-3" {
    // see: test/valid/inline-table/key-dotted-3.json
    if (errorRead(@embedFile("test/valid/inline-table/key-dotted-3.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.inline-table.key-dotted-4" {
    // see: test/valid/inline-table/key-dotted-4.json
    if (errorRead(@embedFile("test/valid/inline-table/key-dotted-4.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.inline-table.key-dotted-5" {
    // see: test/valid/inline-table/key-dotted-5.json
    if (errorRead(@embedFile("test/valid/inline-table/key-dotted-5.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.inline-table.key-dotted-6" {
    // see: test/valid/inline-table/key-dotted-6.json
    if (errorRead(@embedFile("test/valid/inline-table/key-dotted-6.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.inline-table.key-dotted-7" {
    // see: test/valid/inline-table/key-dotted-7.json
    if (errorRead(@embedFile("test/valid/inline-table/key-dotted-7.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.inline-table.multiline" {
    // see: test/valid/inline-table/multiline.json
    if (errorRead(@embedFile("test/valid/inline-table/multiline.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.inline-table.nest" {
    // see: test/valid/inline-table/nest.json
    if (errorRead(@embedFile("test/valid/inline-table/nest.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.inline-table.spaces" {
    // see: test/valid/inline-table/spaces.json
    if (errorRead(@embedFile("test/valid/inline-table/spaces.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.integer.float64-max" {
    // see: test/valid/integer/float64-max.json
    if (errorRead(@embedFile("test/valid/integer/float64-max.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.integer.integer" {
    // see: test/valid/integer/integer.json
    if (errorRead(@embedFile("test/valid/integer/integer.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.integer.literals" {
    // see: test/valid/integer/literals.json
    if (errorRead(@embedFile("test/valid/integer/literals.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.integer.long" {
    // see: test/valid/integer/long.json
    if (errorRead(@embedFile("test/valid/integer/long.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.integer.underscore" {
    // see: test/valid/integer/underscore.json
    if (errorRead(@embedFile("test/valid/integer/underscore.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.integer.zero" {
    // see: test/valid/integer/zero.json
    if (errorRead(@embedFile("test/valid/integer/zero.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.alphanum" {
    // see: test/valid/key/alphanum.json
    if (errorRead(@embedFile("test/valid/key/alphanum.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.case-sensitive" {
    // see: test/valid/key/case-sensitive.json
    if (errorRead(@embedFile("test/valid/key/case-sensitive.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.dotted-1" {
    // see: test/valid/key/dotted-1.json
    if (errorRead(@embedFile("test/valid/key/dotted-1.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.dotted-2" {
    // see: test/valid/key/dotted-2.json
    if (errorRead(@embedFile("test/valid/key/dotted-2.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.dotted-3" {
    // see: test/valid/key/dotted-3.json
    if (errorRead(@embedFile("test/valid/key/dotted-3.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.dotted-4" {
    // see: test/valid/key/dotted-4.json
    if (errorRead(@embedFile("test/valid/key/dotted-4.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.dotted-empty" {
    // see: test/valid/key/dotted-empty.json
    if (errorRead(@embedFile("test/valid/key/dotted-empty.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.empty-1" {
    // see: test/valid/key/empty-1.json
    if (errorRead(@embedFile("test/valid/key/empty-1.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.empty-2" {
    // see: test/valid/key/empty-2.json
    if (errorRead(@embedFile("test/valid/key/empty-2.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.empty-3" {
    // see: test/valid/key/empty-3.json
    if (errorRead(@embedFile("test/valid/key/empty-2.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.equals-nospace" {
    // see: test/valid/key/equals-nospace.json
    if (errorRead(@embedFile("test/valid/key/equals-nospace.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.escapes" {
    // see: test/valid/key/escapes.json
    if (errorRead(@embedFile("test/valid/key/escapes.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.numeric" {
    // see: test/valid/key/numeric.json
    if (errorRead(@embedFile("test/valid/key/numeric.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.numeric-dotted" {
    // see: test/valid/key/numeric-dotted.json
    if (errorRead(@embedFile("test/valid/key/numeric-dotted.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.quoted-dots" {
    // see: test/valid/key/quoted-dots.json
    if (errorRead(@embedFile("test/valid/key/quoted-dots.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.quoted-unicode" {
    // see: test/valid/key/quoted-unicode.json
    if (errorRead(@embedFile("test/valid/key/quoted-unicode.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.space" {
    // see: test/valid/key/space.json
    if (errorRead(@embedFile("test/valid/key/space.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.special-chars" {
    // see: test/valid/key/special-chars.json
    if (errorRead(@embedFile("test/valid/key/special-chars.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.special-word" {
    // see: test/valid/key/special-words.json
    if (errorRead(@embedFile("test/valid/key/special-word.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.start" {
    // see: test/valid/key/start.json
    if (errorRead(@embedFile("test/valid/key/start.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.key.zero" {
    // see: test/valid/key/zero.json
    if (errorRead(@embedFile("test/valid/key/zero.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.newline-crlf" {
    // see: test/valid/newline-crlf.json
    if (errorRead(@embedFile("test/valid/newline-crlf.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.newline-lf" {
    // see: test/valid/newline-lf.json
    if (errorRead(@embedFile("test/valid/newline-lf.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec-example-1" {
    // see: test/valid/spec-example-1.json
    if (errorRead(@embedFile("test/valid/spec-example-1.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec-example-1-compact" {
    // see: test/valid/spec-example-1-compact.json
    if (errorRead(@embedFile("test/valid/spec-example-1-compact.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.array-0" {
    // see: test/valid/spec/array-0.json
    if (errorRead(@embedFile("test/valid/spec/array-0.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.array-1" {
    // see: test/valid/spec/array-1.json
    if (errorRead(@embedFile("test/valid/spec/array-1.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.array-of-tables-0" {
    // see: test/valid/spec/array-of-tables-0.json
    if (errorRead(@embedFile("test/valid/spec/array-of-tables-0.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.array-of-tables-1" {
    // see: test/valid/spec/array-of-tables-1.json
    if (errorRead(@embedFile("test/valid/spec/array-of-tables-1.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.array-of-tables-2" {
    // see: test/valid/spec/array-of-tables-2.json
    if (errorRead(@embedFile("test/valid/spec/array-of-tables-2.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.boolean-0" {
    // see: test/valid/spec/boolean-0.json
    if (errorRead(@embedFile("test/valid/spec/boolean-0.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.comment-0" {
    // see: test/valid/spec/comment-0.json
    if (errorRead(@embedFile("test/valid/spec/comment-0.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.float-0" {
    // see: test/valid/spec/float-0.json
    if (errorRead(@embedFile("test/valid/spec/float-0.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.float-1" {
    // see: test/valid/spec/float-1.json
    if (errorRead(@embedFile("test/valid/spec/float-1.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.float-2" {
    // see: test/valid/spec/float-2.json
    if (errorRead(@embedFile("test/valid/spec/float-2.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.inline-table-0" {
    // see: test/valid/spec/inline-table-0.json
    if (errorRead(@embedFile("test/valid/spec/inline-table-0.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.inline-table-1" {
    // see: test/valid/spec/inline-table-1.json
    if (errorRead(@embedFile("test/valid/spec/inline-table-1.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.inline-table-2" {
    // see: test/valid/spec/inline-table-2.json
    if (errorRead(@embedFile("test/valid/spec/inline-table-2.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.inline-table-3" {
    // see: test/valid/spec/inline-table-3.json
    if (errorRead(@embedFile("test/valid/spec/inline-table-3.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.integer-0" {
    // see: test/valid/spec/integer-0.json
    if (errorRead(@embedFile("test/valid/spec/integer-0.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.integer-1" {
    // see: test/valid/spec/integer-1.json
    if (errorRead(@embedFile("test/valid/spec/integer-1.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.integer-2" {
    // see: test/valid/spec/integer-2.json
    if (errorRead(@embedFile("test/valid/spec/integer-2.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.key-value-pair-0" {
    // see: test/valid/spec/key-value-pair-0.json
    if (errorRead(@embedFile("test/valid/spec/key-value-pair-0.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.keys-0" {
    // see: test/valid/spec/keys-0.json
    if (errorRead(@embedFile("test/valid/spec/keys-0.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.keys-1" {
    // see: test/valid/spec/keys-1.json
    if (errorRead(@embedFile("test/valid/spec/keys-1.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.keys-3" {
    // see: test/valid/spec/keys-3.json
    if (errorRead(@embedFile("test/valid/spec/keys-3.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.keys-4" {
    // see: test/valid/spec/keys-4.json
    if (errorRead(@embedFile("test/valid/spec/keys-4.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}

test "test.valid.spec.keys-5" {
    // see: test/valid/spec/keys-5.json
    if (errorRead(@embedFile("test/valid/spec/keys-5.toml"))) |TOML| {
        // TODO
        const toml = TOML {};
        _ = toml;
    } else |err| {
        return err;
    }
}
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

inline fn shouldError(comptime file: []const u8) TOMLError!void {
    comptime {
        if (errorRead(@embedFile(file))) |TOML| {
            _ = TOML;
            return TOMLError.UnexpectedToken;
        } else |err| {
            err catch {};
        }
    }
}

test "test.invalid.array.double-comma-1" {
    try shouldError("test/invalid/array/double-comma-1.toml");
}

test "test.invalid.array.double-comma-2" {
    try shouldError("test/invalid/array/double-comma-2.toml");
}

test "test.invalid.array.extend-defined-aot" {
    try shouldError("test/invalid/array/extend-defined-aot.toml");
}

test "test.invalid.array.extending-table" {
    try shouldError("test/invalid/array/extending-table.toml");
}

test "test.invalid.array.missing-separator-1" {
    try shouldError("test/invalid/array/missing-separator-1.toml");
}

test "test.invalid.array.missing-separator-2" {
    try shouldError("test/invalid/array/missing-separator-2.toml");
}

test "test.invalid.array.no-close-1" {
    try shouldError("test/invalid/array/no-close-1.toml");
}

test "test.invalid.array.no-close-2" {
    try shouldError("test/invalid/array/no-close-2.toml");
}

test "test.invalid.array.no-close-3" {
    try shouldError("test/invalid/array/no-close-3.toml");
}

test "test.invalid.array.no-close-4" {
    try shouldError("test/invalid/array/no-close-4.toml");
}

test "test.invalid.array.no-close-5" {
    try shouldError("test/invalid/array/no-close-5.toml");
}

test "test.invalid.array.no-close-6" {
    try shouldError("test/invalid/array/no-close-6.toml");
}

test "test.invalid.array.no-close-7" {
    try shouldError("test/invalid/array/no-close-7.toml");
}

test "test.invalid.array.no-close-8" {
    try shouldError("test/invalid/array/no-close-8.toml");
}

test "test.invalid.array.no-close-table-1" {
    try shouldError("test/invalid/array/no-close-table-1.toml");
}

test "test.invalid.array.no-close-table-2" {
    try shouldError("test/invalid/array/no-close-table-2.toml");
}

test "test.invalid.array.no-comma-1" {
    try shouldError("test/invalid/array/no-comma-1.toml");
}

test "test.invalid.array.no-comma-2" {
    try shouldError("test/invalid/array/no-comma-2.toml");
}

test "test.invalid.array.no-comma-3" {
    try shouldError("test/invalid/array/no-comma-3.toml");
}

test "test.invalid.array.only-comma-1" {
    try shouldError("test/invalid/array/only-comma-1.toml");
}

test "test.invalid.array.only-comma-2" {
    try shouldError("test/invalid/array/only-comma-2.toml");
}

test "test.invalid.array.tables-1" {
    try shouldError("test/invalid/array/tables-1.toml");
}

test "test.invalid.array.tables-2" {
    try shouldError("test/invalid/array/tables-2.toml");
}

test "test.invalid.array.text-after-array-entries" {
    try shouldError("test/invalid/array/text-after-array-entries.toml");
}

test "test.invalid.array.text-before-array-separator" {
    try shouldError("test/invalid/array/text-before-array-separator.toml");
}

test "test.invalid.array.text-in-array" {
    try shouldError("test/invalid/array/text-in-array.toml");
}

test "test.invalid.bool.almost-false" {
    try shouldError("test/invalid/bool/almost-false.toml");
}

test "test.invalid.bool.almost-false-with-extra" {
    try shouldError("test/invalid/bool/almost-false-with-extra.toml");
}

test "test.invalid.bool.almost-true" {
    try shouldError("test/invalid/bool/almost-true.toml");
}

test "test.invalid.bool.almost-true-with-extra" {
    try shouldError("test/invalid/bool/almost-true-with-extra.toml");
}

test "test.invalid.bool.capitalized-false" {
    try shouldError("test/invalid/bool/capitalized-false.toml");
}

test "test.invalid.bool.capitalized-true" {
    try shouldError("test/invalid/bool/capitalized-true.toml");
}

test "test.invalid.bool.just-f" {
    try shouldError("test/invalid/bool/just-f.toml");
}

test "test.invalid.bool.just-t" {
    try shouldError("test/invalid/bool/just-t.toml");
}

test "test.invalid.bool.mixed-case" {
    try shouldError("test/invalid/bool/mixed-case.toml");
}

test "test.invalid.bool.mixed-case-false" {
    try shouldError("test/invalid/bool/mixed-case-false.toml");
}

test "test.invalid.bool.mixed-case-true" {
    try shouldError("test/invalid/bool/mixed-case-true.toml");
}

test "test.invalid.bool.starting-same-false" {
    try shouldError("test/invalid/bool/starting-same-false.toml");
}

test "test.invalid.bool.starting-same-true" {
    try shouldError("test/invalid/bool/starting-same-true.toml");
}

test "test.invalid.bool.wrong-case-false" {
    try shouldError("test/invalid/bool/wrong-case-false.toml");
}

test "test.invalid.bool.wrong-case-true" {
    try shouldError("test/invalid/bool/wrong-case-true.toml");
}

test "test.invalid.control.bare-cr" {
    try shouldError("test/invalid/control/bare-cr.toml");
}

test "test.invalid.control.bare-formfeed" {
    try shouldError("test/invalid/control/bare-formfeed.toml");
}

test "test.invalid.control.bare-null" {
    try shouldError("test/invalid/control/bare-null.toml");
}

test "test.invalid.control.bare-vertical-tab" {
    try shouldError("test/invalid/control/bare-vertical-tab.toml");
}

test "test.invalid.control.comment-cr" {
    try shouldError("test/invalid/control/comment-cr.toml");
}

test "test.invalid.control.comment-del" {
    try shouldError("test/invalid/control/comment-del.toml");
}

test "test.invalid.control.comment-ff" {
    try shouldError("test/invalid/control/comment-ff.toml");
}

test "test.invalid.control.comment-lf" {
    try shouldError("test/invalid/control/comment-lf.toml");
}

test "test.invalid.control.comment-null" {
    try shouldError("test/invalid/control/comment-null.toml");
}

test "test.invalid.control.comment-us" {
    try shouldError("test/invalid/control/comment-us.toml");
}

test "test.invalid.control.multi-cr" {
    try shouldError("test/invalid/control/multi-cr.toml");
}

test "test.invalid.control.multi-del" {
    try shouldError("test/invalid/control/multi-del.toml");
}

test "test.invalid.control.multi-lf" {
    try shouldError("test/invalid/control/multi-lf.toml");
}

test "test.invalid.control.multi-null" {
    try shouldError("test/invalid/control/multi-null.toml");
}

test "test.invalid.control.multi-us" {
    try shouldError("test/invalid/control/multi-us.toml");
}

test "test.invalid.control.rawmulti-cd" {
    try shouldError("test/invalid/control/rawmulti-cd.toml");
}

test "test.invalid.control.rawmulti-del" {
    try shouldError("test/invalid/control/rawmulti-del.toml");
}

test "test.invalid.control.rawmulti-lf" {
    try shouldError("test/invalid/control/rawmulti-lf.toml");
}

test "test.invalid.control.rawmulti-null" {
    try shouldError("test/invalid/control/rawmulti-null.toml");
}

test "test.invalid.control.rawmulti-us" {
    try shouldError("test/invalid/control/rawmulti-us.toml");
}

test "test.invalid.control.rawstring-cr" {
    try shouldError("test/invalid/control/rawstring-cr.toml");
}

test "test.invalid.control.rawstring-del" {
    try shouldError("test/invalid/control/rawstring-del.toml");
}

test "test.invalid.control.rawstring-lf" {
    try shouldError("test/invalid/control/rawstring-lf.toml");
}

test "test.invalid.control.rawstring-null" {
    try shouldError("test/invalid/control/rawstring-null.toml");
}

test "test.invalid.control.rawstring-us" {
    try shouldError("test/invalid/control/rawstring-us.toml");
}

test "test.invalid.control.string-bs" {
    try shouldError("test/invalid/control/string-bs.toml");
}

test "test.invalid.control.string-cr" {
    try shouldError("test/invalid/control/string-cr.toml");
}

test "test.invalid.control.string-del" {
    try shouldError("test/invalid/control/string-del.toml");
}

test "test.invalid.control.string-lf" {
    try shouldError("test/invalid/control/string-lf.toml");
}

test "test.invalid.control.string-null" {
    try shouldError("test/invalid/control/string-null.toml");
}

test "test.invalid.control.string-us" {
    try shouldError("test/invalid/control/string-us.toml");
}

test "test.invalid.datetime.feb-29" {
    try shouldError("test/invalid/datetime/feb-29.toml");
}

test "test.invalid.datetime.feb-30" {
    try shouldError("test/invalid/datetime/feb-30.toml");
}

test "test.invalid.datetime.hour-over" {
    try shouldError("test/invalid/datetime/hour-over.toml");
}

test "test.invalid.datetime.mday-over" {
    try shouldError("test/invalid/datetime/mday-over.toml");
}

test "test.invalid.datetime.mday-under" {
    try shouldError("test/invalid/datetime/mday-under.toml");
}

test "test.invalid.datetime.minute-over" {
    try shouldError("test/invalid/datetime/minute-over.toml");
}

test "test.invalid.datetime.month-over" {
    try shouldError("test/invalid/datetime/month-over.toml");
}

test "test.invalid.datetime.month-under" {
    try shouldError("test/invalid/datetime/month-under.toml");
}

test "test.invalid.datetime.no-leads" {
    try shouldError("test/invalid/datetime/no-leads.toml");
}

test "test.invalid.datetime.no-leads-month" {
    try shouldError("test/invalid/datetime/no-leads-month.toml");
}

test "test.invalid.datetime.no-leads-with-milli" {
    try shouldError("test/invalid/datetime/no-leads-with-milli.toml");
}

test "test.invalid.datetime.no-secs" {
    try shouldError("test/invalid/datetime/no-secs.toml");
}

test "test.invalid.datetime.no-t" {
    try shouldError("test/invalid/datetime/no-t.toml");
}

test "test.invalid.datetime.offset-overflow-hour" {
    try shouldError("test/invalid/datetime/offset-overflow-hour.toml");
}

test "test.invalid.datetime.offset-overflow-minute" {
    try shouldError("test/invalid/datetime/offset-overflow-minute.toml");
}

test "test.invalid.datetime.second-over" {
    try shouldError("test/invalid/datetime/second-over.toml");
}

test "test.invalid.datetime.time-no-leads" {
    try shouldError("test/invalid/datetime/time-no-leads.toml");
}

test "test.invalid.datetime.y10k" {
    try shouldError("test/invalid/datetime/y10k.toml");
}

test "test.invalid.encoding.bad-codepoint" {
    try shouldError("test/invalid/encoding/bad-codepoint.toml");
}

test "test.invalid.encoding.bad-utf8-at-end" {
    try shouldError("test/invalid/encoding/bad-utf8-at-end.toml");
}

test "test.invalid.encoding.bad-utf8-in-comment" {
    try shouldError("test/invalid/encoding/bad-utf8-in-comment.toml");
}

test "test.invalid.encoding.bad-utf8-in-multiline" {
    try shouldError("test/invalid/encoding/bad-utf8-in-multiline.toml");
}

test "test.invalid.encoding.bad-utf8-in-multiline-literal" {
    try shouldError("test/invalid/encoding/bad-utf8-in-multiline-literal.toml");
}

test "test.invalid.encoding.bad-utf8-in-string" {
    try shouldError("test/invalid/encoding/bad-utf8-in-string.toml");
}

test "test.invalid.encoding.bad-utf8-in-string-literal" {
    try shouldError("test/invalid/encoding/bad-utf8-in-string-literal.toml");
}

test "test.invalid.encoding.bom-not-at-start-1" {
    try shouldError("test/invalid/encoding/bom-not-at-start-1.toml");
}

test "test.invalid.encoding.bom-not-at-start-2" {
    try shouldError("test/invalid/encoding/bom-not-at-start-2.toml");
}

test "test.invalid.encoding.utf16-bom" {
    try shouldError("test/invalid/encoding/utf16-bom.toml");
}

test "test.invalid.encoding.utf16-comment" {
    try shouldError("test/invalid/encoding/utf16-comment.toml");
}

test "test.invalid.encoding.utf16-key" {
    try shouldError("test/invalid/encoding/utf16-key.toml");
}

test "test.invalid.float.double-point-1" {
    try shouldError("test/invalid/float/double-point-1.toml");
}

test "test.invalid.float.double-point-2" {
    try shouldError("test/invalid/float/double-point-2.toml");
}

test "test.invalid.float.exp-double-e-1" {
    try shouldError("test/invalid/float/exp-double-e-1.toml");
}

test "test.invalid.float.exp-double-e-2" {
    try shouldError("test/invalid/float/exp-double-e-2.toml");
}

test "test.invalid.float.exp-double-us" {
    try shouldError("test/invalid/float/exp-double-us.toml");
}

test "test.invalid.float.exp-leading-us" {
    try shouldError("test/invalid/float/exp-leading-us.toml");
}

test "test.invalid.float.exp-point-1" {
    try shouldError("test/invalid/float/exp-point-1.toml");
}

test "test.invalid.float.exp-point-2" {
    try shouldError("test/invalid/float/exp-point-2.toml");
}

test "test.invalid.float.exp-point-3" {
    try shouldError("test/invalid/float/exp-point-3.toml");
}

test "test.invalid.float.exp-trailing-us" {
    try shouldError("test/invalid/float/exp-trailing-us.toml");
}

test "test.invalid.float.exp-trailing-us-1" {
    try shouldError("test/invalid/float/exp-trailing-us-1.toml");
}

test "test.invalid.float.exp-trailing-us-2" {
    try shouldError("test/invalid/float/exp-trailing-us-2.toml");
}

test "test.invalid.float.inf-capital" {
    try shouldError("test/invalid/float/inf-capital.toml");
}

test "test.invalid.float.inf-incomplete-1" {
    try shouldError("test/invalid/float/inf-incomplete-1.toml");
}

test "test.invalid.float.inf-incomplete-2" {
    try shouldError("test/invalid/float/inf-incomplete-2.toml");
}

test "test.invalid.float.inf-incomplete-3" {
    try shouldError("test/invalid/float/inf-incomplete-3.toml");
}

test "test.invalid.float.inf_underscore" {
    try shouldError("test/invalid/float/inf_underscore.toml");
}

test "test.invalid.float.leading-point" {
    try shouldError("test/invalid/float/leading-point.toml");
}

test "test.invalid.float.leading-point-neg" {
    try shouldError("test/invalid/float/leading-point-neg.toml");
}

test "test.invalid.float.leading-point-plus" {
    try shouldError("test/invalid/float/leading-point-plus.toml");
}

test "test.invalid.float.leading-us" {
    try shouldError("test/invalid/float/leading-us.toml");
}

test "test.invalid.float.leading-zero" {
    try shouldError("test/invalid/float/leading-zero.toml");
}

test "test.invalid.float.leading-zero-neg" {
    try shouldError("test/invalid/float/leading-zero-neg.toml");
}

test "test.invalid.float.leading-zero-plus" {
    try shouldError("test/invalid/float/leading-zero-plus.toml");
}

test "test.invalid.float.nan-capital" {
    try shouldError("test/invalid/float/nan-capital.toml");
}

test "test.invalid.float.nan-incomplete-1" {
    try shouldError("test/invalid/float/nan-incomplete-1.toml");
}

test "test.invalid.float.nan-incomplete-2" {
    try shouldError("test/invalid/float/nan-incomplete-2.toml");
}

test "test.invalid.float.nan-incomplete-3" {
    try shouldError("test/invalid/float/nan-incomplete-3.toml");
}

test "test.invalid.float.nan_underscore" {
    try shouldError("test/invalid/float/nan_underscore.toml");
}

test "test.invalid.float.trailing-point" {
    try shouldError("test/invalid/float/trailing-point.toml");
}

test "test.invalid.float.trailing-point-min" {
    try shouldError("test/invalid/float/trailing-point-min.toml");
}

test "test.invalid.float.trailing-point-plus" {
    try shouldError("test/invalid/float/trailing-point-plus.toml");
}

test "test.invalid.float.trailing-us" {
    try shouldError("test/invalid/float/trailing-us.toml");
}

test "test.invalid.float.trailing-us-exp-1" {
    try shouldError("test/invalid/float/trailing-us-exp-1.toml");
}

test "test.invalid.float.trailing-us-exp-2" {
    try shouldError("test/invalid/float/trailing-us-exp-2.toml");
}

test "test.invalid.float.us-after-point" {
    try shouldError("test/invalid/float/us-after-point.toml");
}

test "test.invalid.float.us-before-point" {
    try shouldError("test/invalid/float/us-before-point.toml");
}

test "test.invalid.inline-table.bad-key-syntax" {
    try shouldError("test/invalid/inline-table/bad-key-syntax.toml");
}

test "test.invalid.inline-table.double-comma" {
    try shouldError("test/invalid/inline-table/double-comma.toml");
}

test "test.invalid.inline-table.duplicate-key-1" {
    try shouldError("test/invalid/inline-table/duplicate-key-1.toml");
}

test "test.invalid.inline-table.duplicate-key-2" {
    try shouldError("test/invalid/inline-table/duplicate-key-2.toml");
}

test "test.invalid.inline-table.duplicate-key-3" {
    try shouldError("test/invalid/inline-table/duplicate-key-3.toml");
}

test "test.invalid.inline-table.duplicate-key-4" {
    try shouldError("test/invalid/inline-table/duplicate-key-4.toml");
}

test "test.invalid.inline-table.empty-1" {
    try shouldError("test/invalid/inline-table/empty-1.toml");
}

test "test.invalid.inline-table.empty-2" {
    try shouldError("test/invalid/inline-table/empty-2.toml");
}

test "test.invalid.inline-table.empty-3" {
    try shouldError("test/invalid/inline-table/empty-3.toml");
}

test "test.invalid.inline-table.linebreak-1" {
    try shouldError("test/invalid/inline-table/linebreak-1.toml");
}

test "test.invalid.inline-table.linebreak-2" {
    try shouldError("test/invalid/inline-table/linebreak-2.toml");
}

test "test.invalid.inline-table.linebreak-3" {
    try shouldError("test/invalid/inline-table/linebreak-3.toml");
}

test "test.invalid.inline-table.linebreak-4" {
    try shouldError("test/invalid/inline-table/linebreak-4.toml");
}

test "test.invalid.inline-table.no-close-1" {
    try shouldError("test/invalid/inline-table/no-close-1.toml");
}

test "test.invalid.inline-table.no-close-2" {
    try shouldError("test/invalid/inline-table/no-close-2.toml");
}

test "test.invalid.inline-table.no-comma-1" {
    try shouldError("test/invalid/inline-table/no-comma-1.toml");
}

test "test.invalid.inline-table.no-comma-2" {
    try shouldError("test/invalid/inline-table/no-comma-2.toml");
}

test "test.invalid.inline-table.overwrite-01" {
    try shouldError("test/invalid/inline-table/overwrite-01.toml");
}

test "test.invalid.inline-table.overwrite-02" {
    try shouldError("test/invalid/inline-table/overwrite-02.toml");
}

test "test.invalid.inline-table.overwrite-03" {
    try shouldError("test/invalid/inline-table/overwrite-03.toml");
}

test "test.invalid.inline-table.overwrite-04" {
    try shouldError("test/invalid/inline-table/overwrite-04.toml");
}

test "test.invalid.inline-table.overwrite-05" {
    try shouldError("test/invalid/inline-table/overwrite-05.toml");
}

test "test.invalid.inline-table.overwrite-06" {
    try shouldError("test/invalid/inline-table/overwrite-06.toml");
}

test "test.invalid.inline-table.overwrite-07" {
    try shouldError("test/invalid/inline-table/overwrite-07.toml");
}

test "test.invalid.inline-table.overwrite-08" {
    try shouldError("test/invalid/inline-table/overwrite-08.toml");
}

test "test.invalid.inline-table.overwrite-09" {
    try shouldError("test/invalid/inline-table/overwrite-09.toml");
}

test "test.invalid.inline-table.overwrite-10" {
    try shouldError("test/invalid/inline-table/overwrite-10.toml");
}

test "test.invalid.inline-table.trailing-comma" {
    try shouldError("test/invalid/inline-table/trailing-comma.toml");
}

test "test.invalid.integer.capital-bin" {
    try shouldError("test/invalid/integer/capital-bin.toml");
}

test "test.invalid.integer.capital-hex" {
    try shouldError("test/invalid/integer/capital-hex.toml");
}

test "test.invalid.integer.capital-oct" {
    try shouldError("test/invalid/integer/capital-oct.toml");
}

test "test.invalid.integer.double-sign-nex" {
    try shouldError("test/invalid/integer/double-sign-nex.toml");
}

test "test.invalid.integer.double-sign-plus" {
    try shouldError("test/invalid/integer/double-sign-plus.toml");
}

test "test.invalid.integer.double-us" {
    try shouldError("test/invalid/integer/double-us.toml");
}

test "test.invalid.integer.incomplete-bin" {
    try shouldError("test/invalid/integer/incomplete-bin.toml");
}

test "test.invalid.integer.incomplete-hex" {
    try shouldError("test/invalid/integer/incomplete-hex.toml");
}

test "test.invalid.integer.incomplete-oct" {
    try shouldError("test/invalid/integer/incomplete-oct.toml");
}

test "test.invalid.integer.invalid-bin" {
    try shouldError("test/invalid/integer/invalid-bin.toml");
}

test "test.invalid.integer.invalid-hex" {
    try shouldError("test/invalid/integer/invalid-hex.toml");
}

test "test.invalid.integer.invalid-hex-1" {
    try shouldError("test/invalid/integer/invalid-hex-1.toml");
}

test "test.invalid.integer.invalid-hex-2" {
    try shouldError("test/invalid/integer/invalid-hex-2.toml");
}

test "test.invalid.integer.invalid-oct" {
    try shouldError("test/invalid/integer/invalid-oct.toml");
}

test "test.invalid.integer.leading-us" {
    try shouldError("test/invalid/integer/leading-us.toml");
}

test "test.invalid.integer.leading-us-bin" {
    try shouldError("test/invalid/integer/leading-us-bin.toml");
}

test "test.invalid.integer.leading-us-hex" {
    try shouldError("test/invalid/integer/leading-us-hex.toml");
}

test "test.invalid.integer.leading-us-oct" {
    try shouldError("test/invalid/integer/leading-us-oct.toml");
}

test "test.invalid.integer.leading-zero-1" {
    try shouldError("test/invalid/integer/leading-zero-1.toml");
}

test "test.invalid.integer.leading-zero-2" {
    try shouldError("test/invalid/integer/leading-zero-2.toml");
}

test "test.invalid.integer.leading-zero-3" {
    try shouldError("test/invalid/integer/leading-zero-3.toml");
}

test "test.invalid.integer.leading-zero-sign-1" {
    try shouldError("test/invalid/integer/leading-zero-sign-1.toml");
}

test "test.invalid.integer.leading-zero-sign-2" {
    try shouldError("test/invalid/integer/leading-zero-sign-2.toml");
}

test "test.invalid.integer.leading-zero-sign-3" {
    try shouldError("test/invalid/integer/leading-zero-sign-3.toml");
}

test "test.invalid.integer.negative-bin" {
    try shouldError("test/invalid/integer/negative-bin.toml");
}

test "test.invalid.integer.negative-hex" {
    try shouldError("test/invalid/integer/negative-hex.toml");
}

test "test.invalid.integer.negative-oct" {
    try shouldError("test/invalid/integer/negative-oct.toml");
}

test "test.invalid.integer.positive-bin" {
    try shouldError("test/invalid/integer/positive-bin.toml");
}

test "test.invalid.integer.positive-hex" {
    try shouldError("test/invalid/integer/positive-hex.toml");
}

test "test.invalid.integer.positive-oct" {
    try shouldError("test/invalid/integer/positive-oct.toml");
}

test "test.invalid.integer.text-after-integer" {
    try shouldError("test/invalid/integer/text-after-integer.toml");
}

test "test.invalid.integer.trailing-us" {
    try shouldError("test/invalid/integer/trailing-us.toml");
}

test "test.invalid.integer.trailing-us-bin" {
    try shouldError("test/invalid/integer/trailing-us-bin.toml");
}

test "test.invalid.integer.trailing-us-hex" {
    try shouldError("test/invalid/integer/trailing-us-hex.toml");
}

test "test.invalid.integer.trailing-us-oct" {
    try shouldError("test/invalid/integer/trailing-us-oct.toml");
}

test "test.invalid.integer.us-after-bin" {
    try shouldError("test/invalid/integer/us-after-bin.toml");
}

test "test.invalid.integer.us-after-hex" {
    try shouldError("test/invalid/integer/us-after-hex.toml");
}

test "test.invalid.integer.us-after-oct" {
    try shouldError("test/invalid/integer/us-after-oct.toml");
}

test "test.invalid.key.after-array" {
    try shouldError("test/invalid/key/after-array.toml");
}

test "test.invalid.key.after-table" {
    try shouldError("test/invalid/key/after-table.toml");
}

test "test.invalid.key.after-value" {
    try shouldError("test/invalid/key/after-value.toml");
}

test "test.invalid.key.bare-invalid-character" {
    try shouldError("test/invalid/key/bare-invalid-character.toml");
}

test "test.invalid.key.dotted-redefine-table-1" {
    try shouldError("test/invalid/key/dotted-redefine-table-1.toml");
}

test "test.invalid.key.dotted-redefine-table-2" {
    try shouldError("test/invalid/key/dotted-redefine-table-2.toml");
}

test "test.invalid.key.duplicate-keys-1" {
    try shouldError("test/invalid/key/duplicate-keys-1.toml");
}

test "test.invalid.key.duplicate-keys-2" {
    try shouldError("test/invalid/key/duplicate-keys-2.toml");
}

test "test.invalid.key.duplicate-keys-3" {
    try shouldError("test/invalid/key/duplicate-keys-3.toml");
}

test "test.invalid.key.duplicate-keys-4" {
    try shouldError("test/invalid/key/duplicate-keys-4.toml");
}

test "test.invalid.key.empty" {
    try shouldError("test/invalid/key/empty.toml");
}

test "test.invalid.key.end-in-escape" {
    try shouldError("test/invalid/key/end-in-escape.toml");
}

test "test.invalid.key.escape" {
    try shouldError("test/invalid/key/escape.toml");
}

test "test.invalid.key.hash" {
    try shouldError("test/invalid/key/hash.toml");
}

test "test.invalid.key.newline-1" {
    try shouldError("test/invalid/key/newline-1.toml");
}

test "test.invalid.key.newline-2" {
    try shouldError("test/invalid/key/newline-2.toml");
}

test "test.invalid.key.newline-3" {
    try shouldError("test/invalid/key/newline-3.toml");
}

test "test.invalid.key.newline-4" {
    try shouldError("test/invalid/key/newline-4.toml");
}

test "test.invalid.key.newline-5" {
    try shouldError("test/invalid/key/newline-5.toml");
}

test "test.invalid.key.no-eol" {
    try shouldError("test/invalid/key/no-eol.toml");
}

test "test.invalid.key.open-bracket" {
    try shouldError("test/invalid/key/open-bracket.toml");
}

test "test.invalid.key.partial-quoted" {
    try shouldError("test/invalid/key/partial-quoted.toml");
}

test "test.invalid.key.quoted-unclosed-1" {
    try shouldError("test/invalid/key/quoted-unclosed-1.toml");
}

test "test.invalid.key.quoted-unclosed-2" {
    try shouldError("test/invalid/key/quoted-unclosed-2.toml");
}

test "test.invalid.key.single-open-bracket" {
    try shouldError("test/invalid/key/single-open-bracket.toml");
}

test "test.invalid.key.space" {
    try shouldError("test/invalid/key/space.toml");
}

test "test.invalid.key.special-character" {
    try shouldError("test/invalid/key/special-character.toml");
}

test "test.invalid.key.start-bracket" {
    try shouldError("test/invalid/key/start-bracket.toml");
}

test "test.invalid.key.start-dot" {
    try shouldError("test/invalid/key/start-dot.toml");
}

test "test.invalid.key.two-equals-1" {
    try shouldError("test/invalid/key/two-equals-1.toml");
}

test "test.invalid.key.two-equals-2" {
    try shouldError("test/invalid/key/two-equals-2.toml");
}

test "test.invalid.key.two-equals-3" {
    try shouldError("test/invalid/key/two-equals-3.toml");
}

test "test.invalid.key.without-value-1" {
    try shouldError("test/invalid/key/without-value-1.toml");
}

test "test.invalid.key.without-value-2" {
    try shouldError("test/invalid/key/without-value-2.toml");
}

test "test.invalid.key.without-value-3" {
    try shouldError("test/invalid/key/without-value-3.toml");
}

test "test.invalid.key.without-value-4" {
    try shouldError("test/invalid/key/without-value-4.toml");
}

test "test.invalid.key.without-value-5" {
    try shouldError("test/invalid/key/without-value-5.toml");
}

test "test.invalid.key.without-value-6" {
    try shouldError("test/invalid/key/without-value-6.toml");
}

test "test.invalid.key.without-value-7" {
    try shouldError("test/invalid/key/without-value-7.toml");
}

test "test.invalid.local-date.feb-29" {
    try shouldError("test/invalid/local-date/feb-29.toml");
}

test "test.invalid.local-date.feb-30" {
    try shouldError("test/invalid/local-date/feb-30.toml");
}

test "test.invalid.local-date.mday-over" {
    try shouldError("test/invalid/local-date/mday-over.toml");
}

test "test.invalid.local-date.mday-under" {
    try shouldError("test/invalid/local-date/mday-under.toml");
}

test "test.invalid.local-date.month-over" {
    try shouldError("test/invalid/local-date/month-over.toml");
}

test "test.invalid.local-date.month-under" {
    try shouldError("test/invalid/local-date/month-under.toml");
}

test "test.invalid.local-date.no-leads" {
    try shouldError("test/invalid/local-date/no-leads.toml");
}

test "test.invalid.local-date.no-leads-with-milli" {
    try shouldError("test/invalid/local-date/no-leads-with-milli.toml");
}

test "test.invalid.local-date.trailing-t" {
    try shouldError("test/invalid/local-date/trailing-t.toml");
}

test "test.invalid.local-date.y10k" {
    try shouldError("test/invalid/local-date/y10k.toml");
}

test "test.invalid.local-datetime.feb-29" {
    try shouldError("test/invalid/local-datetime/feb-29.toml");
}

test "test.invalid.local-datetime.feb-30" {
    try shouldError("test/invalid/local-datetime/feb-30.toml");
}

test "test.invalid.local-datetime.hour-over" {
    try shouldError("test/invalid/local-datetime/hour-over.toml");
}

test "test.invalid.local-datetime.mday-over" {
    try shouldError("test/invalid/local-datetime/mday-over.toml");
}

test "test.invalid.local-datetime.mday-under" {
    try shouldError("test/invalid/local-datetime/mday-under.toml");
}

test "test.invalid.local-datetime.minute-over" {
    try shouldError("test/invalid/local-datetime/minute-over.toml");
}

test "test.invalid.local-datetime.month-over" {
    try shouldError("test/invalid/local-datetime/month-over.toml");
}

test "test.invalid.local-datetime.month-under" {
    try shouldError("test/invalid/local-datetime/month-under.toml");
}

test "test.invalid.local-datetime.no-leads" {
    try shouldError("test/invalid/local-datetime/no-leads.toml");
}

test "test.invalid.local-datetime.no-leads-with-milli" {
    try shouldError("test/invalid/local-datetime/no-leads-with-milli.toml");
}

test "test.invalid.local-datetime.no-secs" {
    try shouldError("test/invalid/local-datetime/no-secs.toml");
}

test "test.invalid.local-datetime.no-t" {
    try shouldError("test/invalid/local-datetime/no-t.toml");
}

test "test.invalid.local-datetime.second-over" {
    try shouldError("test/invalid/local-datetime/second-over.toml");
}

test "test.invalid.local-datetime.time-no-leads" {
    try shouldError("test/invalid/local-datetime/time-no-leads.toml");
}

test "test.invalid.local-datetime.y10k" {
    try shouldError("test/invalid/local-datetime/y10k.toml");
}

test "test.invalid.local-time.hour-over" {
    try shouldError("test/invalid/local-time/hour-over.toml");
}

test "test.invalid.local-time.minute-over" {
    try shouldError("test/invalid/local-time/minute-over.toml");
}

test "test.invalid.local-time.no-secs" {
    try shouldError("test/invalid/local-time/no-secs.toml");
}

test "test.invalid.local-time.second-over" {
    try shouldError("test/invalid/local-time/second-over.toml");
}

test "test.invalid.local-time.time-no-leads" {
    try shouldError("test/invalid/local-time/time-no-leads.toml");
}

test "test.invalid.local-time.time-no-leads-2" {
    try shouldError("test/invalid/local-time/time-no-leads-2.toml");
}

test "test.invalid.spec.inline-table-2-0" {
    try shouldError("test/invalid/spec/inline-table-2-0.toml");
}

test "test.invalid.spec.inline-table-3-0" {
    try shouldError("test/invalid/spec/inline-table-3-0.toml");
}

test "test.invalid.spec.key-value-pair-1" {
    try shouldError("test/invalid/spec/key-value-pair-1.toml");
}

test "test.invalid.spec.keys-2" {
    try shouldError("test/invalid/spec/keys-2.toml");
}

test "test.invalid.spec.string-4-0" {
    try shouldError("test/invalid/spec/string-4-0.toml");
}

test "test.invalid.spec.string-7-0" {
    try shouldError("test/invalid/spec/string-7-0.toml");
}

test "test.invalid.spec.table-9-0" {
    try shouldError("test/invalid/spec/table-9-0.toml");
}

test "test.invalid.spec.table-9-1" {
    try shouldError("test/invalid/spec/table-9-1.toml");
}

test "test.invalid.string.bad-byte-escape" {
    try shouldError("test/invalid/string/bad-byte-escape.toml");
}

test "test.invalid.string.bad-concat" {
    try shouldError("test/invalid/string/bad-concat.toml");
}

test "test.invalid.string.bad-escape-1" {
    try shouldError("test/invalid/string/bad-escape-1.toml");
}

test "test.invalid.string.bad-escape-2" {
    try shouldError("test/invalid/string/bad-escape-2.toml");
}

test "test.invalid.string.bad-escape-3" {
    try shouldError("test/invalid/string/bad-escape-3.toml");
}

test "test.invalid.string.bad-hex-esc-1" {
    try shouldError("test/invalid/string/bad-hex-esc-1.toml");
}

test "test.invalid.string.bad-hex-esc-2" {
    try shouldError("test/invalid/string/bad-hex-esc-2.toml");
}

test "test.invalid.string.bad-hex-esc-3" {
    try shouldError("test/invalid/string/bad-hex-esc-3.toml");
}

test "test.invalid.string.bad-hex-esc-4" {
    try shouldError("test/invalid/string/bad-hex-esc-4.toml");
}

test "test.invalid.string.bad-hex-esc-5" {
    try shouldError("test/invalid/string/bad-hex-esc-5.toml");
}

test "test.invalid.string.bad-multiline" {
    try shouldError("test/invalid/string/bad-multiline.toml");
}

test "test.invalid.string.bad-slash-escape" {
    try shouldError("test/invalid/string/bad-slash-escape.toml");
}

test "test.invalid.string.bad-uni-esc-1" {
    try shouldError("test/invalid/string/bad-uni-esc-1.toml");
}

test "test.invalid.string.bad-uni-esc-2" {
    try shouldError("test/invalid/string/bad-uni-esc-2.toml");
}

test "test.invalid.string.bad-uni-esc-3" {
    try shouldError("test/invalid/string/bad-uni-esc-3.toml");
}

test "test.invalid.string.bad-uni-esc-4" {
    try shouldError("test/invalid/string/bad-uni-esc-4.toml");
}

test "test.invalid.string.bad-uni-esc-5" {
    try shouldError("test/invalid/string/bad-uni-esc-5.toml");
}

test "test.invalid.string.bad-uni-esc-6" {
    try shouldError("test/invalid/string/bad-uni-esc-6.toml");
}

test "test.invalid.string.bad-uni-esc-7" {
    try shouldError("test/invalid/string/bad-uni-esc-7.toml");
}

test "test.invalid.string.basic-byte-escapes" {
    try shouldError("test/invalid/string/basic-byte-escapes.toml");
}

test "test.invalid.string.basic-multiline-out-of-range-unicode-escape-1" {
    try shouldError("test/invalid/string/basic-multiline-out-of-range-unicode-escape-1.toml");
}

test "test.invalid.string.basic-multiline-out-of-range-unicode-escape-2" {
    try shouldError("test/invalid/string/basic-multiline-out-of-range-unicode-escape-2.toml");
}

test "test.invalid.string.basic-multiline-quotes" {
    try shouldError("test/invalid/string/basic-multiline-quotes.toml");
}

test "test.invalid.string.basic-multiline-unknown-escape" {
    try shouldError("test/invalid/string/basic-multiline-unknown-escape.toml");
}

test "test.invalid.string.basic-out-of-range-unicode-escape-1" {
    try shouldError("test/invalid/string/basic-out-of-range-unicode-escape-1.toml");
}

test "test.invalid.string.basic-out-of-range-unicode-escape-2" {
    try shouldError("test/invalid/string/basic-out-of-range-unicode-escape-2.toml");
}

test "test.invalid.string.basic-unknown-escape" {
    try shouldError("test/invalid/string/basic-unknown-escape.toml");
}

test "test.invalid.string.literal-multiline-quotes-1" {
    try shouldError("test/invalid/string/literal-multiline-quotes-1.toml");
}

test "test.invalid.string.literal-multiline-quotes-2" {
    try shouldError("test/invalid/string/literal-multiline-quotes-2.toml");
}

test "test.invalid.string.missing-quotes" {
    try shouldError("test/invalid/string/missing-quotes.toml");
}

test "test.invalid.string.multiline-bad-escape-1" {
    try shouldError("test/invalid/string/multiline-bad-escape-1.toml");
}

test "test.invalid.string.multiline-bad-escape-2" {
    try shouldError("test/invalid/string/multiline-bad-escape-2.toml");
}

test "test.invalid.string.multiline-bad-escape-3" {
    try shouldError("test/invalid/string/multiline-bad-escape-3.toml");
}

test "test.invalid.string.multiline-bad-escape-4" {
    try shouldError("test/invalid/string/multiline-bad-escape-4.toml");
}

test "test.invalid.string.multiline-escape-space-1" {
    try shouldError("test/invalid/string/multiline-escape-space-1.toml");
}

test "test.invalid.string.multiline-escape-space-2" {
    try shouldError("test/invalid/string/multiline-escape-space-2.toml");
}

test "test.invalid.string.multiline-lit-no-close-1" {
    try shouldError("test/invalid/string/multiline-lit-no-close-1.toml");
}

test "test.invalid.string.multiline-lit-no-close-2" {
    try shouldError("test/invalid/string/multiline-lit-no-close-2.toml");
}

test "test.invalid.string.multiline-lit-no-close-3" {
    try shouldError("test/invalid/string/multiline-lit-no-close-3.toml");
}

test "test.invalid.string.multiline-lit-no-close-4" {
    try shouldError("test/invalid/string/multiline-lit-no-close-4.toml");
}

test "test.invalid.string.multiline-no-close-1" {
    try shouldError("test/invalid/string/multiline-no-close-1.toml");
}

test "test.invalid.string.multiline-no-close-2" {
    try shouldError("test/invalid/string/multiline-no-close-2.toml");
}

test "test.invalid.string.multiline-no-close-3" {
    try shouldError("test/invalid/string/multiline-no-close-3.toml");
}

test "test.invalid.string.multiline-no-close-4" {
    try shouldError("test/invalid/string/multiline-no-close-4.toml");
}

test "test.invalid.string.multiline-no-close-5" {
    try shouldError("test/invalid/string/multiline-no-close-5.toml");
}

test "test.invalid.string.multiline-quotes-1" {
    try shouldError("test/invalid/string/multiline-quotes-1.toml");
}

test "test.invalid.string.no-close-1" {
    try shouldError("test/invalid/string/no-close-1.toml");
}

test "test.invalid.string.no-close-2" {
    try shouldError("test/invalid/string/no-close-2.toml");
}

test "test.invalid.string.no-close-3" {
    try shouldError("test/invalid/string/no-close-3.toml");
}

test "test.invalid.string.no-close-4" {
    try shouldError("test/invalid/string/no-close-4.toml");
}

test "test.invalid.string.text-after-string" {
    try shouldError("test/invalid/string/text-after-string.toml");
}

test "test.invalid.string.wrong-close" {
    try shouldError("test/invalid/string/wrong-close.toml");
}

test "test.invalid.table.append-to-array-with-dotted-keys" {
    try shouldError("test/invalid/table/append-to-array-with-dotted-keys.toml");
}

test "test.invalid.table.append-with-dotted-keys-1" {
    try shouldError("test/invalid/table/append-with-dotted-keys-1.toml");
}

test "test.invalid.table.append-with-dotted-keys-2" {
    try shouldError("test/invalid/table/append-with-dotted-keys-2.toml");
}

test "test.invalid.table.array-empty" {
    try shouldError("test/invalid/table/array-empty.toml");
}

test "test.invalid.table.array-implicit" {
    try shouldError("test/invalid/table/array-implicit.toml");
}

test "test.invalid.table.array-no-close-1" {
    try shouldError("test/invalid/table/array-no-close-1.toml");
}

test "test.invalid.table.array-no-close-2" {
    try shouldError("test/invalid/table/array-no-close-2.toml");
}

test "test.invalid.table.duplicate" {
    try shouldError("test/invalid/table/duplicate.toml");
}

test "test.invalid.table.duplicate-key-dotted-array" {
    try shouldError("test/invalid/table/duplicate-key-dotted-array.toml");
}

test "test.invalid.table.duplicate-key-dotted-table" {
    try shouldError("test/invalid/table/duplicate-key-dotted-table.toml");
}

test "test.invalid.table.duplicate-key-dotted-table2" {
    try shouldError("test/invalid/table/duplicate-key-dotted-table2.toml");
}

test "test.invalid.table.duplicate-key-table" {
    try shouldError("test/invalid/table/duplicate-key-table.toml");
}

test "test.invalid.table.duplicate-table-array" {
    try shouldError("test/invalid/table/duplicate-table-array.toml");
}

test "test.invalid.table.duplicate-table-array2" {
    try shouldError("test/invalid/table/duplicate-table-array2.toml");
}

test "test.invalid.table.empty" {
    try shouldError("test/invalid/table/empty.toml");
}

test "test.invalid.table.empty-implicit-table" {
    try shouldError("test/invalid/table/empty-implicit-table.toml");
}

test "test.invalid.table.equals-sign" {
    try shouldError("test/invalid/table/equals-sign.toml");
}

test "test.invalid.table.llbrace" {
    try shouldError("test/invalid/table/llbrace.toml");
}

test "test.invalid.table.nested-brackets-close" {
    try shouldError("test/invalid/table/nested-brackets-close.toml");
}

test "test.invalid.table.nested-brackets-open" {
    try shouldError("test/invalid/table/nested-brackets-open.toml");
}

test "test.invalid.table.no-close-1" {
    try shouldError("test/invalid/table/no-close-1.toml");
}

test "test.invalid.table.no-close-2" {
    try shouldError("test/invalid/table/no-close-2.toml");
}

test "test.invalid.table.no-close-3" {
    try shouldError("test/invalid/table/no-close-3.toml");
}

test "test.invalid.table.no-close-4" {
    try shouldError("test/invalid/table/no-close-4.toml");
}

test "test.invalid.table.no-close-5" {
    try shouldError("test/invalid/table/no-close-5.toml");
}

test "test.invalid.table.overwrite-array-in-parent" {
    try shouldError("test/invalid/table/overwrite-array-in-parent.toml");
}

test "test.invalid.table.overwrite-bool-with-array" {
    try shouldError("test/invalid/table/overwrite-bool-with-array.toml");
}

test "test.invalid.table.overwrite-with-deep-table" {
    try shouldError("test/invalid/table/overwrite-with-deep-table.toml");
}

test "test.invalid.table.redefine-1" {
    try shouldError("test/invalid/table/redefine-1.toml");
}

test "test.invalid.table.redefine-2" {
    try shouldError("test/invalid/table/redefine-2.toml");
}

test "test.invalid.table.redefine-3" {
    try shouldError("test/invalid/table/redefine-3.toml");
}

test "test.invalid.table.rrbrace" {
    try shouldError("test/invalid/table/rrbrace.toml");
}

test "test.invalid.table.super-twice" {
    try shouldError("test/invalid/table/super-twice.toml");
}

test "test.invalid.table.text-after-table" {
    try shouldError("test/invalid/table/text-after-table.toml");
}

test "test.invalid.table.whitespace" {
    try shouldError("test/invalid/table/whitespace.toml");
}

test "test.invalid.table.with-pound" { 
    try shouldError("test/invalid/table/with-pound.toml"); 
}
