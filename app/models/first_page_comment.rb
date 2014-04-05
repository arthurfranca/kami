class FirstPageComment
  include Mongoid::Document
  extend NotSti::Comment

  embedded_in :task
end