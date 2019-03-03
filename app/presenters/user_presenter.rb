class UserPresenter < BasePresenter
  def provider
    @model.provider == "google_oauth2" ? "google" : @model.provider
  end

  def username
    @model.username
  end

  def picture
    @model.picture
  end

  def email
    @model.email
  end
end
