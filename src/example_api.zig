const std = @import("std");
const neurala = @cImport(@cInclude("neurala/api/c/inspectorlib.h"));

pub fn main() void {
    const model_path = "D:\\Back_v2.zip";
    var brain: ?*neurala.neurala_brain = null;
    const status = neurala.neurala_create_brain_from_path(model_path.ptr, &brain);
    defer neurala.neurala_free_brain(brain);

    if (status == neurala.NEURALA_ERRC_OK) {
        std.debug.print("Loading was OK", .{});
    } else {
        std.debug.print("Got error: {d} ", .{status});
    }
}
