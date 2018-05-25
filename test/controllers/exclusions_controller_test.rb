# frozen_string_literal: true

require 'test_helper'

class ExclusionsControllerTest < ActionController::TestCase
  setup do
    @exclusion = exclusions(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:exclusions)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create exclusion' do
    assert_difference('Exclusion.count') do
      post :create, exclusion: {}
    end

    assert_redirected_to exclusion_path(assigns(:exclusion))
  end

  test 'should show exclusion' do
    get :show, id: @exclusion
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @exclusion
    assert_response :success
  end

  test 'should update exclusion' do
    patch :update, id: @exclusion, exclusion: {}
    assert_redirected_to exclusion_path(assigns(:exclusion))
  end

  test 'should destroy exclusion' do
    assert_difference('Exclusion.count', -1) do
      delete :destroy, id: @exclusion
    end

    assert_redirected_to exclusions_path
  end
end
