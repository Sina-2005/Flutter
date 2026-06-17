'use strict';

module.exports = {
  routes: [
    {
      method: 'GET',
      path: '/pubs/affordable',
      handler: 'pub.getAffordablePubs',
      config: {
        policies: [],
        middlewares: [],
      },
    },
  ],
};