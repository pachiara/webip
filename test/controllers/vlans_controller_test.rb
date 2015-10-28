require 'test_helper'

class VlansControllerTest < ActionController::TestCase
  setup do
    @vlan = vlans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vlans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vlan" do
    assert_difference('Vlan.count') do
      post :create, vlan: { description: @vlan.description, dns: @vlan.dns, gateway: @vlan.gateway, host_max: @vlan.host_max, host_min: @vlan.host_min, hosts_num: @vlan.hosts_num, netmask: @vlan.netmask, network: @vlan.network, vlan_code: @vlan.vlan_code }
    end

    assert_redirected_to vlan_path(assigns(:vlan))
  end

  test "should show vlan" do
    get :show, id: @vlan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vlan
    assert_response :success
  end

  test "should update vlan" do
    put :update, id: @vlan, vlan: { description: @vlan.description, dns: @vlan.dns, gateway: @vlan.gateway, host_max: @vlan.host_max, host_min: @vlan.host_min, hosts_num: @vlan.hosts_num, netmask: @vlan.netmask, network: @vlan.network, vlan_code: @vlan.vlan_code }
    assert_redirected_to vlan_path(assigns(:vlan))
  end

  test "should destroy vlan" do
    assert_difference('Vlan.count', -1) do
      delete :destroy, id: @vlan
    end

    assert_redirected_to vlans_path
  end
end
