'use strict';

angular.module('cram.settings').controller('SettingsController', [
  '$scope', '$http', 'Course', 'notice_response',
  function($scope, $http, Course, notice_response) {
    $scope.courses = Course.query();
    $scope.notice = notice_response.data;
    $scope.showSuccessAlert = {};
    $scope.add = function() {
      Course.save($scope.course, function(_course) {
        $scope.courses.push(_course);
        $scope.course.name = null;
      });
    };

    $scope.remove = function($event, course) {
      Course.delete({id : course.id}, function() {
        $scope.courses = _.filter($scope.courses,
                                  function(_t) { return _t.id != course.id; });
      });
    };

    $scope.update = function(course, data) {
      Course.update({id : course.id, name : data}, function() {

      });
    };

    $scope.hover = function(course) {
      course.showDelete = !course.showDelete;
      course.showEdit = !course.showEdit;
    };

    $scope.save_smtp_config = function() {
      $http({
        method : 'POST',
        url : '/api/notice_mailer/save_smtp_config',
        data : {'notice' : $scope.notice}
      })
          .success(function(data, status, headers) {
            $scope.showSuccessAlert.save_smtp_config = true;
          })
          .error(function(data, status, headers) {
            // TODO
          });

    };

    $scope.hidden_alert = function(value) {
      $scope.showSuccessAlert[value] = false;
    };

    $scope.send_test_mail = function() {
      $http({
        method : 'POST',
        url : '/api/notice_mailer/send_test_mail',
        data : {'to' : $scope.test_to_address}
      })
          .success(function(data, status, headers) {
            $scope.showSuccessAlert.send_test_mail = true;
          })
          .error(function(data, status, headers) {
            // TODO
          });
    };
  }
]);
