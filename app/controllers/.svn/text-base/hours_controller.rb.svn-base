class HoursController < ApplicationController
  before_filter :login_required
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    
    # Define whose hours are displayed
    if is_administrator?
      if params[:id]
        user = params[:id]
      else
        user = current_user.id
      end
    else
      user = current_user.id
    end
    
    # Hours completed graph
    @user_hours = Hour.calculate(:sum, :hours, :conditions => ["user_id = ? and status = 3 and activity_id = 1", user])
    brother = User.find_by_id(user)
    if brother.status_id == 4
      @goal = Goal.find_by_id(3)
    else
      @goal = Goal.find_by_id(1)
    end
    if @user_hours.nil?
      @percentage = 0
    elsif @user_hours > @goal.number
      @percentage = 100
    else
      @percentage = @user_hours/@goal.number * 100
    end
    
    #What user?
    @user = User.find_by_id(user)
    
    # Grab the number of hours/fellowships from the server
    @project_hours = Hour.calculate(:sum, :hours, :conditions => ["user_id = ? and status = 3 and activity_id = 1", user])
    @fellowship_events = Hour.calculate(:count, :all, :conditions => ["user_id = ? and status = 3 and activity_id = 2", user])
    @fundraising_hours = Hour.calculate(:sum, :hours, :conditions => ["user_id = ? and status = 3 and activity_id = 3", user])
    
    # Grab the actual events from the server
    @projects = Hour.find(:all, :conditions => ["user_id = ? and status = 3 and activity_id = 1", user])
    @fellowships = Hour.find(:all, :conditions => ["user_id = ? and status = 3 and activity_id = 2", user])
    @fundraisers = Hour.find(:all, :conditions => ["user_id = ? and status = 3 and activity_id = 3", user])
  end
  
  def upcoming
    user = current_user.id
    @projects = Hour.find(:all, :conditions => ["user_id = ? and status = 1 and activity_id = 1", user])
    @fellowships = Hour.find(:all, :conditions => ["user_id = ? and status = 1 and activity_id = 2", user])
    @fundraisers = Hour.find(:all, :conditions => ["user_id = ? and status = 1 and activity_id = 3", user])
  end

  def show
    @hour = Hour.find(params[:id])
  end

  def new
    @hour = Hour.new
  end

  def create
    @hour = Hour.new(params[:hour])
    if @hour.save
      flash[:notice] = 'Hour was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @hour = Hour.find(params[:id])
  end

  def update
    @hour = Hour.find(params[:id])
    if @hour.update_attributes(params[:hour])
      flash[:notice] = 'Hour was successfully updated.'
      redirect_to :action => 'show', :id => @hour
    else
      render :action => 'edit'
    end
  end

  def destroy
    Hour.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def pledges
    @pledges = User.find(:all, :order => "lastname ASC", :conditions => ["status_id = 4"])
  end
  
  def print
    
    @events = Event.find(:all, :conditions => ["start_time > ?", Time.now])
  end
  
  def projects_report
    @events = Event.find(:all )
  end
end
