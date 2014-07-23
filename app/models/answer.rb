class Answer < ActiveRecord::Base
	has_one :user
	has_one :question
end
