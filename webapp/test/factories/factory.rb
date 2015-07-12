FactoryGirl.define do
  factory :student do
    name({
      family_name: "yamada",
      first_name: "taro"
      })
    card_id "aaaaa"
    birthday 1121339049
  end

end
