class FundraisersController < ApplicationController
  before_filter :login_required
  in_place_edit_for :hour, :hours
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

   def list
     @fundraiser_pages, @fundraisers = paginate :events, :per_page => 20, :order_by => "start_time ASC", :conditions => ["activity_id = 3 and end_time > ?", Time.now]
   end
   
   def old
     @fundraiser_pages, @fundraisers = paginate :events, :per_page => 20, :order_by => "start_time ASC", :conditions => ["activity_id = 3 and end_time < ?", Time.now]
     render :action => 'list'
   end

  def show
    @event = Event.find(params[:id])
    @event_name = 'fundraiser'
    @attendees = Hour.find(:all, :conditions => ["event_id = ?", @event.id])
    @ticket = Hour.find(:all, :conditions => ["event_id = ? and user_id = ?", @event.id, current_user.id])
  end
  
  def signup
    @attendees = Hour.new(params[:hours])
    if @attendees.save
      render(:partial => "/layouts/attendees", :object => @attendees, :layout => false)
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:notice] = 'Fundraiser was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:notice] = 'Fundraiser was successfully updated.'
      redirect_to :action => 'show', :id => @event
    else
      render :action => 'edit'
    end
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def signup
    attendees = Hour.new(params[:hours])
    if attendees.save
      render(:partial => "/layouts/attendees", :object => attendees, :layout => false)
    end
    
  end
  
  def withdraw
    if Hour.update(params[:id], :status => "2")
      render(:partial => "/layouts/withdraw", :layout => false)
    end
  end
  
  def recommit
    if Hour.update(params[:id], :status => "1")
      render(:partial => "/layouts/recommit", :layout => false)
    end
  end
  
  def completed_event
    if Hour.update(params[:id], :status => "3")
      render(:partial => "/layouts/completed_event", :layout => false)
    end
  end
  
  def log_hour
    render(:layout => false)
    @log_hour = Hour.find(params[:id])
    Hour.update(@log_hour.id, :hours => @log_hour.hours)
  end
end
