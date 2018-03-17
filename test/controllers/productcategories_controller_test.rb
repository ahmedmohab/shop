require 'test_helper'

class ProductcategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @productcategory = productcategories(:one)
  end

  test "should get index" do
    get productcategories_url
    assert_response :success
  end

  test "should get new" do
    get new_productcategory_url
    assert_response :success
  end

  test "should create productcategory" do
    assert_difference('Productcategory.count') do
      post productcategories_url, params: { productcategory: { categoryname: @productcategory.categoryname } }
    end

    assert_redirected_to productcategory_url(Productcategory.last)
  end

  test "should show productcategory" do
    get productcategory_url(@productcategory)
    assert_response :success
  end

  test "should get edit" do
    get edit_productcategory_url(@productcategory)
    assert_response :success
  end

  test "should update productcategory" do
    patch productcategory_url(@productcategory), params: { productcategory: { categoryname: @productcategory.categoryname } }
    assert_redirected_to productcategory_url(@productcategory)
  end

  test "should destroy productcategory" do
    assert_difference('Productcategory.count', -1) do
      delete productcategory_url(@productcategory)
    end

    assert_redirected_to productcategories_url
  end
end
