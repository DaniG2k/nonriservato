require 'test_helper'

class ExternalOrganizationsControllerTest < ActionController::TestCase
  setup do
    @external_organization = external_organizations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:external_organizations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create external_organization" do
    assert_difference('ExternalOrganization.count') do
      post :create, external_organization: { name: @external_organization.name }
    end

    assert_redirected_to external_organization_path(assigns(:external_organization))
  end

  test "should show external_organization" do
    get :show, id: @external_organization
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @external_organization
    assert_response :success
  end

  test "should update external_organization" do
    put :update, id: @external_organization, external_organization: { name: @external_organization.name }
    assert_redirected_to external_organization_path(assigns(:external_organization))
  end

  test "should destroy external_organization" do
    assert_difference('ExternalOrganization.count', -1) do
      delete :destroy, id: @external_organization
    end

    assert_redirected_to external_organizations_path
  end
end
