module ApiHelper
  COLOR_HEX_REGEX = /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/

  REQUEST_PARAMETERS = %i[
    HTTP_VERSION
    HTTP_HOST
    HTTP_USER_AGENT
    HTTP_ACCEPT
    HTTP_ACCEPT_LANGUAGE
    HTTP_ACCEPT_ENCODING
    HTTP_CONNECTION
    HTTP_REFERER
    HTTP_COOKIE
    HTTP_UPGRADE_INSECURE_REQUESTS
    HTTP_IF_NONE_MATCH
  ].freeze

  private

  def validate_colors_from_params(params)
    @bg_color ||= 'BGCOLOR'.downcase
    @fg_color ||= 'FGCOLOR'.downcase

    ENV[@bg_color] = (params['BGCOLOR'] if params['BGCOLOR']&.match(COLOR_HEX_REGEX))

    ENV[@fg_color] = (params['FGCOLOR'] if params['FGCOLOR']&.match(COLOR_HEX_REGEX))
  end

  def set_environment
    validate_colors_from_params(params)

    @env = ENV.to_h
  end

  def set_header_params
    @headers = REQUEST_PARAMETERS.each_with_object({}) do |key, hash|
      hash[key] = request.headers[key.to_s.upcase]
    end
  end
end
