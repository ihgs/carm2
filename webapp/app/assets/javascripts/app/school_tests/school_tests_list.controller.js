'use strict';

class SchoolTestsListController {

  constructor(school_tests) {
    let today = new Date();
    this.from_year = today.getFullYear();
    this.from_month = 4;
    this.from_day = 1;
    this.to_year = this.from_year + 1;
    this.to_month = 3;
    this.to_day = 31;

    this.years = [2014,2015,2016,2017,2018]
    this.months = [1,2,3,4,5,6,7,8,9,10,11,12]
    this.school_tests = school_tests;
  }
}
