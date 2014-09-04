class Question < ActiveRecord::Base
	 #fields id | user_id | event_id | question | attributes | created_at | updated_at
   belongs_to :user
   belongs_to :event

   has_many :answers

   
   
   accepts_nested_attributes_for :answers

   after_save { |question| question.destroy if question.poll.blank? }
end
