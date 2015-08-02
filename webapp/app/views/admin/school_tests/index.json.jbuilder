json.array!(@school_tests) do |school_test|
  json.extract! school_test, :id
  json.url school_test_url(school_test, format: :json)
end
