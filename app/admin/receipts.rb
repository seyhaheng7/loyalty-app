ActiveAdmin.register Receipt do

 active_admin_paranoia
# or

  config.clear_action_items!
  actions :all, except: [:new, :edit, :update, :create]

  index do
    column :capture do |img|
      image_tag img.capture,size: "150x100"
    end
    column :status
    column :earned_point
    column :total
    column :customer
    column :store
    column :managed_by

    actions do |receipt|
      if receipt.deleted?
        link_to 'Destroy!', { action: :really_destroy, id: receipt.id }, class: "edit_link member_link", :method => :delete, data: { confirm: 'Are You Sure to Delete?' }
      end
    end
  end


  member_action :really_destroy, method: :delete do
    resource.really_destroy!
    redirect_to collection_path, notice: "destroy from database"
  end


end
