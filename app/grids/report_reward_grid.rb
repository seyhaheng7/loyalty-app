class ReportRewardGrid
  include Datagrid

  scope do
    Reward
  end

  filter(:name, :string){ |value, scope| scope.name_like(value) }
  filter(:store_id, :enum, :select => lambda {Store.pluck(:name, :id)})
  filter(:start_date, :date)
  filter(:end_date, :date)


  column :name

  column :store_name

  column (:location) do |record|
    record.store.try(:location_name)
  end

  column :price

  column (:point) do |record|
    record.require_points
  end

  column (:quantity) do |record|
    record.quantity
  end

  column(:pending) do |record|
    record.claimed_rewards.submitted.count
  end
  column(:claimed) do |record|
    record.claimed_rewards.given.count
  end
  column(:rejected) do |record|
    record.claimed_rewards.rejected.count
  end
  column(:remain) do |record|
    record.quantity.to_i - record.claimed_rewards.given.count.to_i
  end

end
