const example = require('./dist/lib.node');
const callThisFunction = (text1, text2)=> console.log(text1 + text2);
// Call callThisFunction and returns text1
const result = example.foo(callThisFunction);
console.log(result);
