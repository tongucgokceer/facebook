module ProfilesHelper
    def profile_params
        params.require(:profile).permit(:name, :surname, :age, :gender, :image)
      end
end
