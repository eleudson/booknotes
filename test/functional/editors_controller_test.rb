require 'test_helper'

class EditorsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:editors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create editor" do
    assert_difference('Editor.count') do
      post :create, :editor => { }
    end

    assert_redirected_to editor_path(assigns(:editor))
  end

  test "should show editor" do
    get :show, :id => editors(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => editors(:one).id
    assert_response :success
  end

  test "should update editor" do
    put :update, :id => editors(:one).id, :editor => { }
    assert_redirected_to editor_path(assigns(:editor))
  end

  test "should destroy editor" do
    assert_difference('Editor.count', -1) do
      delete :destroy, :id => editors(:one).id
    end

    assert_redirected_to editors_path
  end
end
