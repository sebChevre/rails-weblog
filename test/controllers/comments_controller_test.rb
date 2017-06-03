require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test 'creates a post comment' do
    post = posts(:one)

    assert_difference('Comment.count') do
      post post_comments_url(post), params: { comment: { body: 'Good post!' } }
    end
    assert_redirected_to post_url(Post.last)
  end
end
