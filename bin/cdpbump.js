#!/usr/bin/env node

// This script updates dependency versions for multiple package.json files.

var fs = require("fs");
var exec = require("child_process").exec;

function usage() {
    console.error("Usage: cdpbump.js [dependency name] [version]");
    console.error("Script must be run from the 'cdp' root directory.");
    process.exit(-1);
}

function updatePackageJSON(fileName, dependencyName, version) {
    console.log("Updating %s dependency '%s' to version '%s'", fileName, dependencyName, version);
    var packageJSONText = fs.readFileSync(fileName);
    var packageJSONObj = JSON.parse(packageJSONText);
    packageJSONObj.dependencies[dependencyName] = version;
    fs.writeFileSync(fileName, JSON.stringify(packageJSONObj, null, 2));
}

// 0 is "node"
// 1 is script name
var dependencyName = process.argv[2];
var version = process.argv[3];

if (!dependencyName || !version) {
    usage();
}

var dirsToUpdate = [
    "modules/webApp/desktop",
    "modules/webApp/mobile",
    "modules/webApp/test-core"
];

dirsToUpdate.forEach(function(dirName) {
    var fileName = dirName + "/package.json";

    updatePackageJSON(fileName, dependencyName, version);

    console.log("Updating package from npm...");

    // Ignore failures for now
    exec("cd " + dirName + " && npm update " + dependencyName);
});
