function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    myVarName: 'someValue',
    postService: 'https://federation-gateway-staging.env.edvisor.io/graphql'
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
    config.postService = 'http://localhost:3100/graphql'
  } else if (env == 'staging') {
    // customize
    config.postService = 'https://federation-gateway-staging.env.edvisor.io/graphql'
  }
  return config;
}