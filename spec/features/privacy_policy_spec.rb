feature 'Privacy Policy' do
  given!(:user)          { create(:user) }
  given!(:privacy_policy){create(:privacy_policy)}

  before do
    login_as user, scope: :user
  end

  feature 'Update' do
    scenario 'privacy_policy Successfully' do
      visit root_path
      find("a[href='#{privacy_policies_path}']").click
      fill_in 'Body', with: 'body'
      click_on 'Update Privacy policy'
      expect(page).to have_content 'Privacy policy was successfully updated.'
    end
  end

  feature 'Show' do
    scenario 'details of privacy policy' do
      visit privacy_policies_path
      expect(page).to have_content (privacy_policy.body)
    end
  end

end
