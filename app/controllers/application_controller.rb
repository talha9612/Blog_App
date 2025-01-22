class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_posts_path # Admin dashboard or namespace
    else
      posts_path # Regular user path
    end
  end
end
