module Api
  class PostController < ApplicationController
    def new_post
      @query_params = request.query_parameters || {}
    end

    def post
      @query_params = request.query_parameters || {}
    end
  end
end
