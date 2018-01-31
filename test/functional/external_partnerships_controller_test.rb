require 'test_helper'

class ExternalPartnershipsControllerTest < ActionController::TestCase
  setup do
    @external_partnership = external_partnerships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:external_partnerships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create external_partnership" do
    assert_difference('ExternalPartnership.count') do
      post :create, external_partnership: { external_organization_id: @external_partnership.external_organization_id, organization_id: @external_partnership.organization_id }
    end

    assert_redirected_to external_partnership_path(assigns(:external_partnership))
  end

  test "should show external_partnership" do
    get :show, id: @external_partnership
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @external_partnership
    assert_response :success
  end

  test "should update external_partnership" do
    put :update, id: @external_partnership, external_partnership: { external_organization_id: @external_partnership.external_organization_id, organization_id: @external_partnership.organization_id }
    assert_redirected_to external_partnership_path(assigns(:external_partnership))
  end

  test "should destroy external_partnership" do
    assert_difference('ExternalPartnership.count', -1) do
      delete :destroy, id: @external_partnership
    end

    assert_redirected_to external_partnerships_path
  end
end
