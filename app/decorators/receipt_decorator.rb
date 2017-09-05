class ReceiptDecorator < Draper::Decorator
  delegate_all

  def manage_receipt
    if model.managed_by_id.present?
      managed_by
    else
      'Not Yet Approved or Rejected!'
    end
  end

  def managed_by
    if model.approved?
      'Approved By ' + model.managed_by.name
    else
      'Rejected By ' + model.managed_by.name
    end
  end

end
