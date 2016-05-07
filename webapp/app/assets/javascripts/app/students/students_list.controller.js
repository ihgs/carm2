'use strict';

angular.module('cram.students').controller('StudentsListController', [
  '$scope', '$http', '$window', '$filter', '$q', 'StudentService',
  'CourseService',
  function($scope, $http, $window, $filter, $q, StudentService, CourseService) {
    $scope.students = StudentService.query();
    $scope.courses = CourseService.query();

  }
]);
