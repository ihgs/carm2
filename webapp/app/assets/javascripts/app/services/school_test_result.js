'use strict';

class SchoolTestResultService {

  constructor() {
    this.$get = [
      '$resource',
      function($resource) {
        var SchoolTestResult = $resource('/admin/school_test_results/:id', {id : '@id'}, {

        });
        return SchoolTestResult;
      }
    ];

  }
}
