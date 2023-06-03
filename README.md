# node-addon-example-function-call-zig <img alt="Zig Logo" src="https://raw.githubusercontent.com/ziglang/logo/master/zig-logo-dark.svg" width="200">

Example of addon using [Zig lang](https://ziglang.org/). This example will call a JavaScript function from a native add-on. This is the primary mechanism of calling back from the add-on's native code into JavaScript.<br>
For the special case of calling into JavaScript after an async operation, see [napi_make_callback](https://nodejs.org/api/n-api.html#napi_make_callback) [[github]](https://github.com/nodejs/node/blob/main/doc/api/n-api.md?plain=1#LL5610C6-L5610C24).

### Similar example in C

 - [node-addon-examples/blob/main/3_callbacks](https://github.com/nodejs/node-addon-examples/blob/main/3_callbacks/napi/addon.c)

### Other examples by @felixdrp

 - [node-addon-example-buffer-zig](https://github.com/felixdrp/node-addon-example-buffer-zig)

## Node.js Native Module written in Zig

This project is an example Hello World for making a Node.js native module in Zig. To install Zig:

- [https://ziglang.org/download/](https://ziglang.org/download/)
- [https://snapcraft.io/zig](https://snapcraft.io/zig)

The entry point is `src/lib.zig`.

Run this project like this:
```bash
# 1. Git clone it
git clone https://github.com/felixdrp/node-addon-example-function-call-zig.git

# 2. Download Node.js header files
npm run postinstall

# 3. Compile the Zig module and produce `dist/lib.node`
npm run build

# 4. Run example. It will call the `foo()` function from Zig module.
npm run exec

# Bonus: Debug mode (build dev) 🐛
npm run bdev
```

## License and acknowledgements

Many thanks to https://staltz.com for his example.
[1]: https://staltz.com
[2]: https://github.com/staltz/zig-nodejs-example

## Learning Zig

 - [zig doc](https://ziglang.org/documentation/master/)
 - [zig api ref](https://ziglang.org/documentation/master/std/#A;std)
 - [ziglearn](https://ziglearn.org)
 - [ikrima.dev zig-crash-course](https://ikrima.dev/dev-notes/zig/zig-crash-course/)
 - [zig.news](https://zig.news/)

## Debug Zig

- [Debug node addon by Atul](https://medium.com/@a7ul/debugging-nodejs-c-addons-using-vs-code-27e9940fc3ad)
- [Debug zig by Chris Watson](https://dev.to/watzon/debugging-zig-with-vs-code-44ca)
