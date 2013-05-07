# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    guid "MyString"
    title "MyString"
    link "MyString"
    description "MyText"
    pubDate "2013-05-07 12:16:10"
    channel_id 1
  end
end
