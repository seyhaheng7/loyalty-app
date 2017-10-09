class ContactFormsGrid

  include Datagrid

  scope do
    ContactForm
  end

  filter(:subject, :string){ |value, scope| scope.subject_like(value) }
  filter(:message, :string){ |value, scope| scope.message_like(value) }
  filter(:customer, :enum,:select => lambda {Customer.all.map {|p| [p.name, p.id]}})

  column(:customer_name)
  column(:subject)
  column(:message)
  
end
