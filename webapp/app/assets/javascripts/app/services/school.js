'use strict';

class SchoolService {
  constructor() {
    this.$get = [
      '$resource',
      function($resource) {
        var School = $resource('/api/schools/:id.json', {id : '@id'}, {});
        return School;
      }
    ];
  }
}
