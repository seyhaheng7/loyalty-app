class RewardsGrid
  include Datagrid

  scope do
    Reward.includes(:store)
  end

  filter(:name, :string){ |value, scope| scope.name_like(value) }
  filter(:store_id, :enum, :select => lambda {Store.pluck(:name, :id)})
  filter(:quantity, :integer, range: true)
  filter(:require_points, :integer, range: true)
  filter(:price, :float, range: true)
  filter(:availability, :enum, include_blank: 'All', select: ["Available", "Unvailable"]) do |value, scope|
    if value == 'Available'
      scope.available
    elsif value == 'Unvailable'
      scope.unavailable
    else
      scope
    end
  end

  column(:name)
  column(:image, html: true) do |reward|
    image_tag reward.image, size: '50x50'
  end
  column(:require_points)
  column(:quantity)
  column(:store, html:true) do |reward|
    link_to reward.store_name, reward.store
  end

  column(:actions, html:true) do |reward|
    render 'rewards/control', reward: reward
  end
end
