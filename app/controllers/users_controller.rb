class UsersController < ApplicationController

  def downgrade
    current_user.downgrade_role
    current_user.save!

    @wikis = Wiki.where(private: true, user_id: current_user.id)
    @wikis.each do |wiki|
      wiki.set_public
      wiki.save!
    end

    flash[:notice] = "Your account has been downgraded successfully."
    redirect_to wikis_path
  end
end
