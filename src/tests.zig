const std = @import("std");
const testing = std.testing;
const neurala = @cImport(@cInclude("neurala/api/c/inspectorlib.h"));
const tests = @cImport(@cInclude("test.h"));

test "Allocate-free brain" {
    try std.testing.expect(tests.test_load_free_brain() == 0);
}
