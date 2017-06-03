require 'test_helper'

class Admin::PostsControllerTest < ActionDispatch::IntegrationTest
  test 'gets index when admin' do
    sign_in_as(:bob)

    get admin_posts_url

    assert_response :success
  end

  test 'redirects to sign-in when non-admin' do
    sign_in_as(:jane)

    get admin_posts_url

    assert_redirected_to new_session_url
  end

  test 'redirects to sign-in when guest' do
    get admin_posts_url

    assert_redirected_to new_session_url
  end
end
