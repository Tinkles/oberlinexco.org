require 'test_helper'

class ExcosControllerTest < ActionController::TestCase
  setup do
    @exco = excos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:excos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exco" do
    assert_difference('Exco.count') do
      post :create, exco: { description: @exco.description, name: @exco.name }
    end

    assert_redirected_to exco_path(assigns(:exco))
  end

  test "should show exco" do
    get :show, id: @exco
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @exco
    assert_response :success
  end

  test "should update exco" do
    put :update, id: @exco, exco: { description: @exco.description, name: @exco.name }
    assert_redirected_to exco_path(assigns(:exco))
  end

  test "should destroy exco" do
    assert_difference('Exco.count', -1) do
      delete :destroy, id: @exco
    end

    assert_redirected_to excos_path
  end
end
