Feature: Channel management
  
  This includes the creation, updating and deleting of a channel.

  Background:
    Given that I am logged in as "me@example.com" with password "changeme"


  @create_channel @search
  Scenario Outline: Create a new channel
    When I go to the new channel page
    And I fill in "channel_url" field with "<URL>"
    And I press the "Create Channel" button
    Then I should see "<Message>"
    And I should have "<count>" new channel

  Examples: Successful creation
  | URL                                                      | Message                           | count |
  | http://www.theverge.com/rss/index.xml                    | Channel was successfully created. | 1     |
  | http://clarin.feedsportal.com/c/33088/f/577681/index.rss | Channel was successfully created. | 1     |

  Examples: Failed creation
  | URL                                                                            | Message                                          | count |
  | http://google.com                                                              | The provided url is not a RSS/Atom valid source. | 0     |
  | http://wordpress.org/extend/plugins/about/readme.txt                           | The provided url is not a RSS/Atom valid source. | 0     |
  | http://www.enetpulse.com/wp-content/uploads/summer_olympics_mens_road_race.xml | The provided url is not a RSS/Atom valid source. | 0     |


  @edit_channel @search
  Scenario: Edit an existing channel
    And I have a channel named "My Channel"
    When I go to channel's edit page
    And I fill in "channel_name" field with "My Tested Channel"
    And I press the "Update Channel" button
    Then I should see "Channel was successfully updated."
    And the channel should be named "My Tested Channel"


  @delete_channel @search
  Scenario: Delete an existing channel
    And I have a channel named "My Channel"
    When I go to channel's index page
    And I press the "Destroy" link
    Then I should have "0" new channels


  @unabled_channel_creation @search
  Scenario: Try to create a new channel when my allowed channels are full.
    And I have a basic profile type
    But I already have 10 channels
    When I go to the new channel page
    Then I should see "Your account doesn't allows you to add more channels, change your profile type in order to add more channels"


  @channel_search @search
  Scenario Outline: Search channels by Name
    And I have the some channels records
    When I go to channel's index page
    And I fill in "search" field with "<search_query>"
    And I press the "Search" button
    Then I should see the following channels "<search_output>"

  Examples:
  | search_query    | search_output                                                                |
  | This is         | This is a test channel,This is other new channel                             |
  | test            | This is a test channel                                                       |
  | another channel | Another channel in the list                                                  |
  | channel         | Another channel in the list,This is a test channel,This is other new channel |
