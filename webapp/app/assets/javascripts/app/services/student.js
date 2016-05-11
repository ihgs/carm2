'use strict';

class StudentService {
  constructor() {
    this.$get = [
      '$resource',
      function($resource) {
        var Student =
            $resource('/api/students/:id.json', {id : '@id'},
                      {'get' : {transformResponse : transformResponse}});
        return Student;
      }
    ];

    function transformResponse(data) {
      data = angular.fromJson(data);

      data.birthday = new Date(data.birthday);
      return data;
    }
  }
}
