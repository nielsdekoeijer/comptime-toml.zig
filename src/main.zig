const std = @import("std");
const toml = @import("root.zig");

pub fn main() !void {
    toml.read(@embedFile("test.toml"));
}
