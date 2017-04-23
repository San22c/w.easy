require 'test_helper'

class EstandarsControllerTest < ActionController::TestCase
  setup do
    @estandar = estandars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:estandars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create estandar" do
    assert_difference('Estandar.count') do
      post :create, estandar: { descripcion: @estandar.descripcion, fecha_crea: @estandar.fecha_crea, tipo: @estandar.tipo }
    end

    assert_redirected_to estandar_path(assigns(:estandar))
  end

  test "should show estandar" do
    get :show, id: @estandar
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @estandar
    assert_response :success
  end

  test "should update estandar" do
    patch :update, id: @estandar, estandar: { descripcion: @estandar.descripcion, fecha_crea: @estandar.fecha_crea, tipo: @estandar.tipo }
    assert_redirected_to estandar_path(assigns(:estandar))
  end

  test "should destroy estandar" do
    assert_difference('Estandar.count', -1) do
      delete :destroy, id: @estandar
    end

    assert_redirected_to estandars_path
  end
end
