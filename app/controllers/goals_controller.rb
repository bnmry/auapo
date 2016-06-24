class GoalsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @goal_pages, @goals = paginate :goals, :per_page => 10
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(params[:goal])
    if @goal.save
      flash[:notice] = 'Goal was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update_attributes(params[:goal])
      flash[:notice] = 'Goal was successfully updated.'
      redirect_to :action => 'show', :id => @goal
    else
      render :action => 'edit'
    end
  end

  def destroy
    Goal.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
