include ApplicationHelper

def valid_signin(user)
	fill_in "Email", 	with: user.email
	fill_in "Password", with: user.password
	click_button "Sign in"
end

def valid_signup
	fill_in "Name",			with: "Example User"
	fill_in "Email",		with: "user@example.com"
	fill_in "Password",		with: "foobar"
	fill_in "Confirmation",	with: "foobar"

end

RSpec::Matchers.define :have_error_message do |message|
	match do |page|
		page.should have_selector('div.alert.alert-error', text: message)
	end
end

RSpec::Matchers.define :have_success_message do |message|
	match do |page|
		page.should have_selector('div.alert.alert-success', text: message)
	end
end

RSpec::Matchers.define :have_blank_signup_form_errors do
	match do |page|
		page.should have_content('error')
       page.should have_content("The Password can't be blank")
        page.should have_content("The Password is too short (minimum is 6 characters)")
        page.should have_content("The Password confirmation can't be blank")
	end
        page.should have_content('The form contains 6 errors')
        page.should have_content("The Name cannot be left blank")
        page.should have_content("The Email cannot be left blank")
        page.should have_content("The Email is invalid")
 
end
