'use strict';

class SchoolTestsListController {

  constructor(year, SchoolTestService) {
    this.years = [2014,2015,2016,2017,2018]
    this.months = [1,2,3,4,5,6,7,8,9,10,11,12]

    this.from_year = year;
    this.from_month = 4;
    this.to_year = year + 1;
    this.to_month = 3;

    let from_date = new Date(this.from_year, this.from_month-1, 1);
    let to_date = new Date(this.to_year, this.to_month, -1);
    let params = {
      from: this.format(from_date),
      to: this.format(to_date)
    }

    this.school_tests =  SchoolTestService.query(params);
    this.service = SchoolTestService;
  }

  format(date){
    return String(date.getFullYear())+"-"+String(date.getMonth()+1)+"-"+String(date.getDay());
  }

  update(SchoolTestService){
    let from_date = new Date(this.from_year, this.from_month-1, 1);
    let to_date = new Date(this.to_year, this.to_month, -1);
    let params = {
      from: this.format(from_date),
      to: this.format(to_date)
    }

    this.school_tests =  this.service.query(params);
  }
}
