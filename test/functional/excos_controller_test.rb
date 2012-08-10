require 'test_helper'

class ExcosControllerTest < ActionController::TestCase

  setup do
    @exco = excos(:steel_drum)
  end

  context "an admin user" do

    setup do
      user = users(:exco)
      sign_in user
    end

    #GETs
    context "getting" do
      context "the excos index page" do
        should "succeed" do
          get :index
          assert_response :success
          assert_not_nil assigns(:excos)
        end
      end
      context "the all excos page" do
        should "succeed" do
          get :all
          assert_response :success
          assert_not_nil assigns(:excos)
        end
      end
      context "an exco's page" do
        should "succeed" do
          get :show, id: @exco
          assert_response :success
        end
      end
      context "the admin excos page" do
        should "succeed" do
          get :admin
          assert_response :success
        end
      end
      context "the new exco page" do
        should "succeed" do
          get :new
          assert_response :success
        end
      end
      context "an edit exco page" do
        should "succeed" do
          get :edit, id: @exco
          assert_response :success
        end
      end
    end

    # CUD
    context "creating an exco" do
      should "succeed" do
        assert_difference('Exco.count') do
          post :create, exco: { name: 'SexCo II', course_number: 1, enrollment_limit: 16, year: 2012, term: 'Fall' }
        end
        assert_redirected_to admin_excos_path
      end
    end
    context "updating an exco" do
      should "succeed" do
        put :update, id: @exco, exco: { description: @exco.description, name: @exco.name }
        assert_redirected_to admin_excos_path
      end
    end
    context "destroying an exco" do
      should "succeed" do
        assert_difference('Exco.count', -1) do
          delete :destroy, id: @exco
        end
        assert_redirected_to admin_excos_path
      end
    end
  end

end
