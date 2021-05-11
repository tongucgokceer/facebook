class InvitationsController < ApplicationController

    def index
        @invitations=Invitation.where(friend_id: current_user.id, confirmed: false)
        @requests=Invitation.where(user_id: current_user.id, confirmed: false)
    end

    def create
        @invitation=Invitation.new
        @invitation.user_id=params[:user_id]
        @invitation.friend_id=params[:friend_id]
        @invitation.save
        redirect_to users_path, :notice => "Request sent!!!asdasdasdasdasdasdasdasdasda"
    end

    def update
        @invitation=Invitation.find(params[:id])
        @invitation.update_attribute(:confirmed,true)
        redirect_to invitations_path, :notice => "FRIENDSHIP ACCEPTED!!!"
    end

    def destroy
        @invitation=Invitation.find(params[:id])
        @invitation.destroy
        redirect_to invitations_path, :notice => "FRIENDSHIP REJECTED!!!"
    end
   
end


