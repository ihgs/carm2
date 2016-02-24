'use strict';

angular.module('cram.settings')
  .provider('Course', function () {
    this.$get = ['$resource', function ($resource){
      var Course = $resource('/api/courses/:id', { id: '@id' },{
        'update': {method: 'PUT'}
      });
      return Course;
    }];
  });
