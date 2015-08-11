# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

school = School.create(

    name: "第一小学校",
    kind: "小学校",
    note: "特になし",
    address: {
      prefecture: "大阪",
      city: "大阪市",
      address1: "中央区１丁目１",
      address2: ""
    }.dup

)

student = Student.create(

    name: {
      family_name: "山田",
      first_name: "太郎",
      family_name_kana: "ヤマダ",
      first_name_kana: "タロウ"
    }.dup,
    card_id: "123456789",
    birthday: 1436608979,
    schools: [ { school_id: school.id, note: ""} ].dup
)

school_test = SchoolTest.create(
  name: "中間テスト",
  start_date: Time.now,
  end_date: Time.now,
  subjects: [
    { name: "数学", average: 60.5, test_range: "" },
    { name: "国語", average: 40.5, test_range: "" },
    { name: "物理", average: 50.5, test_range: "" },
    { name: "科学", average: 56.5, test_range: "" },
    { name: "英語", average: 53.5, test_range: "" }  
  ].dup

)
