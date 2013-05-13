Feature: Article Management

  This feature includes several actions in the articles,
  such as comments, mark with star and searching

  Background:
    Given that I am logged in as "me@example.com" with password "changeme"
    And I have an existing article
    When I go to channel's show page


  @comment_article
  Scenario: Comment my existing article
    And I press the "Comment" link
    And I fill in "comment_body" field with "This is my comment"
    And I press the "Create Comment" button
    Then I should see "This is my comment"
    And my article should have 1 new comment


  @star_article @search
  Scenario: Mark with an star my article
    And my article is not starred
    When I press the "star-link" link
    Then my article should be starred


  @search_article @search
  Scenario Outline: Search articles by Title and Body/Summary
    And I have other articles records
    When I go to channel's show page
    And I fill in "search" field with "<search_query>"
    And I press the "Search" button
    Then I should see the following articles "<search_output>"

  Examples:
  | search_query | search_output                                                                        |
  | This is      | An important article,This is my favorite article                                    |
  | test         |                                                                                      |
  | article      | Another article,An important article,The best article,This is my favorite article |
