class TeamsController < ApplicationController
  before_filter :login_required
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @teams_pages, @teams = paginate :teams, :per_page => 10
  end

  def show
    @teams = Teams.find(params[:id])
  end

  def new
    @teams = Teams.new
  end

  def create
    @teams = Teams.new(params[:teams])
    if @teams.save
      flash[:notice] = 'Teams was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @teams = Teams.find(params[:id])
  end

  def update
    @teams = Teams.find(params[:id])
    if @teams.update_attributes(params[:teams])
      flash[:notice] = 'Teams was successfully updated.'
      redirect_to :action => 'show', :id => @teams
    else
      render :action => 'edit'
    end
  end

  def destroy
    Teams.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
