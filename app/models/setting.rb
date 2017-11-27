# RailsSettings Model
class Setting < RailsSettings::Base
  source Rails.root.join("config/app.yml")
  namespace Rails.env

  validates :value, presence: true
	validate :non_zero, if: :rating?
  validates :value, numericality: { only_integer: true }, if: :rating?

  def rating?
    var == 'rating'
  end

  def non_zero
    if self.value.to_i <= 0
      self.errors.add(:value, "Field must be greater than 0")
    end
  end

end
