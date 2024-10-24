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
            const toml = Read(@embedFile("tests/" ++ name ++ ".toml")) {};
            const json = @embedFile("tests/" ++ name ++ ".json");

            fn asObjectMap(value: std.json.Value) std.json.ParseError(std.json.Scanner)!std.json.ObjectMap {
                switch(value) {
                    std.json.Value.object => |inner| {
                        return inner;
                    },
                    else => {
                        return error.UnexpectedToken;
                    }
                }
            }

            fn run() void {
                // parse object map from json
                const parsed = std.json.parseFromSlice(std.json.Value, std.testing.allocator, json, .{}) catch unreachable;
                const map: std.json.ObjectMap = asObjectMap(parsed.value) catch unreachable;
                parsed.deinit();

                _ = map;
            }

            test "fixture" {
                run();

                // const parsed = try std.json.parseFromSlice(std.json.Value, std.testing.allocator, json, .{});
                // defer parsed.deinit();
                // std.debug.print("======================\n", .{});
                // std.debug.print("Got TOML:\n{s}\n", .{@embedFile("tests/" ++ name ++ ".toml")});
                // std.debug.print("Got JSON:\n{s}\n", .{json});
                // switch (parsed.value) {
                //     std.json.Value.object => |inner| {
                //         for (inner.keys()) |key| {
                //             std.debug.print("{s}\n", .{key});
                //             const entry = inner.get(key).?;
                //             switch (entry) {
                //                 std.json.Value.object => |object| {
                //                     const val = object.get("value").?.string;
                //                     // case bool
                //                     if (std.mem.eql(u8, object.get("type").?.string, "bool")) {
                //                         if (std.mem.eql(u8, val, "true")) {
                //                             try std.testing.expect(@field(toml, key) == true);
                //                         }
                //                         else if (std.mem.eql(u8, val, "false")) {
                //                             try std.testing.expect(@field(toml, key) == false);
                //                         }
                //                         else {
                //                             unreachable;
                //                         }
                //                     }
                //                 },
                //                 else => {
                //                     unreachable;
                //                 },
                //             }
                //         }
                //     },
                //     else => {
                //         unreachable;
                //     },
                // }
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
