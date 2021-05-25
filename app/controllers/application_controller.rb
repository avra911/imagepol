 class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :set_locale, :redirect_users_without_subdomain, :load_color

  layout :set_layout

  # @TODO not sure if this is 100% useful
  def redirect_users_without_subdomain
    if user_signed_in? and !request.subdomain.blank? and params[:controller] != "devise/sessions"
      redirect_to url_for(subdomain: false) and return
    end
  end

  def load_color
    @color = I18n.t("theme.color", :default => 'teal')
  end
  
  def set_locale
    I18n.locale = current_user.try(:locale) || 
      extract_locale_from_subdomain || 
      extract_locale_from_accept_language_header || 
      I18n.default_locale
  end

  def set_layout
    if user_signed_in?
      "application"
    else
      devise_controller? ? "login" : "application"
    end
  end

  private
    def extract_locale_from_subdomain
      parsed_locale = request.subdomains.first
      I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
    end

    def extract_locale_from_accept_language_header
      accept_language = request.env['HTTP_ACCEPT_LANGUAGE']
      return unless accept_language
  
      locale = accept_language.scan(/^[a-z]{2}/).first

      I18n.available_locales.map(&:to_s).include?(locale) ? locale : nil
    end
end
