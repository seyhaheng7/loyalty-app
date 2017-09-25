feature 'Cotact Form' do
  given!(:user)    { create(:user) }
  given!(:customer)    { create(:customer) }
  given!(:contact_form){ create(:contact_form, customer_id: customer.id) }

  before do
    login_as user, scope: :user
  end

  feature 'Listing' do
    scenario 'see all contact forms' do
      visit root_path
      click_link 'Contact Forms'
      expect(page).to have_content(contact_form.subject)
    end
  end

  feature 'Show' do
    scenario 'Show contact form' do
      visit contact_form_path(contact_form)
      expect(page).to have_content(contact_form.subject)
    end
  end

  feature 'Destroy' do
    scenario 'Destroy Successfully' do
      visit contact_form_path(contact_form)
      click_link 'Delete'
      expect(page).to have_content 'Contact Form was successfully deleted.'
    end
  end
  
end