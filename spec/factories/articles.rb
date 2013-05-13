# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    id 1
    guid "urls4859sjis"
    title "An important article"
    link "http://news.example.com/rss/index.xml"
    description "This is an important new where you can learn many new things"
    pubDate "2013-05-07 12:16:10"
    channel_id 1
    starred false
  end
end
