class AdditionalComment
  include Mongoid::Document
  include Comment

  #open_task or closed_task
  belongs_to :commentable, polymorphic: true
end