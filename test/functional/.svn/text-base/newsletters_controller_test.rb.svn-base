require File.dirname(__FILE__) + '/../test_helper'
require 'newsletters_controller'

# Re-raise errors caught by the controller.
class NewslettersController; def rescue_action(e) raise e end; end

class NewslettersControllerTest < Test::Unit::TestCase
  fixtures :newsletters

  def setup
    @controller = NewslettersController.new
    request    = ActionController::TestRequest.new
    response   = ActionController::TestResponse.new
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:newsletters)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:newsletter)
    assert assigns(:newsletter).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:newsletter)
  end

  def test_create
    num_newsletters = Newsletter.count

    post :create, :newsletter => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_newsletters + 1, Newsletter.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:newsletter)
    assert assigns(:newsletter).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil Newsletter.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Newsletter.find(1)
    }
  end
end
