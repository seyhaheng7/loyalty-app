feature 'Receipt' do
  given!(:admin){ create(:user) }
  given!(:customer){ create(:customer, first_name: 'Jonh',last_name: 'Wick', current_points: 10,) }
  given!(:store){create(:store, name: 'CoffeeShop')}
  given!(:receipt){ create(:receipt, customer: customer) }

  before do
    login_as admin, scope: :user
  end

  feature 'Listing' do
    scenario 'see all receipt' do
      visit root_path
      click_link 'Receipts'
      expect(page).to have_content(receipt.receipt_id)
    end
  end

  xfeature 'Create' do
    scenario 'Create Successfully' do
      visit receipts_path
      click_link 'New Receipt'
      fill_in 'Receipt ID', with: 'A112'
      fill_in 'Total', with: '15'
      attach_file('receipt[capture]', File.join(Rails.root, 'spec/support/default.png'))
      select 'CoffeeShop', :from => 'Store'
      select 'Jonh', :from => 'Customer'
      click_on 'Create Receipt'
      expect(page).to have_content 'Receipt was successfully created.'
    end

    scenario 'Create Unsuccessful' do
      visit new_receipt_path
      click_on 'Create Receipt'
      expect(page).to have_content 'Please review the problems below:'
    end
  end

  xfeature 'Update' do
    scenario 'Update Successfully' do
      visit receipts_path
      find("a[href='#{edit_receipt_path(receipt)}']").click
      fill_in 'Receipt ID', with: 'A112'
      select 'CoffeeShop', :from => 'Store'
      select 'Jonh', :from => 'Customer'
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

    scenario 'Approve Successfully' do
      visit receipt_path(receipt)
      click_on 'Approve'

      expect(receipt).to transition_from(:submitted).to(:approved).on_event(:approving)
      expect(page).to have_content 'Receipt was successfully approved.'
    end

    scenario 'Add points to receipt' do
      visit receipt_path(receipt)
      fill_in 'Earned points', with: 15
      click_on 'Approve'
      expect(page).to have_content (receipt.earned_points)
    end

    scenario 'Increase points to user' do
      visit receipt_path(receipt)
      fill_in 'Earned points', with: 10
      click_on 'Approve'
      expect(page).to have_content 'Receipt was successfully approved.'
      points = customer.current_points + 10
      customer.reload
      expect(customer).to have_attributes(current_points: points)
    end

    scenario 'Reject Successfully' do
      visit receipt_path(receipt)
      click_on 'Reject'

      expect(receipt).to transition_from(:submitted).to(:rejected).on_event(:rejecting)
      expect(page).to have_content 'Receipt was successfully rejected.'
    end

  end

  xfeature 'Destroy' do
    scenario 'Destroy Successfully' do
      visit receipt_path(receipt)
      click_link 'Delete'
      expect(page).to have_content 'Receipt was successfully deleted.'
    end
  end
end
