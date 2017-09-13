class ClaimedRewardsGrid

  include Datagrid

  scope do
    ClaimedReward
  end

  filter(:reward_name, :string)
  filter(:customer_name, :string)

  column(:id)
  column(:reward_name)
  column(:customer_name)
  column(:status)
  column(:created_at) do |model|
    model.created_at.to_date
  end
  column(:actions, html:true) do |record|
    render 'claimed_rewards/control', claimed_reward: record
  end
end
