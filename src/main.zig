const std = @import("std");
const toml = @import("root.zig");
const utils = @import("utils.zig");

pub fn main() !void {
    const Config: type = toml.Read(@embedFile("test.toml"));
    const config: Config = Config{};

    std.debug.print("{any}\n", .{config.version});
    std.debug.print("{any}\n", .{config.title});
    std.debug.print("{any}\n", .{config.enabled});
    std.debug.print("{any}\n", .{config.money});
    std.debug.print("{any}\n", .{config.poney});
}
