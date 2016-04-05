'use strict';

class SchoolTestService {

  constructor() {
    this.$get = [
      '$resource',
      function($resource) {
        var SchoolTest =
            $resource('/api/school_tests/:id', {id : '@id'},
                      {'get' : {transformResponse : transformResponse}});
        return SchoolTest;
      }
    ];

    function transformResponse(data) {
      data = angular.fromJson(data);

      if (data.start_date != null) {
        data.start_date = new Date(data.start_date);
      }
      if (data.end_date != null) {
        data.end_date = new Date(data.end_date);
      }
      return data;
    }
  }
}
