class Answer < ActiveRecord::Base
   #fields id | user_id | question_id | other | attributes | created_at | updated _at
   belongs_to :user
   belongs_to :question


   
   

end
	