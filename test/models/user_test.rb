require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "#display_name when Bob admin" do
     
      user = User.new(admin:true,name:"Bob")
     
      assert_equal("Bob (admin)", user.display_name, msg = "nop")
  end
  
  test "#display_name when Bob no admin" do
     
      user = User.new(admin:false,name:"Bob")
     
      assert_equal("Bob", user.display_name, msg = "nop")
  end
  
  test "ensure that password lngeth is min 8" do
    user = User.new(admin:true, name:"Toto", password:"1234567")
    
    assert_not user.valid?
  
  end
  

 
end
