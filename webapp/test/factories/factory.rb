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

end
