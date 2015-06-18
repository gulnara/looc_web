require 'mongo'
require 'mongo_mapper'

class Data
	include MongoMapper::Document

	key :pic_name, String, required: true
	key :main_categories, Array, required: true
  key :sub_categories, Array, required: true
  key :pic_url, String, required: true
  key :pic_question_id, Integer, required: true
  key :question0, Hash, required: true
  key :question1, Hash, required: true
  key :question2, Hash, required: true
  key :question3, Hash, required: true
  key :question4, Hash, required: true
  timestamps!

end
