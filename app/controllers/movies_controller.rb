class MoviesController < ApplicationController
  def index
    if params[:query].present?
      # Basic WHERE with ActiveRecord
      # (SELECT * FROM movies WHERE title LIKE %man%)

      # Case-INSENSITIVE search with ActiveRecord.
      # title ILIKE '%superman%' OR syllabus ILIKE '%superman%'
      # sql_query = 'title ILIKE :search_term OR syllabus ILIKE :search_term'
      # @movies = Movie.where(sql_query, search_term: "%#{params[:query]}%")

      # Using ASSOCIATION, joining to another table
      # title ILIKE '%superman%' OR director.first_name ILIKE '%superman%'
      # sql_query = " \
      #   movies.title @@ :query \
      #   OR movies.syllabus @@ :query \
      #   OR directors.first_name @@ :query \
      #   OR directors.last_name @@ :query \
      # "
      # @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")

      # PG search:
      @movies = Movie.search_by_title_and_syllabus(params[:query])
    else
      @movies = Movie.all
    end
  end
end
