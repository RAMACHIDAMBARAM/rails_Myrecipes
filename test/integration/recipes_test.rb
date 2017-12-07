require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = Chef.create!(chefname: "user", email: "user@example.com")
    @recipe = Recipe.create(name: "vegetable saute", description: "great vegetable sautee, add vegetable and oil", chef: @user)
    @recipe2 = @user.recipes.build(name: "chicken saute", description: "great chicken dish")
    @recipe2.save
  end
  
  
  test "should get recipe index" do
    
    get recipes_path
    assert_response :success
    
  end
  
  
  test "should get recipes listing" do
    
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
    
  end
  
  
  
  # test "the truth" do
  #   assert true
  # end
end
