Feature: User data update
  
  Background:
    Given that I am logged in as "me@example.com" with password "changeme"
    When I go to user's edit page

  @update_user
  Scenario Outline: Update account data
    And I fill in "user_first_name" field with <user_first_name>
    And I fill in "user_last_name" field with <user_last_name>
    And I fill in "user_password" field with <user_password>
    And I fill in "user_password_confirmation" field with <user_password_confirmation>
    And I press the "Update" button
    Then I should see "<Message>"

    Examples: Successful update
    | user_first_name | user_last_name | user_email            | user_password      | user_password_confirmation | Message                                |
    | "MyFirstName"   | "MyLastName"   | "bismark64@gmail.com" | "mySecretPassword" | "mySecretPassword"         | You updated your account successfully. |

  @remove_user
  Scenario: Remove account
    And I press the "Cancel my account" link
    Then I should see "Bye! Your account was successfully cancelled. We hope to see you again soon."
    And there shouldn't be registered users
