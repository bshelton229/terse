# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :visit_log do
    url nil
    referer "MyString"
    ip "MyString"
  end
end
