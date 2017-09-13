xfeature 'Sticker' do
  given!(:user)    { create(:user) }
  given!(:sticker) { create(:sticker) }

  let!(:sticker_group) do
    create(:sticker_group, name: 'test')
  end

  before do
    login_as user, scope: :user
  end

  feature 'Listing' do
    scenario 'see all stickers' do
      visit root_path
      click_link 'Stickers'
      expect(page).to have_content(sticker.name)
    end
  end

  feature 'Create' do
    scenario 'Create Successfully' do
      visit stickers_path
      click_link 'New Sticker'
      fill_in 'Name', with: 'Happies Logo'
      attach_file('sticker[image]', File.join(Rails.root, 'spec/support/default.png'))
      select 'test', from: 'Sticker group'
      click_on 'Create Sticker'
      expect(page).to have_content 'Sticker was successfully created'
    end

    scenario 'Create Unsuccessful' do
      visit new_sticker_path
      click_on 'Create Sticker'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Update' do
    scenario 'Update Successfully' do
      visit stickers_path
      find("a[href='#{edit_sticker_path(sticker)}']").click
      fill_in 'Name', with: 'Smile'
      click_on 'Update Sticker'
      expect(page).to have_content 'Sticker was successfully updated'
    end

    scenario 'Update Unsuccessful' do
      visit edit_sticker_path(sticker)
      fill_in 'Name', with: ''
      click_on 'Update Sticker'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Show' do
    scenario 'Show sticker detail' do
      visit sticker_path(sticker)
      expect(page).to have_content(sticker.name)
    end
  end

  feature 'Destroy' do
    scenario 'Destroy Successfully' do
      visit sticker_path(sticker)
      click_link 'Delete'
      expect(page).to have_content 'Sticker was successfully deleted.'
    end
  end

end







