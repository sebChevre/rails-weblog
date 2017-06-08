require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  test 'can sign-up as new use from homepage' do
    get '/'

    assert_response :success
    assert_select 'a', 'Sign Up'

    post '/users',
      params: {
        user: {
          name: 'John Doe',
          email: 'john@doe.com',
          password: 'secret123456'
        }
      }

    assert_redirected_to '/'
    follow_redirect!
    assert_response :success
    assert_select '.flash.notice', 'Thank you for signing up!'
  end
end
