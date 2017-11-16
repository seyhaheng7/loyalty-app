ActiveAdmin.register Company do

  active_admin_paranoia

  config.clear_action_items!
  actions :all, except: [:new, :edit, :update, :create]

  index do
    column :name
    column :logo do |img|
      image_tag img.logo,size: "150x100"
    end
    column :category
    column :phone
    column :contact_name
    column :partner
    actions do |company|
      if company.deleted?
        link_to 'Destroy!', { action: :really_destroy, id: company.id }, class: "edit_link member_link", :method => :delete, data: { confirm: 'Are You Sure to Delete?' }
      end
    end
  end


  member_action :really_destroy, method: :delete do
    resource.really_destroy!
    redirect_to collection_path, notice: "destroy from database"
  end




end
