class CollaboratorsController < ApplicationController
  def new
    @collaborator = Collaborator.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: params[:user_id])

    if @collaborator.save
      flash[:notice] = "Collaborator added."
    else
      flash[:error] = "Collaborator could not be added. Please try again."
    end
    redirect_to edit_wiki_path(@wiki)
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators
    @collaborator_id = @collaborator.find_by(user_id: params[:user_id])

    if @collaborator_id.destroy
      flash[:notice] = "Collaborator deleted."
    else
      flash[:error] = "Collaborator could not be deleted. Please try again."
    end
    redirect_to edit_wiki_path(@wiki)
  end

  private
  def collaborator_params
    params.require(:collaborator).permit(:wiki_id, :user_id)
  end
end
