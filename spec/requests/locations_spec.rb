xdescribe "Locations" do
  describe "GET /locations" do
    let!(:user)    { create(:user) }

    it "works! (now write some real specs)" do
      get locations_path, user.create_new_auth_token
      expect(response).to have_http_status(200)
    end
  end
end
