class PledgeclassesController < ApplicationController
  before_filter :login_required
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @pledgeclass_pages, @pledgeclasses = paginate :pledgeclasses, :per_page => 10
  end

  def show
    @pledgeclass = Pledgeclass.find(params[:id])
  end

  def new
    @pledgeclass = Pledgeclass.new
  end

  def create
    @pledgeclass = Pledgeclass.new(params[:pledgeclass])
    if @pledgeclass.save
      flash[:notice] = 'Pledgeclass was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @pledgeclass = Pledgeclass.find(params[:id])
  end

  def update
    @pledgeclass = Pledgeclass.find(params[:id])
    if @pledgeclass.update_attributes(params[:pledgeclass])
      flash[:notice] = 'Pledgeclass was successfully updated.'
      redirect_to :action => 'show', :id => @pledgeclass
    else
      render :action => 'edit'
    end
  end

  def destroy
    Pledgeclass.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
