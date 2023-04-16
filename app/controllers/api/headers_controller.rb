module Api
  class HeadersController < ApplicationController
    include ApiHelper

    before_action :set_environment
    before_action :set_header_params

    def headers
      respond_to do |format|
        format.html
        format.json { render json: @headers }
        format.xml { render xml: @headers.to_xml(root: 'Headers'.upcase) }
      end
    end
  end
end
