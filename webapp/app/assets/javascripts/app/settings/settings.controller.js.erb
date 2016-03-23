'use strict';

angular.module('cram.settings').controller('SettingsController', [
  '$scope', 'Course',
  function($scope, Course) {
    $scope.courses = Course.query();
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
      Course.update({id : course.id, name : data}, function(){

                                                   });
    };

    $scope.hover = function(course) {
      course.showDelete = !course.showDelete;
      course.showEdit = !course.showEdit;
    };

  }
]);
