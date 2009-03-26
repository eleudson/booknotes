require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reviews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create review" do
    assert_difference('Review.count') do
      post :create, :review => { }
    end

    assert_redirected_to review_path(assigns(:review))
  end

  test "should show review" do
    get :show, :id => reviews(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => reviews(:one).id
    assert_response :success
  end

  test "should update review" do
    put :update, :id => reviews(:one).id, :review => { }
    assert_redirected_to review_path(assigns(:review))
  end

  test "should destroy review" do
    assert_difference('Review.count', -1) do
      delete :destroy, :id => reviews(:one).id
    end

    assert_redirected_to reviews_path
  end
end
