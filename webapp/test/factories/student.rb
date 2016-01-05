FactoryGirl.define do

  factory :student do
    name({
      family_name: "山田",
      first_name: "太郎"
      })
    card_id "000000000000"
    birthday do
      today = Date.today
      Date.new(today.year - 15, today.month, today.day)
    end
    schools do
      school = create(:school)
      [
        school_id: school.id.to_s, enterance_year:"2012"
        ]
    end
  end

end
