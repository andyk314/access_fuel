class Answer < ActiveRecord::Base
	has_one :user_id
	has_one :question_id
end
	