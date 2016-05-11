'use strict';

class StudentsController {

  constructor($http, $window, type, student, schools, courses) {
    this.$http = $http;
    this.$window = $window;
    this.type = type;
    if (student.schools == undefined || student.schools.length == 0) {
      student.schools = [ {} ];
    }
    this.student = student;
    this.schools = schools;
    this.courses = courses;
  }

  submit_new() {
    let _window = this.$window;

    this.$http({
          method : 'POST',
          url : '/api/students',
          data : {'student' : this.student}
        })
        .success(function(data, status, headers) {
          _window.location.href = `/admin/students#/${data['id']}/detail`;
        })
        .error(function(data, status, headers) {

        });
  }

  submit_update() {
    let _window = this.$window;

    this.$http({
          method : 'PATCH',
          url : '/api/students/' + this.student.id,
          data : {'student' : this.student}
        })
        .success(function(data, status, headers) {
          _window.location.href = `/admin/students#/${data['id']}/detail`;
        })
        .error(function(data, status, headers) {

        });
  }
}
