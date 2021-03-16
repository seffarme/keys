class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if current_user
      biens_path
    else
      super(resource)
    end
  end
end
