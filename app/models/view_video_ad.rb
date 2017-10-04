class ViewVideoAd < ApplicationRecord
  belongs_to :video_ad
  belongs_to :customer

  scope :today, ->{ where(date: Date.today) }
  scope :reach_max_views, ->{ today.joins(:video_ad).where('view_video_ads.view_count >= video_ads.max_view_per_day') }

  validate :user_max_views, if: :view_count_changed?


  def increase_views!
    self.view_count += 1
    if save
      earned_points = video_ad.earned_points
      customer.add_points(earned_points)
      true
    else
      false
    end
  end

  private

  def user_max_views
    if view_count > video_ad.max_view_per_day
      errors.add(:view_count, "reach max view today")
    end
  end

end
