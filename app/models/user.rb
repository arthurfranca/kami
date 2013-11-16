class User
  include Mongoid::Document
  include Mongoid::Paranoia # deleted_at
  rolify

  after_create :assign_role
  attr_accessor :selected_role

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

  belongs_to :job
  # belongs_to :role - top rolify method already covers it

  has_many :allocations
  has_many :requests, class_name: "Task", inverse_of: :requester
  has_many :assignments, class_name: "Task", inverse_of: :resource
  
  has_and_belongs_to_many :specialties

  accepts_nested_attributes_for :job, :specialties #, :role

  field :name, type: String
  # field :email, type: String
  field :phone, type: String
  field :address, type: String
  field :is_available, type: Boolean

  field :username, type: String
  field :password, type: String

  def projects
    Project.in(id: allocations.map(&:project_id))
  end

private
  def assign_role
    byebug #self.roles.blank?
    if @selected_role.present?
      case @selected_role
      when "Administrador" then
        add_role(:admin)
      when "Gerente" then
        add_role(:manager)
      when "Recurso" then
        add_role(:resource)
      end
    elsif @roles.blank? #default role
      add_role(:resource)
    end
  end
end
