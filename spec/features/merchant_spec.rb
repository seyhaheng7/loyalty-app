feature 'Merchant' do
  given!(:user){ create(:user) }
  given!(:merchant){ create(:merchant) }
  given!(:store){create(:store, name: 'test')}
  before do
    login_as user, scope: :user
  end

  feature 'Listing' do
    scenario 'see all merchant' do
      visit root_path
      click_link 'Merchants'
      expect(page).to have_content(user.name)
    end
  end

  feature 'Create' do
    scenario 'Create Successfully' do
      visit merchants_path
      click_link 'New Merchant'
      fill_in 'Name', with: 'Codingate'
      fill_in 'Email', with: 'bunutu1@gmail.com'
      select 'test', from: 'Store'
      fill_in 'Phone', with: '14567890'
      fill_in 'Password', with: 'Ubuntu1234!'
      click_on 'Create Merchant'

      expect(page).to have_content 'Merchant was successfully created.'
    end

    scenario 'Create Unsuccessful' do
      visit new_merchant_path
      click_on 'Create Merchant'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Update' do
    scenario 'Update Successfully' do
      visit merchants_path
      find("a[href='#{edit_merchant_path(merchant)}']").click
      fill_in 'Name', with: 'Codingate'
      click_on 'Update Merchant'
      expect(page).to have_content 'Merchant was successfully updated.'
    end

    scenario 'Update Unsuccessful' do
      visit edit_merchant_path(merchant)
      fill_in 'Name', with: ''
      click_on 'Update Merchant'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Show' do
    scenario 'Show merchant' do
      visit merchant_path(merchant)
      expect(page).to have_content(merchant.name)
    end
  end

  feature 'Destroy' do
    scenario 'Destroy Successfully' do
      visit merchant_path(merchant)
      click_link 'Delete'
      expect(page).to have_content 'Merchant was successfully deleted.'
    end
  end
end
