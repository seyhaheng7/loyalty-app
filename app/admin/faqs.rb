ActiveAdmin.register Faq do

  active_admin_paranoia
# or

  config.clear_action_items!
  actions :all, except: [:new, :edit, :update, :create]

  index do
    column :title
    column :content do |content|
      content.content.html_safe
    end
    column :created_at
    actions do |faq|
      if faq.deleted?
        link_to 'Destroy!', { action: :really_destroy, id: faq.id }, class: "edit_link member_link", :method => :delete, data: { confirm: 'Are You Sure to Delete?' }
      end
    end
  end


  member_action :really_destroy, method: :delete do
    resource.really_destroy!
    redirect_to collection_path, notice: "destroy from database"
  end

end
