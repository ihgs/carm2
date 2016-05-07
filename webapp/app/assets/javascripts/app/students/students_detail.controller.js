'use strict';

angular.module('cram.students').controller('StudentsDetailController', [
  '$stateParams', '$scope', '$http', '$window', '$filter', '$q',
  'StudentService',
  function($stateParams, $scope, $http, $window, $filter, $q, StudentService) {
    let id = $stateParams['id'];
    $scope.student = StudentService.get({'id' : id});

  }
]);
