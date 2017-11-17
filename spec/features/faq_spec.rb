feature 'Faq' do

  given!(:user){ create(:user) }
  given!(:faq){ create(:faq) }

  before do
    login_as user, scope: :user
  end

  feature 'Listing' do
    scenario 'see all faq' do
      visit root_path
      click_link 'FAQ'
      expect(page).to have_content(faq.title)
    end
  end

  feature 'Create' do
    scenario 'create faq successfully' do
      visit faqs_path
      click_link 'Add New FAQ'
      fill_in 'Title', with: 'Question1'
      fill_in 'Content', with: 'Question1 content'
      click_on 'Create FAQ'
      expect(page).to have_content 'Faq was successfully created.'
    end

    scenario 'create faq unsuccessfully' do
      visit faqs_path
      click_link 'Add New FAQ'
      fill_in 'Title', with: ''
      fill_in 'Content', with: ''
      click_on 'Create FAQ'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Update' do
    scenario 'update faq successfully' do
      visit faqs_path
      find("a[href='#{edit_faq_path(faq)}']").click
      fill_in 'Title', with: 'Title'
      fill_in 'Content', with: 'Content'
      click_on 'Update FAQ'
      expect(page).to have_content 'Faq was successfully updated.'
    end

    scenario 'update faq unsuccessfully' do
      visit faqs_path
      find("a[href='#{edit_faq_path(faq)}']").click
      fill_in 'Title', with: ''
      fill_in 'Content', with: ''
      click_on 'Update FAQ'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Show' do
    scenario 'show faq detail' do
      visit faq_path(faq)
      expect(page).to have_content(faq.title)
    end
  end

  feature 'Destroy' do
    scenario 'delete faq' do
      visit faqs_path
      click_link 'Delete'
      expect(page).to have_content 'Faq was successfully deleted.'
    end
  end


end