module Comment
  extend ActiveSupport::Concern
  include Mongoid::Timestamps::Short

  included do
    belongs_to :commenter, class_name: "User"
    
    field :body, type: String
  end
end