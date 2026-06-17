// @ts-nocheck
'use strict';

const { createCoreController } = require('@strapi/strapi').factories;

module.exports = createCoreController('api::pub.pub', ({ strapi }) => ({

  async find(ctx) {
    let result = await strapi.entityService.findMany('api::pub.pub', { populate: '*' });
    return result;
  }

}));