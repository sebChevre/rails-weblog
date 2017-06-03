require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'validates title presence' do
    post = Post.new(title: nil)

    assert_not post.valid?
    assert_equal [:title], post.errors.keys
  end
end
