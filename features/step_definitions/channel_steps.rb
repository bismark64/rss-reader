Then(/^I should have "(.*?)" new channels?$/) do |count|
  Channel.count.should == count.to_i
end

# When(/^I press the 'Create Channel' button$/) do
#   FactoryGirl.create(:channel)
# end

#Edit channel
Given(/^I have a channel named "(.*?)"$/) do |name|
  FactoryGirl.create(:channel, name: name)
end

Then(/^the channel should be named "(.*?)"$/) do |name|
  Channel.first.name.should == name
end

# Delete Channel
Then(/^my channel should be deleted$/) do
  Channel.delete_all
end

#Unabled Channel Creation
Given(/^I have a basic profile type$/) do
  @user.profile_type = 'basic'
  @user.save
end

Given(/^I already have (\d+) channels$/) do |count|
  count.to_i.times do |index|
    channel = FactoryGirl.create(:channel, id: index)
    @user.channels << channel
  end
end

#Search Channel
Given(/^I have the some channels records$/) do
  FactoryGirl.create(:channel, id: 2, name: "This is a test channel")
  FactoryGirl.create(:channel, id: 3, name: "This is other new channel")
  FactoryGirl.create(:channel, id: 4, name: "Another channel in the list")
end

Then(/^I should see the following channels "(.*?)"$/) do |titles|
  page_titles = page.all(:css, 'a.channel-name').map { |title| title.text }
  test_titles = titles.split(",")

  unless page_titles - test_titles == []
    raise Exception   
  end
end
