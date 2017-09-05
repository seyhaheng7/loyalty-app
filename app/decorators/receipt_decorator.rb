class ReceiptDecorator < Draper::Decorator
  delegate_all

  def manage_receipt
    if managed_by.present?
      managed_by_status
    else
      'Not Yet Approved or Rejected!'
    end
  end

  def managed_by_status
    if model.approved?
      'Approved By ' + managed_by.name
    else
      'Rejected By ' + managed_by.name
    end
  end

end
