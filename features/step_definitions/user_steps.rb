Given(/^I am not registered$/) do
  User.delete_all
end

When(/^I go to (.*?)$/) do |page_name|
  visit path_to(page_name)
end

When(/^I fill in "(.*?)" field with "(.*?)"$/) do |field, value|
  fill_in field, :with => value
end

When(/^I press the "(.*?)" button$/) do |button|
  click_button(button)
end

When(/^I press the "(.*?)" link$/) do |link|
  click_link(link)
end

Then(/^I should see "(.*?)"$/) do |message|
  page.should have_content(message)
end

Then(/^I should have (\d+) new user$/) do |ammount|
  User.count.should == ammount.to_i
end

When(/^I press the "(.*?)" link and allow the required permissions$/) do |link|
  click_link(link)
end

Then(/^I should be redirected to the new registration page$/) do
  visit new_user_registration_path
end

