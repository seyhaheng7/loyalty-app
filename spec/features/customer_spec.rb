feature 'Customer' do
  given!(:user){ create(:user) }
  given!(:customer){ create(:customer, first_name: 'Jonh', last_name: 'Wick') }

  before do
    login_as user, scope: :user
  end

  feature 'Listing' do
    scenario 'see all customer' do
      visit root_path
      click_link 'Customers'
      expect(page).to have_content(user.name)
    end
  end

  feature 'Create' do
    scenario 'Create Successfully' do
      visit customers_path
      click_link 'New Customer'
      fill_in 'First name', with: 'Codingate'
      fill_in 'Last name', with: 'Google'
      fill_in 'Email', with: 'bunutu1@gmail.com'
      fill_in 'Phone', with: '14567890'
      fill_in 'Password', with: 'Ubuntu1234!'
      click_on 'Create Customer'

      expect(page).to have_content 'Customer was successfully created.'
    end

    scenario 'Create Unsuccessful' do
      visit new_customer_path
      click_on 'Create Customer'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Update' do
    scenario 'Update Successfully' do
      visit customers_path
      find("a[href='#{edit_customer_path(customer)}']").click
      fill_in 'First name', with: 'Codingate'
      fill_in 'Last name', with: 'Codingate'
      fill_in 'Password', with: 'Ubuntu1234!'
      click_on 'Update Customer'
      expect(page).to have_content 'Customer was successfully updated.'
    end

    scenario 'Update Unsuccessful' do
      visit edit_customer_path(customer)
      fill_in 'First name', with: ''
      click_on 'Update Customer'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Show' do
    scenario 'Show customer' do
      visit customer_path(customer)
      expect(page).to have_content(customer.name)
    end
  end

  feature 'Destroy' do
    scenario 'Destroy Successfully' do
      visit customer_path(customer)
      click_link 'Delete'
      expect(page).to have_content 'Customer was successfully deleted.'
    end
  end
end
