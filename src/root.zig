const std = @import("std");

const utils = @import("utils.zig");
const parse = @import("parse.zig");
const lex = @import("lex.zig");

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

pub fn TOMLFixture(comptime name: anytype) type {
    comptime {
        return struct {
            test "fixture" {
                // try std.testing.expect(std.mem.eql(u8, name, "needle"));
                const TOML: type = Read(@embedFile("tests/" ++ name ++ ".toml"));
                const toml = TOML {};

                const json = @embedFile("tests/" ++ name ++ ".json");
                const gpa = std.heap.page_allocator;
                var arena = std.heap.ArenaAllocator.init(gpa);
                var out = std.ArrayList(u8).init(arena.allocator());
                std.json.stringify(toml, .{}, out.writer()) catch |err| {
                    std.debug.print("{any}", .{err});
                };

                std.debug.print("======================\n", .{});
                std.debug.print("Got TOML:\n{s}\n", .{@embedFile("tests/" ++ name ++ ".toml")});
                std.debug.print("Got JSON:\n{s}\n", .{json});
                std.debug.print("Parsed:\n{s}\n", .{out.items});
                std.debug.print("\n", .{});
                // try std.testing.expect(std.mem.eql(u8, json, toml));
            }
        };
    }
}

comptime {
    const files = @import("tests/names.zig").files;
    for (files) |file| {
        _ = std.testing.refAllDecls(TOMLFixture(file));
    }
}
