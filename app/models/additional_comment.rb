class AdditionalComment
  include Mongoid::Document
  extend NotSti::Comment

  belongs_to :task
end