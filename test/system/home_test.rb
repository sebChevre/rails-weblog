require 'application_system_test_case'

class HomeTest < ApplicationSystemTestCase
  test 'visiting the home page' do
    visit '/'

    assert_selector 'h1', text: 'Welcome to Weblog'
    assert_equal(
      all('article h2').map(&:text),
      %i[four three two].map { |n| posts(n).title })
  end
end
