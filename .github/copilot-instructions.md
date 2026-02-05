*** Follow the instructions in this file when writing code for the project. ***

This is an API framework using Karate framework through karate-npm.

Config file (karate-config.js), test executor (test.js) and utilities (in /utils folder) are written in JavaScript (with ES6+ syntax, meaning using const, let and all that stuff that came with ES6), following the AirBnb coding style guide: https://github.com/airbnb/javascript.

Anything asked about API tests should be answered with respect to the Karate framework.

Each Karate test should use separator lines before and after each descriptive block in the tests. The descriptive blocks are:
- Feature
- Background
- Scenario
- Scenario Outline

Strings in Karate tests should be enclosed in double quotes.

Karate feature files are written in Gherkin syntax and are located in the /tests folder, with some utilities in /utils. The tests are split by API in different folders and within those folders, further split by endpoint in individual folders.

Each proper API request in a Scenario should do the matching in the following order:
1. Check for HTTP status (`status`)
1. Check for Content-Type header (`Content-Type`) if checks on the response body will be done
1. Check the schema of the response when there is anything besides an empty response body
1. Check specific fields in the response body as needed

Indentation is done with 2 spaces throughout (both in JavaScript and Karate files).

Each Scenario Outline must have a <parameter> in the title to differentiate each scenario in the test report.

String concatenation in either JavaScript or Karate should be done using template literals (backticks).
