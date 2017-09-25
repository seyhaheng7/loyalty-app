class ContactFormsGrid

  include Datagrid

  scope do
    ContactForm
  end

  filter(:subject, :string)

  column(:subject)
  column(:message)
  column(:created_at) do |model|
    model.created_at.to_date
  end
end
