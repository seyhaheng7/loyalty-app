feature 'Guide' do
  given!(:user)    { create(:user) }
  given!(:guide){create(:guide)}

  before do
    login_as user, scope: :user
  end

  feature 'Listing' do
    scenario 'see all guide' do
      visit root_path
      click_link 'Snap & Earn Guide'
      expect(page).to have_content(guide.title)
    end
  end

  feature 'Create' do
    scenario 'guide successfully' do
      visit guides_path
      click_link 'Add New Guide'
      fill_in 'Title', with: 'Video'
      click_on 'Create Guide'
      expect(page).to have_content 'Guide was successfully created'
    end

    scenario 'guide unsuccessful' do
      visit new_guide_path
      click_on 'Create Guide'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Update' do
    scenario 'guide Successfully' do
      visit guides_path
      find("a[href='#{edit_guide_path(guide)}']").click
      fill_in 'Title', with: 'Video'
      click_on 'Update Guide'
      expect(page).to have_content 'Guide was successfully updated.'
    end

    scenario 'Update Unsuccessful' do
      visit edit_guide_path(guide)
      fill_in 'Title', with: ''
      click_on 'Update Guide'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Show' do
    scenario 'details of guide' do
      visit guide_path(guide)
      expect(page).to have_content (guide.title)
    end    
  end

  feature 'Destroy' do
    scenario 'guide Successfully' do
      visit guides_path
      click_link 'Delete'
      expect(page).to have_content 'Guide was successfully deleted.'
    end
  end

end