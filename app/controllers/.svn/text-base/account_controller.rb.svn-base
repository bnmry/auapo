class AccountController < ApplicationController
  
  def index
    redirect_to(:action => 'login') unless logged_in? || User.count > 0
    if logged_in?
      user = current_user.id
      @fullname = "#{current_user.firstname} #{current_user.lastname}"
      @project_hours = Hour.calculate(:sum, :hours, :conditions => ["user_id = ? and status = 3 and activity_id = 1", user])
      @fellowship_events = Hour.calculate(:count, :all, :conditions => ["user_id = ? and status = 3 and activity_id = 2", user])
      @fundraising_hours = Hour.calculate(:sum, :hours, :conditions => ["user_id = ? and status = 3 and activity_id = 3", user])
    else
      redirect_to(:controller => "user", :action=> "login")
    end
  end

  def login
    return unless request.post?
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      redirect_back_or_default(:controller => '/account', :action => 'index')
      flash[:notice] = "Logged in successfully"
    else
      flash[:notice] = "Incorrect login credentials. Did you activate your account?"
    end
  end

  def signup
    @user = User.new(params[:user])
    return unless request.post?
    @user.save!
    self.current_user = @user
    redirect_back_or_default(:controller => '/account', :action => 'index')
    flash[:notice] = "Your account has been processed!"
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end
  
  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(:controller => '/account', :action => 'index')
  end
  
  def activate
    @user = User.find_by_activation_code(params[:id])
    if @user and @user.activate
      self.current_user = @user
      redirect_back_or_default(:controller => '/account', :action => 'index')
      flash[:notice] = "Your account has been activated." 
    end
  end
  
  def forgot_password
      return unless request.post?
      if @user = User.find_by_email(params[:email])
        @user.forgot_password
        @user.save
        redirect_back_or_default(:controller => '/account', :action => 'index')
        flash[:notice] = "A password reset link has been sent to your email address" 
      else
        flash[:notice] = "Could not find a user with that email address" 
      end
    end

  def picture
    @user = User.find(current_user.id)
  end


  def do_edit_picture
    @picture = User.find(current_user.id)
    if @picture.update_attributes(params[:user])
      flash[:notice] = 'Picture was successfully uploaded.'
      redirect_to :action => 'picture'
    end
  end

#allow a user to edit their details
  def edit
    if is_administrator?
      if params[:url]
        @user = User.find_by_id(params[:url])
      else
        @user = User.find(self.current_user.id)
      end
    else
      @user = User.find(self.current_user.id)
    end
  end

#update the user table
  def update
      @user = User.find(self.current_user.id)
      if @user.update_attributes(params[:user])
          flash[:notice] = 'Profile was successfully updated.'
          redirect_to :action => 'index'
      else
          render :action => 'edit'
      end
  end

  def reset_password
    @user = User.find_by_password_reset_code(params[:id])
    raise if @user.nil?
    return if @user unless params[:password]
      if (params[:password] == params[:password_confirmation])
        self.current_user = @user #for the next two lines to work
        current_user.password_confirmation = params[:password_confirmation]
        current_user.password = params[:password]
        @user.reset_password
        flash[:notice] = current_user.save ? "Password reset" : "Password not reset" 
      else
        flash[:notice] = "Password mismatch" 
      end  
      redirect_back_or_default(:controller => '/account', :action => 'index') 
  rescue
    logger.error "Invalid Reset Code entered" 
    flash[:notice] = "Sorry - That is an invalid password reset code. Please check your code and try again. (Perhaps your email client inserted a carriage return?" 
    redirect_back_or_default(:controller => '/account', :action => 'index')
  end
  
end
