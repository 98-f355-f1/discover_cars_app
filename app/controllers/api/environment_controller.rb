module Api
  class EnvironmentController < ApplicationController
    include ApiHelper

    before_action :set_environment, only: :environment

    def environment
      respond_to do |format|
        format.html
        format.json { render json: @env }
        format.xml { render xml: @env.to_xml(root: 'Environment'.upcase) }
      end
    end
  end
end
