FactoryGirl.define do
  factory :student do
    name({
      family_name: "yamada",
      first_name: "taro"
      })
    contact_information({mail: "test@example.com"})
    card_id "aaaaa"
    birthday 1121339049
  end

  sequence :student_names do |n|
    {
      family_name: "鈴木",
      first_name: "#{n}郎"
    }
  end

  factory :sequence_students, class: Student do
    name { FactoryGirl.generate(:student_names)}
    contact_information({mail: "test@example.com"})
  end
end
