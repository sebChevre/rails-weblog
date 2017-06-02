class User < ApplicationRecord
  has_secure_password

  def display_name
    if admin?
      "#{name} (admin)"
    else
      name
    end
  end
end
