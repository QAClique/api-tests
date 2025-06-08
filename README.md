# test-pyramid-api

## Getting Started

This is a simplified API framework based on [Karate](https://github.com/karatelabs/karate). To run the test you need to install [Node.js](https://nodejs.org/en). Use the latest LTS version, but anything newer will work as well.

Clone the repository on your computer and in the new repo folder, do `npm install`

### Executing the tests

From the command-line do the following:

```bash
npm test karate/funds.aum.tsx.feature
```

You can also execute tests directly in Visual Studio Code. Install the [Karate Runner](https://marketplace.visualstudio.com/items?itemName=kirkslota.karate-runner) to do so and you'll see a `Karate Run` button appear in the `.feature` test files above the `Feature` and `Scenario` keywords.

Test reports are located in `target` folder, look for `karate-summary.html` to see the full results.
