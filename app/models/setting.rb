# RailsSettings Model
class Setting < RailsSettings::Base
  source Rails.root.join("config/app.yml")
  namespace Rails.env

  validates :value, presence: true
  validates :value, numericality: { only_integer: true }, if: :rating?

  def rating?
    var == 'rating'
  end

end
