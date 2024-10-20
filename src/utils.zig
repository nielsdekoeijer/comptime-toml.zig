const std = @import("std");

pub fn EqualsPredicate(comptime T: type, comptime A: T) type {
    return struct {
        pub fn function(val: T) bool {
            return val == A;
        }
    };
}

pub fn comptimeLog(comptime message: []const u8, comptime format: anytype) void {
    const loggingEnabled = false;
    if (loggingEnabled)
        @compileLog(std.fmt.comptimePrint(message, format));
}

pub fn comptimeNullTerminate(comptime arr: []const u8) [:0]const u8 {
    var out: [arr.len + 1]u8 = undefined;
    for (0..arr.len) |i| { out[i] = arr[i]; }
    out[arr.len] = std.ascii.control_code.nul;
    return @ptrCast(&out);
}

pub fn comptimeFind(comptime T: type, curr: []const T, predicate: fn (val: T) bool) ?usize {
    comptime {
        for (0..curr.len) |i| {
            if (predicate(curr[i])) {
                return i;
            }
        }

        return null;
    }
}

pub fn comptimeMatch(comptime T: type, curr: []const T, tomatch: []const T) bool {
    comptime {
        if (curr.len < tomatch.len) {
            return false;
        }

        for (0..tomatch.len) |i| {
            if (curr[i] != tomatch[i]) {
                return false;
            }
        }

        return true;
    }
}
