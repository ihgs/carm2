class CreateTestResultController {

  constructor($scope, SchoolTestResultService) {
    this.scope_ = $scope;
    this.schoolTestResultService = SchoolTestResultService;

    this.schoolTestId;
    this.student;
    this.subjects;
    this.school_test_result;
  }

  submitTestResult() {
    let scope = this.scope_;
    this.school_test_result['school_test_id'] = this.schoolTestId;
    let result = new this.schoolTestResultService(this.school_test_result);
    result.$save().then(function(data) {
      scope.$parent.ctrl.updateTestResult();
    });
  }
}
