# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

school = School.find("school")
school = School.create(
    _id: "school",
    name: "第一",
    kind: "小学校",
    note: "特になし",
    address: {
      prefecture: "大阪",
      city: "大阪市",
      address1: "中央区１丁目１",
      address2: ""
    }.dup
) unless school

school1 = School.find("school1")
school1 = School.create(
    _id: "school1",
    name: "第二",
    kind: "小学校",
) unless school1

school2 = School.find("school2")
school2 = School.create(
    _id: "school2",
    name: "第一",
    kind: "中学校",
) unless school2

school3 = School.find("school3")
school3 = School.create(
    _id: "school3",
    name: "第三",
    kind: "高校"
) unless school3

student = Student.find("student")
student = Student.create(
    _id: "student",
    name: {
      family_name: "山田",
      first_name: "太郎",
      family_name_kana: "ヤマダ",
      first_name_kana: "タロウ"
    }.dup,
    card_id: "123456789",
    birthday: 1436608979,
    schools: [ { school_id: school.id.to_s, enterance_year: "2013", note: ""} ].dup
) unless student

student1 = Student.find("student1")
student1 = Student.create(
    _id: "student1",
    name: {
      family_name: "山田",
      first_name: "花子",
      family_name_kana: "ヤマダ",
      first_name_kana: "ハナコ"
    }.dup,
    card_id: "223456789",
    birthday: 1436708979,
    schools: [ { school_id: school1.id.to_s, enterance_year: "2012", note: ""} ].dup
) unless student1


school_test = SchoolTest.create(
  _id: "school_test",
  name: "中間テスト",
  start_date: Time.now,
  end_date: Time.now,
  school_id: school1.id.to_s,
  grade: 3,
  subjects: [
    { name: "数学", average: 60.5, test_range: "" },
    { name: "国語", average: 40.5, test_range: "" },
    { name: "物理", average: 50.5, test_range: "" },
    { name: "科学", average: 56.5, test_range: "" },
    { name: "英語", average: 53.5, test_range: "" }
  ].dup
) unless SchoolTest.find("school_test")

textbook = Textbook.create(
  _id: "textbook",
  name: "楽しい算数",
  grade: "小１",
  subject: "算数",
  units: {
    "0" => {unit: "加算"},
    "1" => {unit: "減算"},
    "2" => {unit: "分数"},
    "3" => {unit:"力の釣り合い"}
  }.dup
) unless Textbook.find("textbook")

textbook1 = Textbook.create(
  _id: "textbook1",
  name: "楽しい理科",
  grade: "小２",
  subject: "理科",
  units: {
    "0" => {unit: "光の反射・屈折"},
    "1" => {unit: "レンズ"},
    "2" => {unit: "音"}
  }.dup
) unless Textbook.find("textbook1")

textbook2 = Textbook.create(
  _id: "textbook2",
  name: "楽しい理科",
  grade: "小３",
  subject: "理科",
  units: {
    "0" => {unit: "光の反射・屈折"},
    "1" => {unit: "レンズ"}
  }.dup
) unless Textbook.find("textbook2")
