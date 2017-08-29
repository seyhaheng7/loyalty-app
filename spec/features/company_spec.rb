feature 'Company' do
  given!(:user)    { create(:user) }
  given!(:company){ create(:company) }
  
  let!(:category) do
    create(:category, name: 'test')
  end
  
  before do
    login_as user, scope: :user
  end
  feature 'Listing' do
    scenario 'see all company' do
      visit root_path
      click_link 'Companies'
      expect(page).to have_content(company.name)
    end
  end

  feature 'Create' do
    scenario 'Create Successfully' do
      visit companies_path
      click_link 'New Company'
      fill_in 'Name', with: 'Codingate'
      fill_in 'Address', with: 'Phnom Penh'
      select 'test', from: 'Category'      
      click_on 'Create Company'
      expect(page).to have_content 'Company was successfully created.'
    end

    scenario 'Create Unsuccessful' do
      visit new_category_path
      click_on 'Create Category'
      expect(page).to have_content 'can\'t be blank'
    end
  end


  feature 'Update' do
    scenario 'Update Successfully' do
      visit companies_path
      find("a[href='#{edit_company_path(company)}']").click
      fill_in 'Name', with: 'Codingate'
      click_on 'Update Company'
      expect(page).to have_content 'Company was successfully updated.'
    end

    scenario 'Update Unsuccessful' do
      visit edit_company_path(company)
      fill_in 'Name', with: ''
      click_on 'Update Company'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Show' do
    scenario 'Show company' do
      visit company_path(company)
      expect(page).to have_content(company.name)
    end
  end

  feature 'Destroy' do
    scenario 'Destroy Successfully' do
      visit company_path(company)
      click_link 'Delete'
      expect(page).to have_content 'Company was successfully destroyed.'
    end
  end
end
