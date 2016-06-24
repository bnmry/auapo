class AlumniController < ApplicationController
  
  def index
    @welcome = Page.find_by_id(9)
  end
  
  def brothers
  end
  
  def anniversary
    @page = Page.find_by_id(10)
  end
  
  
end
