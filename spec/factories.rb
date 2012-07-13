FactoryGirl.define do
factory :user do
    sequence(:name)  { |n| "User#{n}" }
    sequence(:email) { |n| "user#{n}@test.com"}
    password "foobar"
    password_confirmation "foobar"
  end

end
