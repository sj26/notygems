class ProjectsController < ApplicationController
  before_action :prepare_projects

  def index
    @projects = @projects.page(params[:page])
  end

  def search
    @exact_project = @projects.find_by(name: params[:query])
    @projects = @projects.basic_search(name: params[:query]).page(params[:page])
  end

private

  def prepare_projects
    @projects = Project.all
  end
end
