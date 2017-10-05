class RewardsGrid
  include Datagrid

  scope do
    Reward
  end

	filter(:name, :string)
	filter(:store_id, :enum, :select => lambda {Store.pluck(:name, :id)})
	filter(:quantity, :integer, range: true)
  filter(:require_points, :integer, range: true)
	filter(:price, :integer, rangenge: true)
	filter(:reward_id, :enum, select: ["available", "unvailable"])

  column(:name)
  column(:image, html: true) do |reward|
    image_tag reward.image, size: '30x30'
  end
  column(:require_points)
  column(:quantity)
  column(:store_name)
  column(:actions, html:true) do |reward|
    render 'rewards/control', reward: reward
  end
end
