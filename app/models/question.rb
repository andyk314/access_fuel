class Question < ActiveRecord::Base
	belongs_to :user_id
	has_and_belongs_to_many :answers
	belongs_to :event_id
	accepts_nested_attributes_for :answers, allow_destroy: true
end
