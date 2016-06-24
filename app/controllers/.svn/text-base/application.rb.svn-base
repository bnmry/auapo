# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  layout "standard", :except => [:rss]
  include AuthenticatedSystem
  before_filter :login_from_cookie
  before_filter do |c|
      if !c.session[:user].nil?
        User.current_user = c.session[:user]
      end
    end
# Time operations

  def event_is_over?
    event = Event.find(params[:id])
    if event.end_time < Time.now
      true
    else
      false
    end
  end
  helper_method :event_is_over?

# Authentication Schema
  def is_administrator?
    if logged_in?
      if current_user.position_id != 0
        true
      else
        false
      end
    else
      false
    end
  end
  helper_method :is_administrator?
  
  def is_brother?
    if logged_in?
      if current_user.status_id == 1
        true
      else
        false
      end
    else
      false
    end
  end
  helper_method :is_brother?
  
  def is_alumni?
    if logged_in?
      if current_user.status_id == 5
        true
      else
        false
      end
    else
      false
    end
  end
  helper_method :is_alumni?
  
  def is_abroad?
    if logged_in?
      if current_user.status_id == 2
        true
      else
        false
      end
    else
      false
    end
  end
  helper_method :is_abroad?
  
  def can_edit_event?(id)
    event = Event.find_by_id(id)
    if is_administrator?
      true
    elsif
      event.user_id = current_user.id
    end
  end
  helper_method :can_edit_event?
  
  def can_edit_hour?(user_id)
    user = User.find_by_id(user_id)
    if is_administrator?
      true
    elsif user.id == current_user.id
      true
    else
      false
    end
  end
  helper_method :can_edit_hour?
  
  def is_not_attending?
    if Hour.count(:all, :conditions => ["user_id = ? and event_id = ?", current_user.id, @event.id]) < 1
      true
    else
      false
    end
  end
  helper_method :is_not_attending?
  
  def is_closed?(id)
    event = Event.find_by_id(id)
    attendees = Hour.count(:all, :conditions => ["event_id = ? and status = 1", id])
    
    #close project if limit is less than or equal to attendees
    if event.is_closed == 1
      true
    elsif event.attendee_limit == 0
      false
    elsif event.attendee_limit <= attendees
      true
    else
      false
    end
  end
  helper_method :is_closed?
  
end