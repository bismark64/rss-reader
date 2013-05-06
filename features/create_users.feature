Feature: User Registration
	In order use the app
	As a new guest
	I want to be registered in the app

	Background:
		Given I am not registered
		When I go to user's registration page

	Scenario Outline: User registration page
		And I fill in "user_first_name" field with <user_first_name>
		And I fill in "user_last_name" field with <user_last_name>
		And I fill in "user_login" field with <user_login>
		And I fill in "user_email" field with <user_email>
		And I fill in "user_password" field with <user_password>
		And I fill in "user_password_confirmation" field with <user_password_confirmation>
		And I press the "Register" button
		And I should see "<message>"
		And <user_email> should <Receive Email?>
		And I should have <User count> new user

	Examples: Successful registrations
| user_first_name | user_last_name | user_login   | user_email            | user_password      | user_password_confirmation | message                                                                                                                | Receive Email?   | User count |
| "MyFirstName"   | "MyLastName"   | "myUsername" | "bismark64@gmail.com" | "mySecretPassword" | "mySecretPassword"         | A message with a confirmation link has been sent to your email address. Please open the link to activate your account. | receive an email | 1          |
| "Pepe"          | "Argento"      | "Pepito2013" | "bismark64@gmail.com" | "aguentePepe598"   | "aguentePepe598"           | A message with a confirmation link has been sent to your email address. Please open the link to activate your account. | receive an email | 1          |

		Examples: Failed registrations
| user_first_name | user_last_name                                                               | user_login   | user_email            | user_password      | user_password_confirmation | message                                          | Receive Email?   | User count |
| ""              | "MyLastName"                                                                 | "myUsername" | "bismark64@gmail.com" | "mySecretPassword" | "mySecretPassword"         | First name can't be blank                        | receive no email | 0          |
| "Pepe"          | "Argento"                                                                    | "Pepito2013" | "bismark64@gmail.com" | "aguentePepe598"   | "aguentePepe599"           | Password doesn't match confirmation              | receive no email | 0          |
| "Pepe"          | "Argento Mario Ruben Pablo de los Castillos Fernández Prado de la Vera Cruz" | "Pepito2013" | "bismark64@gmail.com" | "aguentePepe598"   | "aguentePepe598"           | Last name is too long (maximum is 50 characters) | receive no email | 0          |

	@oauth
	Scenario Outline: OAuth2 authorization
		And I press the "<Provider Link>" link and allow the required permissions
		Then I should be redirected to the new registration page
		When I fill in "user_email" field with "<user_email>"
		When I fill in "user_password" field with "<user_password>"
		When I fill in "user_password_confirmation" field with "<user_password_confirmation>"
		When I press the "Register" button
		Then I should see "<Message>"
		And "<user_email>" should <Receive Email?>
		And I should have <User count> new user

	Examples:
| Provider Link | Message                                                                                                                | user_email          | user_password      | user_password_confirmation | Receive Email?   | User count |
| Google        | A message with a confirmation link has been sent to your email address. Please open the link to activate your account. | bismark64@gmail.com | "mySecretPassword" | "mySecretPassword"         | receive an email | 1          |
| Twitter       | A message with a confirmation link has been sent to your email address. Please open the link to activate your account. | bismark64@gmail.com | "aguentePepe598"   | "aguentePepe598"           | receive an email | 1          |
