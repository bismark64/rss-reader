Feature: User data update
  
  Background:
    Given that I am logged in as "me@example.com" with password "changeme"
    When I go to user's edit page


  @update_user
  Scenario Outline: Update account data
    And I select "<option>" in "user_profile_type"
    And I fill in "user_first_name" field with <user_first_name>
    And I fill in "user_last_name" field with <user_last_name>
    And I fill in "user_password" field with <user_password>
    And I fill in "user_password_confirmation" field with <user_password_confirmation>
    And I press the "Update" button
    Then I should see "<Message>"

    Examples: Successful update
    | option  | user_first_name | user_last_name | user_password      | user_password_confirmation | Message                                |
    | premium | "MyFirstName"   | "MyLastName"   | "mySecretPassword" | "mySecretPassword"         | You updated your account successfully. |

    Examples: Failed update
    | option  | user_first_name | user_last_name | user_password      | user_password_confirmation | Message                               |
    | premium | "MyF1rstNam3"   | "MyLastName"   | "mySecretPassword" | "mySecretPassword"         | First name must contain only letters. |
    | basic   | "MyFirstName"   | "MyLastName"   | "mySecretPassword" | "mySecretPasswod"          | Password doesn't match confirmation   |



  @remove_user
  Scenario: Remove account
    And I press the "Cancel my account" link
    Then I should see "Bye! Your account was successfully cancelled. We hope to see you again soon."
    And there shouldn't be registered users


  @upload_avatar
  Scenario Outline: Upload a new avatar
    And I attach a new <image>
    Then I should see "<message>"

  Examples: Successful upload
  | image    | message                                |
  | test.jpg | You updated your account successfully. |

  Examples: Failed upload
  | image    | message                                                                         |
  | test.gif | Avatar You are not allowed to upload "gif" files, allowed types: jpg, jpeg, png |
