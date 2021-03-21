class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if current_user
      biens_path
    else
      super(resource)
    end
  end

  # https://www.lewagon.com/blog/setup-meta-tags-rails : Let's override Rails.application.default_url_options[:host]

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
end
