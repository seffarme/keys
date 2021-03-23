
if Rails.env.production?
  Rails.application.routes.default_url_options[:host]=ENV['DOMAIN']
end