feature 'Receipt' do
  given!(:user)    { create(:user, name: 'test') }
  given!(:receipt){ create(:receipt) }
  given!(:store){create(:store, name: 'test')}
  
  before do
    login_as user, scope: :user
  end
  
  feature 'Listing' do
    scenario 'see all receipt' do
      visit root_path
      click_link 'Receipts'
      expect(page).to have_content(receipt.receipt_id)
    end
  end

  feature 'Create' do
    scenario 'Create Successfully' do
      visit receipts_path
      click_link 'New Receipt'
      fill_in 'Receipt ID', with: 'Coffee Shop'
      fill_in 'Total', with: '15'
      attach_file('receipt[capture]', File.join(Rails.root, 'spec/support/default.png'))
      select 'test', :from => 'Store'
      select 'test', :from => 'User'
      click_on 'Create Receipt'
      expect(page).to have_content 'Receipt was successfully created.'
    end

    scenario 'Create Unsuccessful' do
      visit new_receipt_path
      click_on 'Create Receipt'
      expect(page).to have_content 'Please review the problems below:'
    end
  end


  feature 'Update' do
    scenario 'Update Successfully' do
      visit receipts_path
      find("a[href='#{edit_receipt_path(receipt)}']").click
      fill_in 'Receipt ID', with: 'Coffee Shop'
      select 'test', :from => 'Store'
      select 'test', :from => 'User'
      click_on 'Update Receipt'
      expect(page).to have_content 'Receipt was successfully updated.'
    end

    scenario 'Update Unsuccessful' do
      visit edit_receipt_path(receipt)
      fill_in 'Receipt ID', with: ''
      click_on 'Update Receipt'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Show' do
    scenario 'Show receipt detail' do
      visit receipt_path(receipt)
      expect(page).to have_content(receipt.receipt_id)
    end
  end

  feature 'Destroy' do
    scenario 'Destroy Successfully' do
      visit receipt_path(receipt)
      click_link 'Delete'
      expect(page).to have_content 'Receipt was successfully deleted.'
    end
  end
end
