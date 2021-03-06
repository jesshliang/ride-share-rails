class Trip < ApplicationRecord
	belongs_to :driver
	belongs_to :passenger

	validates :driver_id, presence: true
  validates :passenger_id, presence: true
  validates :date, presence: true
  validates :cost, presence: true

	def completed?
		self.completion = !self.completion

		if self.rating == '0'
			self.rating = rand(1..5)
		end
		
		self.save
	end
end
