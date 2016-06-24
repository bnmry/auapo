class BrothersController < ApplicationController
  before_filter :login_required, :except => [:index, :gallery, :meet]
  def index
    @brother_pages, @brothers = paginate :users, :per_page => 40, :order_by => "lastname", :conditions => ["status_id = 1"]
  end
  
  def gallery
    @brothers = User.find(:all, :order => "lastname")
  end
  
  def meet
    @brother = User.find_by_id(params[:id])
  end
  
  def pledges
    @brother_pages, @brothers = paginate :users, :per_page => 20, :order_by => "lastname", :conditions => ["status_id = 4"]
  end
  
  def eboard
    @brothers = User.find(:all, :order => "position_id ASC", :conditions => ["position_id > 0"])
  end
end
