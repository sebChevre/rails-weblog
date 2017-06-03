module SessionHelper
  def sign_in_as(name)
    user = users(name)
    post session_url, params: { email: user.email, password: 'secret' }
  end
end
