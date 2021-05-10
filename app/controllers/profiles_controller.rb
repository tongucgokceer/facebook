class ProfilesController < ApplicationController
    include ProfilesHelper

    def new
        @profile=Profile.new
    end

    def edit
        @profile = current_user.profile
    end

    def create
        @profile=Profile.new(profile_params)
        @profile.user_id=current_user.id
        @profile.save

        redirect_to user_path(@profile.user_id)
    end
  
    def update
        @profile = current_user.profile
      respond_to do |format|
        if @profile.update profile_params
          format.html { redirect_to user_path(@profile.user_id), notice: "Profile updated!" }
          format.json { render :edit, status: :ok, location: @profile }
        else
          format.html { redirect_to edit_profile_path, flash: { error: "Profile could not be updated!" } }
          format.json { render json: @profile.errors.messages, status: :unprocessable_entity }
        end
      end
    end

end
