require "application_system_test_case"

class ResourceLinksTest < ApplicationSystemTestCase
  setup do
    @resource_link = resource_links(:one)
  end

  test "visiting the index" do
    visit resource_links_url
    assert_selector "h1", text: "Resource links"
  end

  test "should create resource link" do
    visit resource_links_url
    click_on "New resource link"

    fill_in "Link", with: @resource_link.link
    fill_in "Title", with: @resource_link.title
    click_on "Create Resource link"

    assert_text "Resource link was successfully created"
    click_on "Back"
  end

  test "should update Resource link" do
    visit resource_link_url(@resource_link)
    click_on "Edit this resource link", match: :first

    fill_in "Link", with: @resource_link.link
    fill_in "Title", with: @resource_link.title
    click_on "Update Resource link"

    assert_text "Resource link was successfully updated"
    click_on "Back"
  end

  test "should destroy Resource link" do
    visit resource_link_url(@resource_link)
    click_on "Destroy this resource link", match: :first

    assert_text "Resource link was successfully destroyed"
  end
end
