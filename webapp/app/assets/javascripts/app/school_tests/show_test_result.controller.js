class ShowTestResultController{

  constructor($scope, SchoolTestResultService){
    this.scope_ = $scope;
    this.schoolTestResultService_ = SchoolTestResultService;
    this.schoolTestId;
    this.result;
    this.subjects;
  }

  resultTotal(results){
    let total = 0;
    for (let i in results){
        total = total + Number(results[i]);
    }
    return total;
  }

  deleteTestResut(id){
    let scope = this.scope_.$parent;
    new this.schoolTestResultService_().$delete({id: id}).then(function(data){
      scope.$parent.ctrl.updateTestResult();
    });
  }


}
