class Invitation < ApplicationRecord
  belongs_to :user

  def self.reacted?(id1,id2) 
    #Checks whether the two users have an active friendship request or not or already friends. Returns true if there is no active friendship request OR no friendship!
    case1 = Invitation.where(user_id: id1, friend_id: id2, confirmed: false).empty?
    case2 = Invitation.where(user_id: id2, friend_id: id1, confirmed: false).empty?
    case3= Invitation.where(user_id: id1, friend_id: id2, confirmed: true).empty?
    case4= Invitation.where(user_id: id2, friend_id: id1, confirmed: true).empty?
    return case1 && case2 && case3 && case4
  end

  def self.confirmed_record?(id1, id2)
    case1 = !Invitation.where(user_id: id1, friend_id: id2, confirmed: true).empty?
    case2 = !Invitation.where(user_id: id2, friend_id: id1, confirmed: true).empty?
    case1 || case2
  end

  def self.find_invitation(id1,id2)
    if Invitation.where(user_id: id1, friend_id: id2, confirmed: true).empty?
      Invitation.where(user_id: id2, friend_id: id1, confirmed: true)[0].id
    else
      Invitation.where(user_id: id1, friend_id: id2, confirmed: true)[0].id
    end
  end


end
