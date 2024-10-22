const std = @import("std");
const toml = @import("root.zig");
const utils = @import("utils.zig");

pub fn main() !void {
    toml.run();

    const Config: type = toml.Read(@embedFile("test.toml"));
    const config: Config = Config{};

    const gpa = std.heap.page_allocator;
    var arena = std.heap.ArenaAllocator.init(gpa);
    var out = std.ArrayList(u8).init(arena.allocator());
    std.json.stringify(config, .{}, out.writer()) catch |err| {
        std.debug.print("{any}", .{err});
    };

    std.debug.print("{s}\n", .{out.items});
}
