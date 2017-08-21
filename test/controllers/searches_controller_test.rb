require 'test_helper'

class SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get song" do
    get searches_song_url
    assert_response :success
  end

end
