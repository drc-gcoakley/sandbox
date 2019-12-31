module.exports.hello = () => {
  // Sync code
  return {nested: 'world'};
};

module.exports.promised = () => {
  // Async code
  return Promise.resolve('world');
};
