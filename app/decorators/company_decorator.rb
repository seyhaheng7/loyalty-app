class CompanyDecorator < ApplicationDecorator
  delegate_all

  def partner_status
    partner? ? 'Yes' : 'No'
  end
end
