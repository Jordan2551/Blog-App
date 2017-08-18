require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  test "get new category form and create category" do
    get new_category_path#make sure we can retrieve the new category path
    assert_template 'categories/new'#make sure the template for new category exists

    assert_difference 'Category.count', 1 do
      #send a post request to the categories path which gets redirected to the create action
      #with the wanted parameters for the model object
      follow_redirect! categories_path, category: {name: 'sports'}
    end
    assert_template 'categories/index'
    assert_match 'sports', response.body
  end

  test "invalid category submission results in failure" do
    get new_category_path#make sure we can retrieve the new category path
    assert_template 'categories/new'#make sure the template for new category exists

    assert_no_difference 'Category.count' do
      #send a post request to the categories path which gets redirected to the create action
      #with the wanted parameters for the model object
      post categories_path, category: {name: " "}
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end