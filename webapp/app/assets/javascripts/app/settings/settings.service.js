'use strict';

angular.module('cramApp')
  .provider('Course', function () {
    this.$get = ['$resource', function ($resource){
      var Course = $resource('/api/courses/:id', { id: '@id' } );
      Course.prototype = {
      };
      return Course;
    }];
  });
