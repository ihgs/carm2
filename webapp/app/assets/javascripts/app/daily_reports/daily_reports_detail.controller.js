'use strict';

angular.module('cram.daily_reports')
    .controller('DailyReportsDetailController', [
      '$stateParams', '$scope', '$http', '$window', '$filter', '$q',
      'DailyReportService', 'Student', 'Textbook',
      function($stateParams, $scope, $http, $window, $filter, $q,
               DailyReportService, Student, Textbook) {
        let id = $stateParams['id'];
        $scope.daily_report = DailyReportService.get({'id' : id});

        let students = Student.query();
        $scope.studentMap = {};
        students.$promise.then(function(data) {
          data.forEach(function(item) {
            $scope.studentMap[item.id] = {'fullname' : item.fullname};
          });
        });
        let textbooks = Textbook.query();
        $scope.textbookMap = {};
        textbooks.$promise.then(function(data) {
          data.forEach(function(item) {
            $scope.textbookMap[item.id] = {'name' : item.name};
          });
        });

      }
    ]);
