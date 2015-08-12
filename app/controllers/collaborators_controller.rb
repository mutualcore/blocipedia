class CollaboratorsController < ApplicationController
  def create
    byebug
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find(params[:user_id])
    @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: params[:user_id])
    if @collaborator.save
      flash[:notice] = "Collaborator was saved."
    else
      flash[:error] = "Collaborator was not saved. Try again."
    end
    redirect_to edit_wiki_path wiki
  end

  def destroy
    @wiki = current_user.wikis.find(params[:wiki_id])
    @collaborator = wiki.collaborators.where(params[:id])
    if @collaborator.destroy
      flash[:notice] = "Collaborator was removed."
    else
      flash[:error] = "Collaborator was not removed. Try again."
    end
    redirect_to edit_wiki_path wiki
  end
end
