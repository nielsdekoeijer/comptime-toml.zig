const std = @import("std");

const MAX_TOK: usize = 4096;


const SymbolType = enum {
    Whitespace,
    NewLine,
    Comment,
    Equals,
    Quote,
    Dot,
    Dash, 
    Alphanumeric,
    SquareBeg,
    SquareEnd,
    CurlyBeg,
    CurlyEnd,
    Comma,
    Remainder,
};

const TokenType = enum {
    Alphanumeric,
    Comment,
    Equals,
    Dot,
    Comma,
    String,
    Dash, 
    SquareBeg,
    SquareEnd,
    CurlyBeg,
    CurlyEnd,
};

const Token = struct {
    type: TokenType,
    value: []const u8,
};

pub fn read(comptime file: []const u8) void {
    comptime {
        _ = lex(file);
    }
}

fn comptimeLog(comptime message: []const u8, comptime format: anytype) void {
    @compileLog(std.fmt.comptimePrint(message, format));
}

fn getSymbolType(comptime symbol: u8) SymbolType {
    if (symbol == std.ascii.control_code.lf) 
        return SymbolType.NewLine;

    if (symbol == '#') 
        return SymbolType.Comment;

    if (symbol == '=') 
        return SymbolType.Equals;

    if (symbol == '[') 
        return SymbolType.SquareBeg;

    if (symbol == ']') 
        return SymbolType.SquareEnd;

    if (symbol == '{') 
        return SymbolType.CurlyBeg;

    if (symbol == '}') 
        return SymbolType.CurlyEnd;

    if (symbol == '.') 
        return SymbolType.Dot;

    if (symbol == '.') 
        return SymbolType.Comma;

    if (symbol == '"') 
        return SymbolType.Quote;

    if (symbol == '-') 
        return SymbolType.Dash;

    if (std.ascii.isAlphanumeric(symbol)) 
        return SymbolType.Alphanumeric;

    if (std.ascii.isWhitespace(symbol))
        return SymbolType.Whitespace;

    return SymbolType.Remainder;
}

fn doParseComment(comptime file: []const u8, index: *usize) Token {
    var localIndex: usize = index.*;
    while (localIndex < file.len) {
        const symbol = getSymbolType(file[localIndex]);
        if (symbol == SymbolType.NewLine) {
            const comment = file[index.*..localIndex];
            index.* = localIndex;
            return Token {
                .type = TokenType.Comment,
                .value = comment,
            };
        }

        localIndex += 1;
    }

    @compileError("unreachable, invalid toml?");
}

fn doParseKey(comptime file: []const u8, index: *usize) Token {
    var localIndex: usize = index.*;
    while (localIndex < file.len) {
        const symbol = getSymbolType(file[localIndex]);
        if (symbol != SymbolType.Alphanumeric) {
            const item = file[index.*..localIndex];
            index.* = localIndex;
            return Token {
                .type = TokenType.Alphanumeric,
                .value = item,
            };
        }

        localIndex += 1;
    }

    @compileError("unreachable, invalid toml?");
}

fn doParseEquals(comptime file: []const u8, index: *usize) Token {
    const symbol = getSymbolType(file[index.*]);
    if (symbol == SymbolType.Equals) {
        return Token {
            .type = TokenType.Equals,
            .value = "=",
        };
    }

    @compileError("unreachable, invalid toml?");
}

fn doParseDot(comptime file: []const u8, index: *usize) Token {
    const symbol = getSymbolType(file[index.*]);
    if (symbol == SymbolType.Dot) {
        return Token {
            .type = TokenType.Dot,
            .value = ".",
        };
    }

    @compileError("unreachable, invalid toml?");
}

fn doParseString(comptime file: []const u8, index: *usize) Token {
    var localIndex: usize = index.*;
    var stringBegOffset = 0;
    var stringEndOffset = 0;

    while (localIndex < file.len) {
        const symbol = getSymbolType(file[localIndex]);
        if (symbol == SymbolType.Quote) {
            stringBegOffset += 1;
        } else {
            break;
        }

        localIndex += 1;
    }

    if(stringBegOffset != 1 and stringBegOffset != 3) 
        @compileError("unreachable, neither single or multiline string?");

    while (localIndex < file.len) {
        const symbol = getSymbolType(file[localIndex]);
        if (symbol == SymbolType.Quote) {
            break;
        }

        localIndex += 1;
    }


    while (localIndex < file.len) {
        const symbol = getSymbolType(file[localIndex]);
        if (symbol == SymbolType.Quote) {
            stringEndOffset += 1;
        } else {
            break;
        }

        localIndex += 1;
    }

    if(stringEndOffset != 1 and stringEndOffset != 3) 
        @compileError("unreachable, neither single or multiline string?");

    const token = Token { 
        .type = TokenType.String,
        .value = file[index.* + stringBegOffset..localIndex - stringEndOffset],
    };

    index.* = localIndex;
    return token;
}


fn lex(comptime file: []const u8) []const Token {
    comptime {
        var tokens: [MAX_TOK]Token = undefined;
        var tokensIndex: usize = 0;

        var index: usize = 0;

        comptimeLog("parsing file with length: {}", .{file.len});
        while (index < file.len) {
            const symbol = getSymbolType(file[index]);

            switch(symbol) {
                SymbolType.Comment => {
                    const skip = doParseComment(file, &index);
                    comptimeLog("skipping comment with '{s}'", .{skip.value});
                    tokensIndex += 1;
                },

                SymbolType.Quote => {
                    tokens[tokensIndex] = doParseString(file, &index);
                    comptimeLog("added string with '{s}' at {}", .{tokens[tokensIndex].value, tokensIndex});
                    tokensIndex += 1;
                },

                SymbolType.Alphanumeric => {
                    tokens[tokensIndex] = doParseKey(file, &index);
                    comptimeLog("added item with '{s}' at {}", .{tokens[tokensIndex].value, tokensIndex});
                    tokensIndex += 1;
                },

                SymbolType.Equals => {
                    tokens[tokensIndex] = doParseEquals(file, &index);
                    comptimeLog("added equals with '{s}' at {}", .{tokens[tokensIndex].value, tokensIndex});
                    tokensIndex += 1;
                },

                SymbolType.Dot => {
                    tokens[tokensIndex] = doParseDot(file, &index);
                    comptimeLog("added equals with '{s}' at {}", .{tokens[tokensIndex].value, tokensIndex});
                    tokensIndex += 1;
                },

                SymbolType.Remainder => {
                    comptimeLog("skipping symbol '{}' from '{c}' at index '{}", .{symbol, file[index], index});
                    @compileError("invalid");
                },

                else => {
                },
            }

            index += 1;
        }

        return tokens[0..tokensIndex];
    }
}
