require "jwt"
require "ostruct"

module Helpers
  include ActionView::Helpers::DateHelper

  def stub_current_user(user)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)
  end

  def stub_current_session(session)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user_session).and_return(session)
  end

  def stub_jwt_user
    allow(JWT).to receive(:decode).and_return(
      { user_id: 1, exp: 1_546_439_291 }
    )
  end

  def stub_create_with_omniauth(user)
    allow(User)
      .to receive(:find_or_create_from_omniauth)
      .and_return(user)
  end

  def stub_github_auth
    Github
  end

  def stub_google_auth
    Google
  end

  # get request handlers
  def get_xhr(action, params = {})
    get action.to_sym, params: params, xhr: true
  end

  # Post request handlers
  def post_xhr(action, params = {}, format = :html)
    post action.to_sym, params: params, xhr: true, format: format
  end

  # Patch request handlers
  def patch_xhr(action, params = {})
    patch action.to_sym, params: params, xhr: true
  end

  # Put request handlers
  def put_xhr(action, params = {})
    put action.to_sym, params: params, xhr: true
  end

  # delete request handlers
  def delete_xhr(action, params = {})
    delete action.to_sym, params: params, xhr: true
  end

  def post(action, params = {})
    post action.to_sym, params: params
  end

  # Create Github AuthClass
  token = OpenStruct.new({ token: "123456789987654321" })
  extra = OpenStruct.new({ extra: {} })
  info = OpenStruct.new(
    { email: "johndoe@gmail.com",
      name: "johndoe",
      first_name: "johndoe",
      image: "",  }
  )
  Github = OpenStruct.new(
    { provider: "github",
      uid: "123456",
      info: info,
      credentials: token,
      extra: extra, }
  )
  Google = OpenStruct.new(
    { provider: "google_oauth2",
      uid: "123456",
      info: info,
      credentials: token, }
  )
end
