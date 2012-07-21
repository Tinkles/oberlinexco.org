require 'test_helper'

class ExcosControllerTest < ActionController::TestCase
  setup do
    @sexco = excos(:sexco)
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
      post :create, exco: { name: 'SexCo II', course_number: 1, enrollment_limit: 16, year: 2012, term: 'Fall' }
    end
    assert_redirected_to exco_path(assigns(:exco))
  end

  test "should show exco" do
    get :show, id: @sexco
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sexco
    assert_response :success
  end

  test "should update exco" do
    put :update, id: @sexco, sexco: { description: @sexco.description, name: @sexco.name }
    assert_redirected_to exco_path(assigns(:exco))
  end

  test "should destroy exco" do
    assert_difference('Exco.count', -1) do
      delete :destroy, id: @sexco
    end

    assert_redirected_to excos_path
  end
end
