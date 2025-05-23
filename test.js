#! /usr/bin/env node
const karate = require("@karatelabs/karate");
// Options:
// -T=10: Set the number of threads to 10
// -C: Clean (delete) the target directory before running - this will fail on first run since target directory doesn't exist
// -f junit:xml: Specify the report output format as JUnit XML (still does Karate HTML report as well)
// karate.exec("-T=10 -C -f junit:xml");
karate.exec("-T=10 -f junit:xml");
