feature "User" do
  given!(:user){ create(:user) }
  given!(:user1){ create(:user) }

  before do
    login_as user, scope: :user 
  end

  scenario "Admin creates a new user" do
    visit new_user_path
    fill_in "Name", :with => "Janedoe"
    fill_in "Email", :with => "janedoe@gmail.com"
    fill_in "Password", :with => "Janedoe007"
    click_on "Create User"

    expect(page).to have_content("User was successfully created")
  end

  scenario "Admin edit user"  do
    
    visit edit_user_path(user1)
    
    fill_in "Name", :with => "Janedoe"
    fill_in "Email", :with => "janedoe@gmail.com"
    fill_in "Password", :with => "Janedoe007"
    click_button "Update User"

    expect(page).to have_content("User was successfully updated.")

  end

  scenario "Admin deletes user" do
    visit users_path
    find("a[href='#{user_path(user1)}'][data-method='delete']").click
    expect(page).to have_content 'User was successfully destroyed.'
  end

end