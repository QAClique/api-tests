function fn() {
  let env = karate.env; // get system property "karate.env"
  karate.log("karate.env system property was:", env);
  if (!env) {
    env = "dev";
  }

  karate.configure("logPrettyRequest", true);
  karate.configure("logPrettyResponse", true);
  karate.configure("report", { showLog: true, showAllSteps: true });
  karate.configure("connectTimeout", 5000);
  karate.configure("readTimeout", 60000);

  const config = {
    env: env,
    root: java.lang.System.getProperty('user.dir')
  }
  if (env === "dev") {
    // customize
    // e.g. config.foo = "bar";
  } else if (env === "e2e") {
    // customize
  }
  return config;
}
