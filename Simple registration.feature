Feature: Registering new account
As a user I want to be able to register new account 
On the site https://fill.dev/form/registration-simple

Background: I have a valid email account

Scenario: Register filling all the fields with valid data
	Given that I don't already have an account
	When I enter "asdfgh@testmail.com" in the "Email" text field
	And I enter "testname" in the "Username" text field
	And I enter "Pass!98765" in the "Password" text field
	And I enter "Pass!98765" in the "Confirm Password" text field
	And I click the "Register" button
	Then The user account have been created 
	And I see a confirmation message 

Scenario: Filling registration form with an empty email
	Given that I don't already have an account
	When I leave the "Email" text field empty
	And I enter "testname" in the "Username" text field
	And I enter "Pass!98765" in the "Password" text field
	And I enter "Pass!98765" in the "Confirm Password" text field
	And I click the "Register" button
	Then I see a tooltip message pointing out the empty field
	And Completion of the form is prevented

Scenario Outline: Filling registration form with an invalid email
	Given that I don't already have an account
	When I enter "<InvalidEmail>" in the "Email" text field
	And I enter "testname" in the "Username" text field
	And I enter "Pass!98765" in the "Password" text field
	And I enter "Pass!98765" in the "Confirm Password" text field
	And I click the "Register" button
	Then I see a tooltip message explaining the invalidity in the "Password" text field
	And Completion of the form is prevented

	Examples:
		| InvalidEmail         |
		| asdfgh2testmail.com  |
		| asdfgh@testmail      |
		| a,s;d@testmail.com   |

Scenario: Filling registration form with an empty username
	Given that I don't already have an account
	When I enter "asdfgh@testmail.com" in the "Email" text field
	And I leave the "Username" text field empty
	And I enter "Pass!98765" in the "Password" text field
	And I enter "Pass!98765" in the "Confirm Password" text field
	And I click the "Register" button
	Then I see a tooltip message pointing out the empty field
	And Completion of the form is prevented

Scenario Outline: Filling registration form with an invalid username
	Given that I don't already have an account
	When I enter "asdfgh@testmail.com" in the "Email" text field
	And I enter "<Invalid_Username>" in the "Username" text field
	And I enter "Pass!98765" in the "Password" text field
	And I enter "Pass!98765" in the "Confirm Password" text field
	And I click the "Register" button
	Then I see a tooltip message explaining the invalidity in the "Username" text field
	And Completion of the form is prevented

	Examples:
	# The underscore character _ represents a single whitespace
		| Invalid_Username                                                 |
		| _                                                                |
		| ,^'*"+=                                                          |
		| FSEpf4UhQAkw8JZzbqFhHCBZVIAuK2Qhdk1B6DVZ6SEkNUcVwMqtGBdWk0Uy6oBA |

Scenario: Filling registration form with an empty password
	Given that I don't already have an account
	When I enter "asdfgh@testmail.com" in the "Email" text field
	And I enter "testname" in the "Username" text field
	And I leave the "Password" text field empty
	And I leave the "Confirm Password" text field empty
	And I click the "Register" button
	Then I see a tooltip message pointing out the empty field
	And Completion of the form is prevented

Scenario Outline: Filling registration form with an invalid password
	Given that I don't already have an account
	When I enter "asdfgh@testmail.com" in the "Email" text field
	And I enter "testname" in the "Username" text field
	And I enter "<Invalid_Password>" in the "Password" text field
	And I enter "<Invalid_Password>" in the "Confirm Password" text field
	And I click the "Register" button
	Then I see a tooltip message explaining the invalidity in the "Password" text field
	And Completion of the form is prevented

	Examples:
	# The underscore character _ represents a single whitespace
		| Invalid_Password                                                 |
		| _                                                                |
		| FSEpf4UhQAkw8JZzbqFhHCBZVIAuK2Qhdk1B6DVZ6SEkNUcVwMqtGBdWk0Uy6oBA |

Scenario Outline: Filling registration form with an invalid password
	Given that I don't already have an account
	When I enter "asdfgh@testmail.com" in the "Email" text field
	And I enter "testname" in the "Username" text field
	And I enter "Pass!98765" in the "Password" text field
	And I enter "Pass" in the "Confirm Password" text field
	And I click the "Register" button
	Then I see a message explaining that the confirmation password must be the same as the password
	And Completion of the form is prevented

Scenario: Register filling all the fields with valid data with leading and trailing spaces added
	Given that I don't already have an account
	When I enter "   asdfgh@testmail.com   " in the "Email" text field
	And I enter "   testname   " in the "Username" text field
	And I enter "Pass!98765" in the "Password" text field
	And I enter "Pass!98765" in the "Confirm Password" text field
	And I click the "Register" button
	Then The user account have been created 
	And I see a confirmation message 

	# The End
