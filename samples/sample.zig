//! Zig sample: struct, error union, comptime, allocator
const std = @import("std");
const Allocator = std.mem.Allocator;

const max_items: usize = 100;

const Color = enum {
    red,
    green,
    blue,

    pub fn isWarm(self: Color) bool {
        return self == .red;
    }
};

const ParseError = error{ Empty, InvalidNumber };

/// A simple stack with a generic type.
fn Stack(comptime T: type) type {
    return struct {
        const Self = @This();

        items: std.ArrayList(T),

        pub fn init(allocator: Allocator) Self {
            return .{ .items = std.ArrayList(T).init(allocator) };
        }

        pub fn deinit(self: *Self) void {
            self.items.deinit();
        }

        pub fn push(self: *Self, value: T) !void {
            try self.items.append(value);
        }

        pub fn pop(self: *Self) ?T {
            return self.items.popOrNull();
        }
    };
}

fn parseNumber(text: []const u8) ParseError!i32 {
    if (text.len == 0) return error.Empty;
    return std.fmt.parseInt(i32, text, 10) catch error.InvalidNumber;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var stack = Stack(i32).init(allocator);
    defer stack.deinit();

    for (0..5) |i| {
        try stack.push(@intCast(i * 2));
    }

    const n = parseNumber("42") catch |err| {
        std.debug.print("failed: {}\n", .{err});
        return;
    };
    std.debug.print("Hello, {s}! n = {d}, hex = 0x{x}\n", .{ "world", n, 255 });
}
