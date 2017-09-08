class RewardsGrid 
  include Datagrid

  scope do
    Reward
  end

  filter(:name, :string)
  filter(:company, :string)

  column(:name)
  column(:image, html: true) do |reward|
    image_tag reward.image, size: '150x150'
  end
  column(:require_points)
  column(:quantity)
  column(:company_name)
  
  column(:actions, html:true) do |reward|
    render 'rewards/control', reward: reward
  end 
end
