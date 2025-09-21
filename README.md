# api-tests

## Getting Started

This is a simplified set of Front End tests used in the "Stop Testing End to End" Presentation. It requires the demo Web App from <https://github.com/QAClique/demo-webapp>. It is based on [Karate](https://github.com/karatelabs/karate). To run the test you need to install [Node.js](https://nodejs.org/en). Use the latest LTS version, but anything newer will work as well.

Clone the repository on your computer and in the new repo folder, do `npm install`

### Executing the tests

From the command-line do the following:

```bash
npm test <path and name of test file goes here - like tests/fieldsRows.feature>
```

To run all tests, simply use `npm test`.

You can also execute tests directly in Visual Studio Code. Install the [Karate Runner](https://marketplace.visualstudio.com/items?itemName=kirkslota.karate-runner) extension to do so and you'll see a `Karate Run` button appear in the `.feature` test files above the `Feature` and `Scenario` keywords.

Test reports are located in `target` folder, look for `karate-summary.html` to see the full results.

### Linter

There is a configuration file for ESLint for all JavaScript code. Enable ESLint in your editor/IDE and you should see problems in real-time.

For Karate feature files, we use [GPLint](https://github.com/gplint/gplint), which has to be run manually like so:

```bash
npm run lint
```

Head up to the GPLint site to see details about the rules and how to fix violations.
