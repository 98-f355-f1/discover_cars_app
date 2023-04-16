module Api
  class EnvironmentController < ApplicationController
    include EnvironmentHelper

    before_action :set_environment, only: %i[environment headers]
    before_action :set_header_params, only: :headers

    def environment
      respond_to do |format|
        format.html
        format.json { render json: @env }
        format.xml { render xml: @env.to_xml(root: 'Environment'.upcase) }
      end
    end

    def headers
      respond_to do |format|
        format.html
        format.json { render json: @headers }
        format.xml { render xml: @headers.to_xml(root: 'Headers'.upcase) }
      end
    end

    def post
      render partial: 'post'
    end

    private

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
end
