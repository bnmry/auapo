class NewslettersController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @newsletter_pages, @newsletters = paginate :newsletters, :per_page => 10
  end

  def show
    @newsletter = Newsletter.find(params[:id])
  end

  def new
    @newsletter = Newsletter.new
  end

  def create
    @newsletter = Newsletter.new(params[:newsletter])
    if @newsletter.save
      flash[:notice] = 'Newsletter was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @newsletter = Newsletter.find(params[:id])
  end

  def update
    @newsletter = Newsletter.find(params[:id])
    if @newsletter.update_attributes(params[:newsletter])
      flash[:notice] = 'Newsletter was successfully updated.'
      redirect_to :action => 'show', :id => @newsletter
    else
      render :action => 'edit'
    end
  end

  def destroy
    Newsletter.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
