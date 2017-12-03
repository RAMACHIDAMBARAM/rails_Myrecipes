require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "user", email: "user@example.com")

  end

  test "should be valid" do
    assert @chef.valid?
  end

  test "chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end
  
  test "chefname should be less than 30 characters" do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?
    
  end
  
  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end
  
   test "emails should not be too long" do
    @chef.chefname = "a" * 255 + "@example.com"
    assert_not @chef.valid?
  end
  
  test "email should accept correct format" do
    valid_emails = %w[user@example.com r@gmail.com m.first@yahoo.ca john+smith@co.uk.org] 
    valid_emails.each do|valids|
    @chef.email = valids
    assert @chef.valid?, "#{valids.inspect} should be valid"
    end
  end
  
  test "should reject invalid email addresses" do
    invalid_emails = %w[user1@example r3@gmail,com m4.first@yahoo. john@bar+sm5ith@co.uk.org]
    invalid_emails.each do|invalids|
     @chef.email = invalids
    assert_not @chef.valid?, "#{invalids.inspect} should not be valid"
    end
    
  end
  
  
  test "email shoul be unique and case insensitive" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
    
  end
  
  test "email should be in lower case before hitting db" do
    mixed_email = "joHn@Example.com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
    
  end
  
end