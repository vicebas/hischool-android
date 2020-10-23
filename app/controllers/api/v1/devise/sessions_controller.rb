# frozen_string_literal: true

class Api::V1::Devise::SessionsController < DeviseTokenAuth::SessionsController
  def create
    # Check
    field = :login
    @resource = nil
    if field
      q_value = resource_params[field]
      @resource = resource_class.where("email = ? OR tax_id = ?", q_value.downcase, q_value).first
    end

    if @resource && valid_params?(field, q_value) && (!@resource.respond_to?(:active_for_authentication?) || @resource.active_for_authentication?)
      valid_password = @resource.valid_password?(resource_params[:password])
      if (@resource.respond_to?(:valid_for_authentication?) && !@resource.valid_for_authentication? { valid_password }) || !valid_password
        render_create_error_bad_credentials
        return
      end
      # create client id
      @client_id = SecureRandom.urlsafe_base64(nil, false)
      @token     = SecureRandom.urlsafe_base64(nil, false)

      @resource.tokens[@client_id] = {
        token: BCrypt::Password.create(@token),
        expiry: (Time.now + ::DeviseTokenAuth.token_lifespan).to_i
      }
      @resource.save

      sign_in(:user, @resource, store: false, bypass: false)

      yield @resource if block_given?

      render_create_success
    elsif @resource && !(!@resource.respond_to?(:active_for_authentication?) || @resource.active_for_authentication?)
      render_create_error_not_confirmed
    else
      render_create_error_bad_credentials
    end
  end

  def render_create_success
    render json: resource_data(resource_json: ActiveModelSerializers::SerializableResource.new(@resource).as_json)
  end

  def render_create_error_bad_credentials
    render json: { error: I18n.translate("devise.sessions.error") }, status: 401
  end

  def resource_params
    params.permit(:login, :password)
  end
end
