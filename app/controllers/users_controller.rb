# coding: utf-8
class UsersController < ApplicationController
  load_and_authorize_resource new: [ :set_email ], except: [ :projects, :authenticate_user ]
  inherit_resources
  actions :show, :create, :update, :unsubscribe_update, :request_refund, :set_email, :update_email, :uservoice_gadget, :authenticate_user
  respond_to :json, only: [:backs, :projects, :request_refund, :authenticate_user]

  def uservoice_gadget
    if params[:secret] == ::Configuration[:uservoice_secret_gadget]
      @user = User.find_by_email params[:email]
    end
    render :uservoice_gadget, layout: false
  end

  def show
    show!{
      fb_admins_add(@user.facebook_id) if @user.facebook_id
      @title = "#{@user.display_name}"
      @credits = @user.backs.can_refund.all
      @subscribed_to_updates = @user.updates_subscription
      @unsubscribes = @user.project_unsubscribes
    }
  end

  def set_email
    @user = current_user
  end

  def update_email
    update! do |success,failure|
      success.html do
        flash[:notice] = t('users.current_user_fields.updated')
        redirect_to (session[:return_to] || user_path(@user, anchor: 'settings'))
        session[:return_to] = nil
        return
      end
      failure.html{ return render :set_email }
    end
  end

  def update
    update! do |success,failure|
      success.html do
        flash[:notice] = t('users.current_user_fields.updated')
      end
      failure.html do
        flash[:error] = @user.errors.full_messages.to_sentence
      end
    end
    return redirect_to user_path(@user, anchor: 'settings')
  end

  def update_password
    @user = User.find(params[:id])
    if @user.update_with_password(params[:user])
      flash[:notice] = t('users.current_user_fields.updated')
    else
      flash[:error] = @user.errors.full_messages.to_sentence
    end
    return redirect_to user_path(@user, anchor: 'settings')
  end

  def projects
    @user = User.find(params[:id])
    @projects = @user.projects.includes(:user, :category, :project_total).order("updated_at DESC")
    @projects = @projects.visible unless @user == current_user
    @projects = @projects.page(params[:page]).per(10)
    render json: @projects
  end

  def credits
    @user = User.find(params[:id])
    @credits = @user.backs.can_refund.order(:id).all
    render json: @credits
  end

  def authenticate_user
    return unless authenticate_api(true)
    return render(json: {errors: ["You must inform a user parameter"]}, status: 422) unless params[:user].present?
    email = params[:user][:email]
    return render(json: {errors: ["You must inform at least an email address"]}, status: 422) unless email.present?
    unless user = User.find_by_email(email)
      user = User.create(params[:user])
      return render(json: {errors: user.errors.full_messages}, status: 422) unless user.valid?
    end
    access_token = user.api_keys.create(expires_at: 2.minutes.from_now).access_token
    render json: {access_token: access_token}
  end

end
