require 'test_helper'

class BreweriesControllerTest < ActionDispatch::IntegrationTest
  test "GET /breweries returns 200 and an array" do
    get breweries_url
    assert_response :success
    body = response.parsed_body
    assert_kind_of Array, body
  end

  test "GET /breweries includes fixture breweries" do
    get breweries_url
    assert_response :success
    body = response.parsed_body
    names = body.map { |b| b["name"] }
    assert_includes names, breweries(:one).name
    assert_includes names, breweries(:two).name
  end

  test "GET /breweries/:id returns 200 and the correct brewery" do
    brewery = breweries(:one)
    get brewery_url(brewery)
    assert_response :success
    body = response.parsed_body
    assert_equal brewery.id, body["id"]
    assert_equal brewery.name, body["name"]
    assert_equal brewery.state, body["state"]
    assert_equal brewery.city, body["city"]
    assert_equal brewery.website_url, body["website_url"]
  end

  test "GET /breweries/:id with unknown id returns 404" do
    # id: 0 is always absent — Rails fixture IDs start from 980190962
    get brewery_url(id: 0)
    assert_response :not_found
  end
end
