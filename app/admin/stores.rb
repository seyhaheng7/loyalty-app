ActiveAdmin.register Store do

  active_admin_paranoia
# or
  config.clear_action_items!
  actions :all, except: [:new, :edit, :update, :create]

  index do
    column :name
    column :address
    column :phone
    column :company
    column :location
    column :website
    column :email

    actions do |reward|
      if reward.deleted?
        link_to 'Destroy!', { action: :really_destroy, id: reward.id }, class: "edit_link member_link", :method => :delete, data: { confirm: 'Are You Sure to Delete?' }
      end
    end
  end

  member_action :really_destroy, method: :delete do
    resource.really_destroy!
    redirect_to collection_path, notice: "destroy from database"
  end

end
