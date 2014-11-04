class Restaurant < ActiveRecord::Base

	has_many :reviews, dependent: :destroy

	validates :name, length: {minimum: 3}, uniqueness: true
	
	def average_rating
<<<<<<< HEAD
	    return 'N/A' if reviews.none?
	    reviews.inject(0) {|memo, review| memo + review.rating} / reviews.count
=======
    'N/A'
>>>>>>> f441f0c3a36be69c8548d5b0e9b10c549fbec88e
	end
	
end
