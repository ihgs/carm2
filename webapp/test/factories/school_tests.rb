FactoryGirl.define do
  factory :school_test do
    name "中間テスト"
    start_date Date.parse("2010-10-01")
    end_date Date.parse("2010-10-06")
    grade 2
    subjects [
      {name: "算数", average: 65.8},
      {name: "国語", average: 55.5},
      {name: "英語", average: 65.8},
      {name: "理科", average: 40.8}
    ]

    trait :one do
      name "中間テスト2"
      start_date Time.parse("2010-10-02")
      end_date Time.parse("2010-10-6")
    end
    trait :two do
      name "期末テスト"
      start_date Time.parse("2010-10-03")
      end_date Time.parse("2010-10-6")
    end
  end

end
