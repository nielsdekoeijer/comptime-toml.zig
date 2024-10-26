const std = @import("std");
const utils = @import("utils.zig");
const lex = @import("lex.zig");
const TOMLError = @import("error.zig").TOMLError;

fn isValidKey(comptime tok: lex.Grammer) bool {
    return tok != lex.Grammer.QuotedString and tok != lex.Grammer.UnquotedString;
}

fn tryParseBoolean(comptime tokens: []const lex.Token) ?bool {
    if (tokens[0].content) |value| {
        if (utils.comptimeMatch(u8, value, "false")) {
            utils.comptimeLog("parsing as bool 'false'", .{});
            return false;
        }

        if (utils.comptimeMatch(u8, value, "true")) {
            utils.comptimeLog("parsing as bool 'true'", .{});
            return true;
        }
    }

    return null;
}

fn tryParseFloat(comptime tokens: []const lex.Token) ?f32 {
    _ = tokens;
    return null;
}

fn isValidInteger(comptime content: []const u8) bool {
    for (content) |item| {
        if (!std.ascii.isDigit(item)) {
            return false;
        }
    }

    return true;
}

fn tryParseInteger(comptime tokens: []const lex.Token) ?i32 {
    if (tokens[0].content) |value| {
        if (!isValidInteger(value)) {
            return null;
        }

        @setEvalBranchQuota(10000);
        return std.fmt.parseInt(i32, value, 10) catch {
            return null;
        };
    }

    return null;
}

fn parseKeyValue(comptime tokens: []const lex.Token) TOMLError!std.builtin.Type.StructField {
    // grab name
    var name: [:0]const u8 = undefined;

    // ensure correct token type
    if (isValidKey(tokens[0].token)) {
        return TOMLError.UnexpectedToken;
    }

    // check if content present
    if (tokens[0].content) |val| {
        name = utils.comptimeNullTerminate(val);
    } else {
        return TOMLError.UnexpectedToken;
    }

    // ensure separator
    if (tokens[1].token != lex.Grammer.Equals) {
        return TOMLError.UnexpectedToken;
    }

    // parse type
    if (tryParseBoolean(tokens[2..])) |value| {
        return std.builtin.Type.StructField{
            .name = name,
            .type = bool,
            .default_value = &value,
            .is_comptime = true,
            .alignment = 0,
        };
    }

    if (tryParseFloat(tokens[2..])) |value| {
        return std.builtin.Type.StructField{
            .name = name,
            .type = f32,
            .default_value = value,
            .is_comptime = true,
            .alignment = 0,
        };
    }

    if (tryParseInteger(tokens[2..])) |value| {
        return std.builtin.Type.StructField{
            .name = name,
            .type = i32,
            .default_value = &value,
            .is_comptime = true,
            .alignment = 0,
        };
    }

    return std.builtin.Type.StructField{
        .name = name,
        .type = bool,
        .default_value = &false,
        .is_comptime = true,
        .alignment = 0,
    };
}

fn TokensEqualsPredicate(comptime A: lex.Grammer) type {
    return struct {
        fn function(val: lex.Token) bool {
            return val.token == A;
        }
    };
}

pub fn parse(comptime tokens: []const lex.Token) TOMLError!type {
    comptime {
        var i: usize = 0;
        var j: usize = 0;
        var fields: [tokens.len]std.builtin.Type.StructField = undefined;

        while (i < tokens.len) {
            const token = tokens[i];

            switch (token.token) {
                lex.Grammer.QuotedString, lex.Grammer.UnquotedString => {
                    const candidate = try parseKeyValue(tokens[i..]);

                    for (0..j) |k| {
                        if (std.mem.eql(u8, fields[k].name, candidate.name)) {
                            return TOMLError.UnexpectedToken;
                        }
                    }

                    fields[j] = candidate;
                    j += 1;

                    const offset = utils.comptimeFind(
                        lex.Token,
                        tokens[i..],
                        TokensEqualsPredicate(lex.Grammer.NewLine).function,
                    );

                    if (offset) |val| {
                        i += val;
                    } else {
                        return TOMLError.UnexpectedToken;
                    }
                },
                else => {},
            }

            i += 1;
        }

        return @Type(.{
            .@"struct" = .{
                .layout = .auto,
                .fields = fields[0..j],
                .decls = &[_]std.builtin.Type.Declaration{},
                .is_tuple = false,
            },
        });
    }
}
