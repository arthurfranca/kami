module NotSti::Comment
  def self.extended(base)
    base.instance_eval do
      belongs_to :commenter, class_name: "User"
      
      field :body, type: String
    end
  end
end