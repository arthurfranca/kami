class User
  include Mongoid::Document
  # include Mongoid::Paranoia # deleted_at
  # after_create { assign_role }

  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String


  # belongs_to :role - top rolify method already covers it
  # field :email, type: String - devise will take care of it
  # field :password, type: String - devise will take care of it
  # accepts_nested_attributes_for :job, :specialties #, :role

  attr_accessor :selected_role

  has_and_belongs_to_many :allocations, class_name: "Project", inverse_of: :allocated

  field :name,               type: String
  field :phne, as: :phone,   type: String
  field :adrs, as: :address, type: String

  def project_assignments project_id
    Project.where(id: project_id).tasks.where(resource_ids: id) +
    ClosedTask.where(resource_ids: id)
  end  

private
  def email_required?
    true
  end

  # TODO: Pensar nas atribuições de cada role
  # def assign_role
  #   if selected_role.present?
  #     case selected_role
  #     when "Administrador" then
  #       add_role(:admin) # Owns company, can create projects, invite users
  #     when "Gerente" then
  #       add_role(:manager) # Can create projects <- ver se vai variar a funcao (as vezes gerente é o único que faz certas coisas, as vezes resource pode tudo tb)
  #     when "Recurso" then
  #       add_role(:resource)
  #     else
  #       add_role(:resource)
  #     end
  #   elsif roles.blank? #default role
  #     add_role(:resource)
  #   end
  # end
end