class PicturesController < ApplicationController
  before_filter :login_required
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @picture_pages, @pictures = paginate :pictures, :per_page => 10
  end

  def show
    @picture = Picture.find(params[:id])
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(params[:picture])
    if @picture.save
      flash[:notice] = 'Picture was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])
    if @picture.update_attributes(params[:picture])
      flash[:notice] = 'Picture was successfully updated.'
      redirect_to :action => 'show', :id => @picture
    else
      render :action => 'edit'
    end
  end

  def destroy
    Picture.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
