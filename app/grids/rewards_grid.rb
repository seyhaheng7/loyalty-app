class RewardsGrid
  include Datagrid

  scope do
    Reward
  end

  filter(:name, :string)
  filter(:store, :string)

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
