#! /usr/bin/env node

var howMany = 10;
var codeLength = 6;
var letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
var numbers = "0123456789";

for (var j = 0; j < howMany; ++j) {
    var chars = [];

    for (var i = 0; i < codeLength; ++i) {
        var source = numbers;
        if (i === 1 || i === 3) {
            source = letters;
        }
        var index = Math.floor(Math.random() * source.length);
        var c = source.charAt(index);
        chars.push(c);
    }

    var str = chars.join("");

    console.log(str);
}
