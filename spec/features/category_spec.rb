feature 'Category' do
  given!(:user)    { create(:user) }
  given!(:category){ create(:category) }
  
  before do
    login_as user, scope: :user
  end
  
  feature 'Listing' do
    scenario 'see all category' do
      visit root_path
      click_link 'Categories'
      expect(page).to have_content(category.name)
    end
  end

  feature 'Create' do
    scenario 'Create Successfully' do
      visit categories_path
      click_link 'New Category'
      fill_in 'Name', with: 'Coffee Shop'
      click_on 'Create Category'
      expect(page).to have_content 'Category was successfully created'
    end

    scenario 'Create Unsuccessful' do
      visit new_category_path
      click_on 'Create Category'
      expect(page).to have_content 'can\'t be blank'
    end
  end


  feature 'Update' do
    scenario 'Update Successfully' do
      visit categories_path
      find("a[href='#{edit_category_path(category)}']").click
      fill_in 'Name', with: 'Coffee Shop'
      click_on 'Update Category'
      expect(page).to have_content 'Category was successfully updated'
    end

    scenario 'Update Unsuccessful' do
      visit edit_category_path(category)
      fill_in 'Name', with: ''
      click_on 'Update Category'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Show' do
    scenario 'Show category detail' do
      visit category_path(category)
      expect(page).to have_content(category.name)
    end
  end

  feature 'Destroy' do
    scenario 'Destroy Successfully' do
      visit category_path(category)
      click_link 'Delete'
      expect(page).to have_content 'Category was successfully destroyed.'
    end
  end
end
