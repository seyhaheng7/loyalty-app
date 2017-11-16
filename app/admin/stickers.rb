ActiveAdmin.register Sticker do

  active_admin_paranoia
# or
  config.clear_action_items!
  actions :all, except: [:new, :edit, :update, :create]

  index do
    column :name
    column :image do |img|
      image_tag img.image,size: "150x100"
    end

    column :sticker_group

    actions do |sticker|
      if sticker.deleted?
        link_to 'Destroy!', { action: :really_destroy, id: sticker.id }, class: "edit_link member_link", :method => :delete, data: { confirm: 'Are You Sure to Delete?' }
      end
    end
  end

  member_action :really_destroy, method: :delete do
    resource.really_destroy!
    redirect_to collection_path, notice: "destroy from database"
  end

end
