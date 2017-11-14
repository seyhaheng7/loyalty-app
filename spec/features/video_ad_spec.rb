feature 'Video ad' do
  given!(:user)    { create(:user) }
  given!(:video_ad){create(:video_ad)}

  before do
    login_as user, scope: :user
  end

  feature 'Listing' do
    scenario 'see all video' do
      visit root_path
      click_link 'Watch & Earn'
      expect(page).to have_content(video_ad.title)
    end
  end

  feature 'Create' do
    scenario 'video_ad successfully' do
      visit video_ads_path
      click_link 'Add New Video'
      fill_in 'Title', with: 'Video'
      attach_file('video_ad[video_file]', "#{Rails.root}/spec/support/mov_bbb.mp4")
      attach_file('video_ad[thumbnail]', "#{Rails.root}/spec/support/default.png")

      click_on 'Create Video'
      expect(page).to have_content 'Video was successfully created'
    end

    scenario 'video_ad unsuccessful' do
      visit new_video_ad_path
      click_on 'Create Video'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Update' do
    scenario 'video_ad Successfully' do
      visit video_ads_path
      find("a[href='#{edit_video_ad_path(video_ad)}']").click
      fill_in 'Title', with: 'Video'
      click_on 'Update Video'
      expect(page).to have_content 'Video was successfully updated.'
    end

    scenario 'Update Unsuccessful' do
      visit edit_video_ad_path(video_ad)
      fill_in 'Title', with: ''
      click_on 'Update Video'
      expect(page).to have_content 'can\'t be blank'
    end
  end

  feature 'Show' do
    scenario 'details of video_ad' do
      visit video_ad_path(video_ad)
      expect(page).to have_content (video_ad.title)
    end
  end

  feature 'Destroy' do
    scenario 'video_ad Successfully' do
      visit video_ads_path
      click_link 'Delete'
      expect(page).to have_content 'Video was successfully deleted.'
    end
  end

end
