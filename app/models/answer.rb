class Answer < ActiveRecord::Base
	has_one :user_id
	has_one :question_id
	accepts_nested_attributes_for :question_id, allow_destroy: true
end
	