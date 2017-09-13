xfeature 'StickerGroup' do
  given!(:user)    { create(:user) }
  given!(:sticker_group) { create(:sticker_group) }

  before do
    login_as user, scope: :user
  end

  feature 'Listing' do
    scenario 'see all sticker_groups' do
      visit root_path
      click_link 'StickerGroups'
      expect(page).to have_content(sticker_group.name)
    end
  end

  feature 'Create' do
    scenario 'Create Successfully' do
      visit sticker_groups_path
      click_link 'New StickerGroup'
      fill_in 'Name', with: 'Happies Logo'
      attach_file('sticker_group[image]', File.join(Rails.root, 'spec/support/default.png'))
      click_on 'Create Sticker'
      expect(page).to have_content 'StickerGroup was successfully created'
    end

    scenario 'Create Unsuccessful' do
      visit new_sticker_group_path
      click_on 'Create Sticker group'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Update' do
    scenario 'Update Successfully' do
      visit sticker_groups_path
      find("a[href='#{edit_sticker_group_path(sticker_group)}']").click
      fill_in 'Name', with: 'Smile'
      click_on 'Update Sticker group'
      expect(page).to have_content 'StickerGroup was successfully updated'
    end

    scenario 'Update Unsuccessful' do
      visit edit_sticker_group_path(sticker_group)
      fill_in 'Name', with: ''
      click_on 'Update Sticker group'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Show' do
    scenario 'Show sticker_group detail' do
      visit sticker_group_path(sticker_group)
      expect(page).to have_content(sticker_group.name)
    end
  end

  feature 'Destroy' do
    scenario 'Destroy Successfully' do
      visit sticker_group_path(sticker_group)
      click_link 'Delete'
      expect(page).to have_content 'StickerGroup was successfully deleted.'
    end
  end

end







