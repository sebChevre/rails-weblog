require 'application_system_test_case'

class AuthenticationTest < ApplicationSystemTestCase
  test 'visiting the home page' do
     #visit home page
     visit '/'
     
     
     assert_selector 'a', 'Sign Up'
     click_on 'Sign Up'
     
     #fill the login form
     fill_in('user_name', with: 'John')
     fill_in('user_password', with: '12345678')
     fill_in('user_mail', with: 'seb@gmail.com')
     
     #envoi des donness
     click_button 'Sign Up'
     
     visit '/'
     assert_selector 'a', 'Log In'
     click_on 'Log In'
     
     fill_in('email', with: 'seb@gmail.com')
     fill_in('password', with: '2345678')
     
     assert_selector 'input', 'Log In'
     click_button 'Log In'
     
     assert_selector 'header','Hello John!' 
     assert_selector 'a','Logout' 
     
     
     
     
     
  end
end