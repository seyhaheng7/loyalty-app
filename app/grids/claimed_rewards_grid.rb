class ClaimedRewardsGrid

  include Datagrid

  scope do
    ClaimedReward.includes(:customer, :reward)
  end

  filter(:reward_name, :string) { |value, scope| scope.reward_name_like(value) }
  filter(:customer_name, :string) { |value, scope| scope.customer_name_like(value) }
  filter(:status, :enum, select: ClaimedReward.aasm.states.map(&:name))
  filter(:created_at, :date, range: true)


  column(:reward, html:true) do |record|
    link_to record.reward_name, record.reward
  end

  column(:customer, html:true) do |record|
    link_to record.customer_name, record.customer
  end

  column(:status)
  column(:created_at, header: 'Claimed Date') do |model|
    model.created_at.to_date
  end
  column(:actions, html:true) do |record|
    render 'claimed_rewards/control', claimed_reward: record
  end
end
