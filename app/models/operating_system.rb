class OperatingSystem < ApplicationRecord
  belongs_to :customer

  NAMES = ['Android', 'iOS']
end
