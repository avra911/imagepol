TranslationIO.configure do |config|
    config.api_key        = ENV["TRANSLATION_API_KEY"]
    config.source_locale  = 'en'
    config.target_locales = ['bg', 'cs', 'da', 'de', 'el', 'es', 'et', 'fi', 'fr', 'hr', 'hu', 'it', 'lt', 'lv', 'nl', 'pl', 'pt', 'ro', 'sk', 'sl', 'sv'] # 'ga-IE', 'mt-MT'

    # Uncomment this if you don't want to use gettext
    # config.disable_gettext = true

    # Uncomment this if you already use gettext or fast_gettext
    # config.locales_path = File.join('path', 'to', 'gettext_locale')
    
    # Find other useful usage information here:
    # https://github.com/translation/rails#readme
  end