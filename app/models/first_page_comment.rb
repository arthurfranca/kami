class FirstPageComment
  include Mongoid::Document
  include Comment

  #open_task or closed_task
  embedded_in :commentable, polymorphic: true
end