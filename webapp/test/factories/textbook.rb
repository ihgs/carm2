FactoryGirl.define do

  factory :textbook, :class => 'Textbook' do
    name "楽しい数学"
    subject "数学"
    grade "中１"
    units ({
      "0" => {"unit"=> "正の数と負の数", "subunits"=>
          ["正の数と負の数", "正の数と負の数の加法", "正の数と負の数の減法"]},
      "1" => {"unit"=> "文字と式", "subunits"=>
          ["文字式のきまり", "数量の表し方", "式の値", "一次式"]},
      "null" => {"unit"=> "No data"}
      })
  end
end
