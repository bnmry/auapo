class RemindersController < ApplicationController
  before_filter :login_required
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @reminder_pages, @reminders = paginate :reminders, :per_page => 10
  end

  def show
    @reminder = Reminder.find(params[:id])
  end

  def new
    @reminder = Reminder.new
  end

  def create
    @reminder = Reminder.new(params[:reminder])
    if @reminder.save
      require 'send_mailing'
      render :action => 'show', :collection => @reminder
    else
      render :action => 'new'
    end
  end

  def edit
    @reminder = Reminder.find(params[:id])
  end

  def update
    @reminder = Reminder.find(params[:id])
    if @reminder.update_attributes(params[:reminder])
      flash[:notice] = 'Reminder was successfully updated.'
      redirect_to :action => 'show', :id => @reminder
    else
      render :action => 'edit'
    end
  end

  def destroy
    Reminder.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
