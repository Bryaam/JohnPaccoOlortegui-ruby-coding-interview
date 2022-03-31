class TweetsController < ApplicationController
  include Pagination

  def index
    render json: paginate(collection: Tweet.order(created_at: :desc), params: pagination_params)
  end

  private

  def pagination_params
    {
      page: params[:page],
      per_page: params[:per_page]
    }
  end
end
