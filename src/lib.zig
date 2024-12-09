const c = @cImport({
    @cInclude("node_api.h");
});

const std = @import("std");

fn nativeFunction(env: c.napi_env, info: c.napi_callback_info) callconv(.C) c.napi_value {
    // Generic response
    var global: c.napi_value = undefined;
    var status: c.napi_status = c.napi_get_global(env, &global);
    var result: c.napi_value = undefined;

    // Get function parameters
    var argc: usize = 3; // equivalent type size_t More info https://ziglang.org/documentation/master/#Primitive-Types
    var argv: [3]c.napi_value = undefined;
    // [out] thisArg: Receives the JavaScript this argument for the call. thisArg can optionally be ignored by passing NULL.
    // [out] data: Receives the data pointer for the callback. data can optionally be ignored by passing NULL.
    var thisArg: c.napi_value = undefined;
    // var data: *anyopaque = undefined;

    // https://nodejs.org/api/n-api.html#napi_get_cb_info
    status = c.napi_get_cb_info(env, info, &argc, &argv, &thisArg, null);

    var value_type: c.napi_valuetype = undefined;
    status = c.napi_typeof(env, argv[0], &value_type);

    // Check function type
    std.debug.print("  js_callback = {?}\n", .{argv[0]});
    // https://nodejs.org/api/n-api.html#napi_valuetype
    std.debug.print("  value_type type index = {any}\n\n", .{value_type});
    std.debug.print("  value_type is a function {any}\n\n", .{value_type == c.napi_function});

    // Call function https://nodejs.org/api/n-api.html#napi_call_function
    // Example https://github.com/nodejs/node-addon-api/issues/675
    var hello: c.napi_value = undefined;
    var call_text: c.napi_value = undefined;
    const call_argc: usize = 2;
    status = c.napi_create_string_utf8(env, "hello", c.NAPI_AUTO_LENGTH, &hello);
    status = c.napi_create_string_utf8(env, " world!!! :-)", c.NAPI_AUTO_LENGTH, &call_text);

    var call_argv: [2]c.napi_value = undefined;
    call_argv[0] = hello;
    call_argv[1] = call_text;

    status = c.napi_call_function(env, global, argv[0], call_argc, &call_argv, &result);
    // std.debug.print(" call status {?}\n", .{status});

    // Check for possible errors calling function
    if (status == c.napi_invalid_arg) {
        // const error_struct: *c.napi_extended_error_info = undefined;
        var error_info: [*c]const c.napi_extended_error_info = undefined;

        // https://github.com/nodejs/node/blob/adcbfcec60a19dda0038890923b312395ef326f5/test/js-native-api/test_general/test_general.c#L80
        status = c.napi_get_last_error_info(env, &error_info);

        // Pass error to Node
        status = c.napi_throw_error(env, null, error_info.*.error_message);
        std.debug.print("Error_struct {any}\n\n", .{@TypeOf(error_info.*.error_message.*)});
    }

    return hello;
}

export fn napi_register_module_v1(env: c.napi_env, exports: c.napi_value) c.napi_value {
    var function: c.napi_value = undefined;
    if (c.napi_create_function(env, null, 0, nativeFunction, null, &function) != c.napi_ok) {
        _ = c.napi_throw_error(env, null, "Failed to create function");
        return null;
    }

    if (c.napi_set_named_property(env, exports, "foo", function) != c.napi_ok) {
        _ = c.napi_throw_error(env, null, "Failed to add function to exports");
        return null;
    }

    return exports;
}
