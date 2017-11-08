every 3.hours do
  runner "Promotion.push_daily_promotion"
end

every 1.day, :at => '8:30 am' do
  runner "ClaimedReward.notify_expired"
end
