require 'test_helper'

class WebdataControllerTest < ActionDispatch::IntegrationTest
  setup do
    @webdatum = webdata(:one)
  end

  test "should get index" do
    get webdata_url
    assert_response :success
  end

  test "should get new" do
    get new_webdatum_url
    assert_response :success
  end

  test "should create webdatum" do
    assert_difference('Webdatum.count') do
      post webdata_url, params: { webdatum: { url: @webdatum.url, webdata: @webdatum.webdata } }
    end

    assert_redirected_to webdatum_url(Webdatum.last)
  end

  test "should show webdatum" do
    get webdatum_url(@webdatum)
    assert_response :success
  end

  test "should get edit" do
    get edit_webdatum_url(@webdatum)
    assert_response :success
  end

  test "should update webdatum" do
    patch webdatum_url(@webdatum), params: { webdatum: { url: @webdatum.url, webdata: @webdatum.webdata } }
    assert_redirected_to webdatum_url(@webdatum)
  end

  test "should destroy webdatum" do
    assert_difference('Webdatum.count', -1) do
      delete webdatum_url(@webdatum)
    end

    assert_redirected_to webdata_url
  end
end
