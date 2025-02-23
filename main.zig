const std = @import("std");
const c = @cImport({
    @cInclude("quicklz.h");
});

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    // Allocate 100400 bytes
    const buffer = try allocator.alloc(u8, 100400);
    defer allocator.free(buffer);

    // Initialize the buffer (optional)
    for (buffer) |*byte| {
        byte.* = 0; // Or some other initialization
    }

    // Call the C function.
    _ = c.qlz_size_compressed(buffer.ptr);

    std.debug.print("C function called successfully\n", .{});
}
