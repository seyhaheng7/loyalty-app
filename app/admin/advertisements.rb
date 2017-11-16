ActiveAdmin.register Advertisement do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
  active_admin_paranoia
# or

  config.clear_action_items!
  actions :all, except: [:new, :edit, :update, :create]

  index do
    column :name
    column :banner do |img|
      image_tag img.banner,size: "150x100"
    end
    column :active
    column :for_page
    column :start_date
    column :end_date
    column :price
    column :view
    actions do |advertisement|
      if advertisement.deleted?
        link_to 'Destroy!', { action: :really_destroy, id: advertisement.id }, :method => :delete, data: { confirm: 'Are You Sure to Delete?' }
      end
    end
  end


  member_action :really_destroy, method: :delete do
    resource.really_destroy!
    redirect_to collection_path, notice: "destroy from database"
  end
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
