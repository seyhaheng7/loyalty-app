feature 'Promotion' do
  given!(:user)    { create(:user) }
  given!(:promotion){create(:promotion)}

  before do
    login_as user, scope: :user
  end

  feature 'Listing' do
    scenario 'see all promotion' do
      visit root_path
      click_link 'Promotion'
      expect(page).to have_content(promotion.title)
    end
  end

  feature 'Create' do
    scenario 'promotion successfully' do
      visit promotions_path
      click_link 'Add New Promotion'
      fill_in 'Title', with: 'Promotion'
      click_on 'Create Promotion'
      expect(page).to have_content 'Promotion was successfully created'
    end

    scenario 'promotion unsuccessful' do
      visit new_promotion_path
      click_on 'Create Promotion'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Update' do
    scenario 'promotion Successfully' do
      visit promotions_path
      find("a[href='#{edit_promotion_path(promotion)}']").click
      fill_in 'Title', with: 'Promotion'
      click_on 'Update Promotion'
      expect(page).to have_content 'Promotion was successfully updated.'
    end

    scenario 'Update Unsuccessful' do
      visit edit_promotion_path(promotion)
      fill_in 'Title', with: ''
      click_on 'Update Promotion'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Show' do
    scenario 'details of promotion' do
      visit promotion_path(promotion)
      expect(page).to have_content (promotion.title)
    end    
  end

  feature 'Destroy' do
    scenario 'promotion Successfully' do
      visit promotions_path
      click_link 'Delete'
      expect(page).to have_content 'Promotion was successfully deleted.'
    end
  end

end