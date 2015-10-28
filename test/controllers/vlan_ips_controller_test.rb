require 'test_helper'

class VlanIpsControllerTest < ActionController::TestCase
  setup do
    @vlan_ip = vlan_ips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vlan_ips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vlan_ip" do
    assert_difference('VlanIp.count') do
      post :create, vlan_ip: { hostname: @vlan_ip.hostname, ip: @vlan_ip.ip, note: @vlan_ip.note, status: @vlan_ip.status, vlan_id: @vlan_ip.vlan_id }
    end

    assert_redirected_to vlan_ip_path(assigns(:vlan_ip))
  end

  test "should show vlan_ip" do
    get :show, id: @vlan_ip
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vlan_ip
    assert_response :success
  end

  test "should update vlan_ip" do
    put :update, id: @vlan_ip, vlan_ip: { hostname: @vlan_ip.hostname, ip: @vlan_ip.ip, note: @vlan_ip.note, status: @vlan_ip.status, vlan_id: @vlan_ip.vlan_id }
    assert_redirected_to vlan_ip_path(assigns(:vlan_ip))
  end

  test "should destroy vlan_ip" do
    assert_difference('VlanIp.count', -1) do
      delete :destroy, id: @vlan_ip
    end

    assert_redirected_to vlan_ips_path
  end
end
