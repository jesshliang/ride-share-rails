class Driver < ApplicationRecord
	has_many :trips

	validates :name, presence: true
	validates :vin, presence: true
	
	def average_rating
    if self.trips.empty?
      average = nil
    else
      total_rating = 0
      counter = 0
      self.trips.each do |trip|
        total_rating += trip.rating
        counter += 1
      end
      average = (total_rating / counter)
    end
    return average
  end
end
