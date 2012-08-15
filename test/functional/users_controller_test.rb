require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  setup do
    @user = users(:george)
    @self = users(:abe)
    @admin = users(:exco)
  end

  context "a non-admin user" do

    setup do
      sign_in @self
    end

    #GETs
    context "getting" do
      context "the users index page" do
        should "fail" do
          get :index
          assert_redirected_to root_url
        end
      end
      context "a user's page" do
        should "fail" do
          get :show, id: @user
          assert_redirected_to root_url
        end
      end
      context "his own user's page" do
        should "succeed" do
          get :show, id: @self
          assert_response :success
        end
      end
      context "the new user page" do
        should "redirect" do
          get :new
          assert_redirected_to root_url
        end
      end
      context "an edit user page" do
        should "redirect" do
          get :edit, id: @user
          assert_redirected_to root_url
        end
      end
    end

    # CUD
    context "creating a user" do
      should "fail" do
        assert_no_difference('User.count') do
          post :create, user: { email: 'thomas@pres.com', last_name: 'Jefferson' , first_name: 'Thomas', t_number: 'T00000011' }
        end
        assert_redirected_to root_url
      end
    end
    # TODO come up with a better test for this
    # probs add it to the Exco tests, too
    context "updating a user" do
      should "fail" do
        put :update, id: @user, user: { last_name: @user.last_name, t_number: @user.t_number }
        assert_redirected_to root_url
      end
    end
    context "destroying a user" do
      should "fail" do
        assert_no_difference('User.count') do
          delete :destroy, id: @user
        end
        assert_redirected_to root_url
      end
    end
  end

  context "an admin user" do

    setup do
      sign_in @admin
    end

    #GETs
    context "getting" do
      context "the users index page" do
        should "succeed" do
          get :index
          assert_response :success
          assert_not_nil assigns(:users)
        end
      end
      context "an user's page" do
        should "succeed" do
          get :show, id: @user
          assert_response :success
        end
      end
      context "his own user's page" do
        should "succeed" do
          get :show, id: @admin
          assert_response :success
        end
      end
      context "the new user page" do
        should "succeed" do
          get :new
          assert_response :success
        end
      end
      context "an edit user page" do
        should "succeed" do
          get :edit, id: @user
          assert_response :success
        end
      end
    end

    # CUD
    context "creating an user" do
      should "succeed" do
        assert_difference('User.count') do
          post :create, user: { email: 'thomas@pres.com', last_name: 'Jefferson' , first_name: 'Thomas', t_number: 'T00000011' }
        end
        assert_redirected_to user_path(assigns(:user))
      end
    end
    context "updating an user" do
      should "succeed" do
        put :update, id: @user, user: { last_name: @user.last_name, t_number: @user.t_number }
        assert_redirected_to user_path(assigns(:user))
      end
    end
    context "destroying an user" do
      should "succeed" do
        assert_difference('User.count', -1) do
          delete :destroy, id: @user
        end
        assert_redirected_to users_path
      end
    end
  end
end
