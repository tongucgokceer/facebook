class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :profile, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :pending_invitations, -> {where confirmed: false}, class_name: 'Invitation', foreign_key: "friend_id"
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  devise :omniauthable, omniauth_providers: %i[facebook]

  after_create :init_profile
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def init_profile
    #self.create_profile
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

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      #user.email = auth.info.email   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      #user.skip_confirmation!
    end
  end



end
