# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :channel do
    id 1
    name "Test Channel"
    url "http://www.theverge.com/rss/index.xml"
    user_id 1
  end
end
