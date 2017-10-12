class ReceiptsGrid
  include Datagrid

  scope do
    Receipt.includes(:customer, :store)
  end

  filter(:receipt_id, :string)
  filter(:status, :enum, select: Receipt.aasm.states.map(&:name))
  filter(:store_id, :enum,
   :select => lambda {Store.pluck(:name, :id)})
  filter(:customer_id, :enum,
   :select => lambda {Customer.all.map {|p| [p.name, p.id]}})

  filter(:total, :integer, range: true)
  filter(:earn_points, :integer, range: true)
  filter(:managed_by_id, :enum, :select => lambda {User.all.map {|p| [p.name, p.id]}})

  column(:receipt_id)
  column(:status)
  column(:total)

  column(:store_name, html: true) do |record|
    link_to record.store_name, record.store
  end
  column(:customer_name, html: true) do |record|
    link_to record.customer_name, record.customer
  end

  column(:actions, html:true) do |record|
    render 'receipts/control', receipt: record
  end
end
