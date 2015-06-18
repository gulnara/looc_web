require 'mongo'
require 'mongo_mapper'

class PicData
	include MongoMapper::Document

	key :pic_name, String
	key :main_categories, Array
  key :sub_categories, Array
  key :pic_url, String
  key :pic_question_id, Integer
  key :question0, Hash
  key :question1, Hash
  key :question2, Hash
  key :question3, Hash
  key :question4, Hash
  timestamps!

end
