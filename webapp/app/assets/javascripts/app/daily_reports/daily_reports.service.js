'use strict';

let app = angular.module('cram.daily_reports');
app.provider('Student', function () {
  this.$get = ['$resource', function ($resource){
    var Student = $resource('/api/students/:id.json', { id: '@id' },{
    });
    return Student;
  }];
});

app.provider('Textbook', function () {
  this.$get = ['$resource', function ($resource){
    var Textbook = $resource('/admin/textbooks/:id.json', { id: '@id' },{
    });
    return Textbook;
  }];
})
