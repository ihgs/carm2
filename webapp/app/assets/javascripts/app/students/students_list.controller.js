'use strict';

angular.module('cram.students').controller('StudentsListController', [
  '$scope', '$http', '$window', '$filter', '$q', '$stateParams', 'StudentService',
  'CourseService',
  function($scope, $http, $window, $filter, $q, $stateParams, StudentService, CourseService) {
    let scope = $stateParams['scope'];
    $scope.students = StudentService.query({'scope':scope});
    $scope.courses = CourseService.query();
  }
]);
