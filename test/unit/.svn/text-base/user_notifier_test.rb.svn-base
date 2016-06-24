require File.dirname(__FILE__) + '/../test_helper'
require 'user_notifier'

class UserNotifierTest < Test::Unit::TestCase
  FIXTURES_PATH = File.dirname(__FILE__) + '/../fixtures'
  CHARSET = "utf-8"

  include ActionMailer::Quoting

  class AccountControllerTest < Test::Unit::TestCase

    def setup
      @controller = AccountController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new

      # for testing action mailer
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
      @emails = ActionMailer::Base.deliveries 
      @emails.clear
    end

    def test_should_activate_user_and_send_activation_email
      get :activate, :id => users(:arthur).activation_code
      assert_equal 1, @emails.length
      assert(@emails.first.subject =~ /Your account has been activated/)
      assert(@emails.first.body    =~ /#{assigns(:user).login}, your account has been activated/)
    end

    def test_should_send_activation_email_after_signup
      create_user
      assert_equal 1, @emails.length
      assert(@emails.first.subject =~ /Please activate your new account/)
      assert(@emails.first.body    =~ /Username: quire/)
      assert(@emails.first.body    =~ /Password: quire/)
      assert(@emails.first.body    =~ /account\/activate\/#{assigns(:user).activation_code}/)
    end

    protected
    def create_user(options = {})
      post :signup, :user => { :login => 'quire', :email => 'quire@example.com', 
                               :password => 'quire', :password_confirmation => 'quire' }.merge(options)
    end
  end
end
