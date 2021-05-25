Rails.application.config.base_url = ENV['BASE_URL'] || 'localhost:3000'
Rails.application.config.session_store :cookie_store, 
	key: "_imagepol_#{Rails.env}",
	secure: Rails.env.production?,
	domain: :all
