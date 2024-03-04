require "test_helper"

class ResourceLinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @resource_link = resource_links(:one)
  end

  test "should get index" do
    get resource_links_url
    assert_response :success
  end

  test "should get new" do
    get new_resource_link_url
    assert_response :success
  end

  test "should create resource_link" do
    assert_difference("ResourceLink.count") do
      post resource_links_url, params: { resource_link: { link: @resource_link.link, title: @resource_link.title } }
    end

    assert_redirected_to resource_link_url(ResourceLink.last)
  end

  test "should show resource_link" do
    get resource_link_url(@resource_link)
    assert_response :success
  end

  test "should get edit" do
    get edit_resource_link_url(@resource_link)
    assert_response :success
  end

  test "should update resource_link" do
    patch resource_link_url(@resource_link), params: { resource_link: { link: @resource_link.link, title: @resource_link.title } }
    assert_redirected_to resource_link_url(@resource_link)
  end

  test "should destroy resource_link" do
    assert_difference("ResourceLink.count", -1) do
      delete resource_link_url(@resource_link)
    end

    assert_redirected_to resource_links_url
  end
end
