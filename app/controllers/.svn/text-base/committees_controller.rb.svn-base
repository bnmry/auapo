class CommitteesController < ApplicationController
  before_filter :login_required
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @committee_pages, @committees = paginate :committees, :per_page => 10
  end

  def show
    @committee = Committee.find(params[:id])
  end

  def new
    @committee = Committee.new
  end

  def create
    @committee = Committee.new(params[:committee])
    if @committee.save
      flash[:notice] = 'Committee was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @committee = Committee.find(params[:id])
  end

  def update
    @committee = Committee.find(params[:id])
    if @committee.update_attributes(params[:committee])
      flash[:notice] = 'Committee was successfully updated.'
      redirect_to :action => 'show', :id => @committee
    else
      render :action => 'edit'
    end
  end

  def destroy
    Committee.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
