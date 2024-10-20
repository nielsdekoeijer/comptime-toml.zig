const std = @import("std");

const utils = @import("utils.zig");
const parse = @import("parse.zig");
const lex = @import("lex.zig");

pub fn Read(comptime file: []const u8) type {
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

test {
    // TODO This isnt gonna scale:
    // TODO [ ] write some code that can read the json 
    // TODO [ ] parse the json to something that can autogen tests
    const inp = Read(@embedFile("tests/valid/bool/bool.toml")){};
    try std.testing.expect(inp.f == false);
    try std.testing.expect(inp.t == true);
}
