module Pagination
  MAX_PAGE_SIZE = 10
  DEFAULT_PAGE = 1

  def paginate(collection:, params:)
    page = [params[:page].to_i, DEFAULT_PAGE].max
    per_page = if params[:per_page]
                [params[:per_page].to_i, MAX_PAGE_SIZE]
                  .reject(&:negative?)
                  .reject(&:zero?)
                  .min
               else
                MAX_PAGE_SIZE
               end

    offs = per_page * (page - 1)

    collection.limit(per_page).offset(offs)
  end
end
