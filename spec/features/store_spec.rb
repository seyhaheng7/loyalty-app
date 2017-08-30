feature 'Store' do
  given!(:user)    { create(:user) }
  given!(:store){ create(:store) }

  before do
    login_as user, scope: :user
  end
  
  feature 'Listing' do
    scenario 'see all store' do
      visit root_path
      click_link 'Stores'
      expect(page).to have_content(store.name)
    end
  end

  feature 'Create' do
    scenario 'Create Successfully' do
      visit stores_path
      click_link 'Add New Store'
      fill_in 'Name', with: 'Caltax Shop'
      select 'MyString', from: 'Company'
      select 'MyString', from: 'Location'
      click_on 'Create Store'
      expect(page).to have_content 'Store was successfully created'
    end

    scenario 'Store Unsuccessful' do
      visit new_store_path
      click_on 'Create Store'
      expect(page).to have_content 'can\'t be blank'
    end
  end


  feature 'Update' do
    scenario 'Update Successfully' do
      visit stores_path
      find("a[href='#{edit_store_path(store)}']").click
      fill_in 'Name', with: 'Caltax Shop'
      click_on 'Update Store'
      expect(page).to have_content 'Store was successfully updated'
    end

    scenario 'Update Unsuccessful' do
      visit edit_store_path(store)
      fill_in 'Name', with: ''
      click_on 'Update Store'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Show' do
    scenario 'Show store detail' do
      visit store_path(store)
      expect(page).to have_content(store.name)
    end
  end

  feature 'Destroy' do
    scenario 'Destroy Successfully' do
      visit store_path(store)
      click_link 'Delete'
      expect(page).to have_content 'Store was successfully deleted.'
    end
  end
end
