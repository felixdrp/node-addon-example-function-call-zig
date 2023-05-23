const example = require('./dist/lib.node');
console.log(example.foo((text1, text2)=>{console.log(text1 + text2)}));
