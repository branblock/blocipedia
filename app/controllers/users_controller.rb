class UsersController < ApplicationController

  def downgrade
    downgrade_role
    @user.save!
      flash[:notice] = "Your account has been downgraded successfully."
      redirect_to wikis_path
  end
end
