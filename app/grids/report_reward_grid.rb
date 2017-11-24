class ReportRewardGrid
  include Datagrid

  scope do
    Reward
  end

  filter(:name, :string){ |value, scope| scope.name_like(value) }
  filter(:store_id, :enum, :select => lambda {Store.pluck(:name, :id)})
  filter(:date, :date, range: true) do |value, scope|
    start_date = value.first
    end_date  = value.second
    scope.active_between(start_date, end_date)
  end

  column :name

  column :store_name

  column (:location) do |record|
    record.store.try(:location_name)
  end

  column :price
  column :start_date
  column :end_date

  column(:require_points, header: 'Point') do |record|
    record.require_points
  end

  column(:quantity) do |record|
    record.quantity
  end

  column(:pending) do |record|
    record.claimed_rewards.submitted.count
  end
  column(:claimed_reward_expired, header: 'Expired') do |record|
    record.claimed_reward_expired
  end

  column(:claimed) do |record|
    record.claimed_rewards.given.count
  end
  column(:rejected) do |record|
    record.claimed_rewards.rejected.count
  end
  column(:remain) do |record|
    record.quantity_remain
  end

end
