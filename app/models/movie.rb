class Movie < ActiveRecord::Base

	has_many :reviews
	validates_presence_of :title
	validates_presence_of :director
	validates_presence_of :description
	validates_presence_of :release_date
	# validates_presence_of :poster_image_url
	validates :runtime_in_minutes, numericality: { only_integer: true }
	validate :release_date_is_in_the_past
	mount_uploader :avatar, AvatarUploader

      def review_average
        reviews.sum(:rating_out_of_ten)/1
      end

	protected

	def release_date_is_in_the_past
		if release_date.present?
			errors.add(:release_date, "should be in the past") if release_date > Date.today
		end
	end
	
end