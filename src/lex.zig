const std = @import("std");
const utils = @import("utils.zig");

pub const Token = struct { token: Grammer, content: ?[]const u8 };

pub const Grammer = enum {
    LBracket,
    RBracket,
    LBrace,
    RBrace,
    DLBracket,
    DRBracket,
    Equals,
    Dot,
    Comma,
    UnquotedString,
    QuotedString,
    Number,
    Boolean,
    DateTime,
    NewLine,
    WhiteSpace,
    Remainder,
};

pub fn lex(comptime input: []const u8) []const Token {
    comptime {
        var i: usize = 0;
        var j: usize = 0;
        var tokens: [input.len]Token = undefined;

        while (i < input.len) {
            const char: u8 = input[i];

            if (isUnquotedString(char)) {
                var k = i;
                while (isUnquotedString(input[k]) and k < input.len) {
                    k += 1;
                }

                tokens[j] = Token{
                    .token = Grammer.UnquotedString,
                    .content = input[i..k],
                };

                j += 1;
                i = k;

                continue;
            }

            if (isQuote(char)) {
                // NOTE(unsafe)
                const isMultiLine = utils.comptimeMatch(u8, input[i..], &[3]u8{ char, char, char });
                if (isMultiLine) {
                    i += 3;
                } else {
                    i += 1;
                }

                var k = i;
                while (input[k] != char) {
                    k += 1;
                }

                tokens[j] = Token{
                    .token = Grammer.QuotedString,
                    .content = input[i..k],
                };

                j += 1;
                i = k;

                if (isMultiLine) {
                    i += 3;
                } else {
                    i += 1;
                }

                continue;
            }

            switch (char) {
                '#' => {
                    const index = utils.comptimeFind(
                        u8,
                        input[i..],
                        utils.EqualsPredicate(u8, '\n').function,
                    );
                    if (index) |idx| {
                        i += idx;
                    } else {
                        @compileError("unterminated comment");
                    }

                    tokens[j] = Token{
                        .token = Grammer.NewLine,
                        .content = null,
                    };
                    j += 1;
                },
                ' ', '\t' => {
                    // Skip whitespace
                },
                '[' => {
                    // If next token is another `]`, parse double bracket
                    if (utils.comptimeMatch(u8, input[i..], "[[")) {
                        tokens[j] = Token{
                            .token = Grammer.DLBracket,
                            .content = null,
                        };
                        i += 1;
                    } else {
                        tokens[j] = Token{
                            .token = Grammer.LBracket,
                            .content = null,
                        };
                    }

                    j += 1;
                },
                ']' => {
                    // If next token is another `]`, parse double bracket
                    if (utils.comptimeMatch(u8, input[i..], "]]")) {
                        tokens[j] = Token{
                            .token = Grammer.DRBracket,
                            .content = null,
                        };
                        i += 1;
                    } else {
                        tokens[j] = Token{
                            .token = Grammer.RBracket,
                            .content = null,
                        };
                    }
                    j += 1;
                },
                '{' => {
                    tokens[j] = Token{
                        .token = Grammer.LBrace,
                        .content = null,
                    };
                    j += 1;
                },
                '}' => {
                    tokens[j] = Token{
                        .token = Grammer.RBrace,
                        .content = null,
                    };
                    j += 1;
                },
                '=' => {
                    tokens[j] = Token{
                        .token = Grammer.Equals,
                        .content = null,
                    };
                    j += 1;
                },
                '.' => {
                    tokens[j] = Token{
                        .token = Grammer.Dot,
                        .content = null,
                    };
                    j += 1;
                },
                ',' => {
                    tokens[j] = Token{
                        .token = Grammer.Comma,
                        .content = null,
                    };
                    j += 1;
                },
                '\n' => {
                    tokens[j] = Token{
                        .token = Grammer.NewLine,
                        .content = null,
                    };
                    j += 1;
                },
                else => {
                    tokens[j] = Token{
                        .token = Grammer.Remainder,
                        .content = input[i .. i + 1],
                    };
                    j += 1;
                },
            }

            i += 1;
        }

        return tokens[0..j];
    }
}

fn isUnquotedString(comptime c: u8) bool {
    return (std.ascii.isAlphanumeric(c) or c == '_' or c == '-');
}

fn isLiteralQuote(comptime c: u8) bool {
    return c == '\'';
}

fn isBasicQuote(comptime c: u8) bool {
    return c == '"';
}

fn isQuote(comptime c: u8) bool {
    return isBasicQuote(c) or isLiteralQuote(c);
}
