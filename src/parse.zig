const std = @import("std");
const utils = @import("utils.zig");
const lex = @import("lex.zig");

fn isValidKey(comptime tok: lex.Grammer) bool {
    return tok != lex.Grammer.QuotedString and tok != lex.Grammer.UnquotedString;
}

fn tryParseBoolean(comptime tokens: []const lex.Token) ?bool {
    if (tokens[0].content) |value| {
        if (utils.comptimeMatch(u8, value, "false")) {
            return false;
        }

        if (utils.comptimeMatch(u8, value, "true")) {
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

        utils.comptimeLog("{s}", .{value});
        @setEvalBranchQuota(10000);
        return std.fmt.parseInt(i32, value, 10) catch {
            @compileError("failed to parse int");
        };
    }


    return null;
}

fn parseKeyValue(comptime tokens: []const lex.Token) std.builtin.Type.StructField {
    // grab name
    var name: [:0]const u8 = undefined;

    // ensure correct token type
    if(isValidKey(tokens[0].token)) {
        @compileError("expected QuotedString or UnquotedString token");
    } 

    // check if content present
    if(tokens[0].content) |val| {
        name = utils.comptimeNullTerminate(val);
    } else {
        @compileError("expected content to be present");
    }

    // ensure separator
    if(tokens[1].token != lex.Grammer.Equals) {
        @compileError("expected Equals token");
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

pub fn Parse(comptime tokens: []const lex.Token) type {
    comptime {
        var i: usize = 0;
        var j: usize = 0;
        var fields: [tokens.len]std.builtin.Type.StructField = undefined;

        while (i < tokens.len) {
            const token = tokens[i];

            switch (token.token) {
                lex.Grammer.QuotedString, lex.Grammer.UnquotedString => {
                    fields[j] = parseKeyValue(tokens[i..]);
                    j += 1;

                    const offset = utils.comptimeFind(
                        lex.Token,
                        tokens[i..],
                        TokensEqualsPredicate(lex.Grammer.NewLine).function,
                    );

                    if (offset) |val| {
                        i += val;
                    } else {
                        @compileError("expected NewLine token following key-value pair"); 
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
