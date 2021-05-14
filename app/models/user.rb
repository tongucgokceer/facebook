class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :profile, dependent: :destroy
  has_many :invitations
  has_many :pending_invitations, -> {where confirmed: false}, class_name: 'Invitation', foreign_key: "friend_id"
  has_many :posts
  has_many :comments

  after_create :init_profile
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def init_profile
    self.create_profile!
  end

  def friends
    friends_i_sent_invitation=Invitation.where(user_id: id, confirmed: true).pluck(:friend_id)
    friends_i_got_invitation=Invitation.where(friend_id: id, confirmed: true).pluck(:user_id)
    ids= friends_i_sent_invitation + friends_i_got_invitation
    User.where(id: ids)
  end

  def friend_with?(user)
    Invitation.confirmed_record?(id, user.id)
  end


end





