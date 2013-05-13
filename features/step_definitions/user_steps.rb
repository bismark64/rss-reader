Given(/^that I am not registered$/) do
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

#Oauth registration

When(/^I press the "(.*?)" link and allow the required permissions$/) do |link|
  click_link(link)
end

Then(/^I should be redirected to the new registration page$/) do
  visit new_user_registration_path
end

#User update
When(/^I select "(.*?)" in "(.*?)"$/) do |option, select_field|
  select option, :from => select_field
end

Given(/^that I am logged in as "(.*?)" with password "(.*?)"$/) do |email, password|
  @user = FactoryGirl.create(:user)
  visit new_user_session_path
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button("Sign in")
end

#Delete Account
Then(/^there shouldn't be registered users$/) do
  User.count.should == 0
end

#Upload Avatar
When(/^I attach a new (.+\.jpg)$/) do |image|
  attach_file('user_avatar', "#{Rails.root}/features/fixtures/#{image}")
  click_button('Update')
end

When(/^I attach a new (.+\.gif)$/) do |image|
  attach_file('user_avatar', "#{Rails.root}/features/fixtures/#{image}")
  click_button('Update')
end