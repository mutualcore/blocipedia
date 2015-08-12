class User < ActiveRecord::Base
  has_many :collaborators
  has_many :wikis, through: :collaborators
  
  after_initialize :set_default_role

  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end

  def admin?
    role == 'moderator'
  end

  def set_default_role
    self.role ||= 'standard'
  end

  def upgrade_account(user)
    user.role = 'premium'
    user.save
  end

  def downgrade_account(user)
    user.role = 'standard'
    user.save
    user.wikis.where(private: true).update_all(private: false)
  end

  def is_owner_of?(wiki)
    admin? || wiki.user == self || wiki.new_record?
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
end
