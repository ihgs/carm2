'use strict';

class SchoolTestsDetailController{

  constructor($scope, $stateParams, $q, school_test, SchoolTestService, SchoolTestResultService){
    this.$scope_ = $scope;
    this.school_test_id = $stateParams.id;
    this.SchoolTestService_ = SchoolTestService;
    this.SchoolTestResultService_ = SchoolTestResultService;
    this.school_test = school_test;
  }

  total(subjects){
    let total = 0;
    if (subjects != undefined){
      subjects.forEach(function(element){
        total = total + Number(element['average']);
      });
    }
    return total;
  }

  resultTotal(results){
    let total = 0;
    for (let i in results){
        total = total + Number(results[i]);
    }
    return total;
  }

  updateTestResult(){
    let scope = this.$scope_;
    this.school_test = this.SchoolTestService_.get({'id': this.school_test_id }).$promise.then(function(data){
      scope.ctrl.school_test = data;
    });
  }


}
