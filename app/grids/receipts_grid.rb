class ReceiptsGrid 
  include Datagrid

  scope do
    Receipt
  end

  filter(:receipt_id, :string)
  filter(:status, :string)

  column(:receipt_id)
  column(:status)
  column(:total)
  
  column(:actions, html:true) do |record|
    render 'receipts/control', receipt: record
  end 
end
