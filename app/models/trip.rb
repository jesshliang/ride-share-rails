class Trip < ApplicationRecord
	belongs_to :driver
	belongs_to :passenger

	# validates :date, :cost, presence: true
	validates :driver_id, presence: true
  validates :passenger_id, presence: true
  validates :date, presence: true
  validates :cost, presence: true
	validates :rating, numericality: { only_integer: true, greater_than: -1, less_than: 6 }

	def completed?
		self.completion = !self.completion
		self.save
	end
end
