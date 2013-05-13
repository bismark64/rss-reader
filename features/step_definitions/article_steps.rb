Given(/^I have an existing article$/) do
  FactoryGirl.create(:channel)
  @article = FactoryGirl.create(:article)
end

Then(/^my article should have (\d+) new comment$/) do |count|
  @article.comments.count.should == count.to_i
end

# Starred Article
When(/^my article is not starred$/) do
  @article.starred.should == false
end

Then(/^my article should be starred$/) do
  @article = Article.find(1)
  @article.starred.should == true
end

#Search Articles
When(/^I have other articles records$/) do
  FactoryGirl.create(:article, id: 2, guid: "url488559sjis", title: 'This is my favorite article', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent fermentum euismod tortor sit amet dignissim.')
  FactoryGirl.create(:article, id: 3, guid: "url88559sjis", title: 'Another article', description: 'Sed mauris justo, laoreet eget eleifend eleifend, imperdiet eget enim.')
  FactoryGirl.create(:article, id: 4, guid: "ul8559sjis", title: 'The best article', description: 'Donec eget odio ac libero interdum mollis sed non lectus')
end

Then(/^I should see the following articles "(.*?)"$/) do |titles|
  page_titles = page.all("h4").map { |title| title.text }
  test_titles = titles.split(",")
  
  unless page_titles - test_titles == []
    raise Exception   
  end
end
