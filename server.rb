require 'sinatra'
require 'csv'

  def build_films(csvfile)
    @films_array = []
    CSV.foreach(csvfile, headers: true) do |row|
      film_hash = {}
      film_hash[:movie_id] = row["id"]
      film_hash[:title] = row["title"]
      film_hash[:year] = row["year"]
      film_hash[:syn] = row["synopsis"]
      film_hash[:rating] = row["rating"]
      film_hash[:genre] = row["genre"]
      film_hash[:studio] = row["studio"]
      @films_array << film_hash
    end
  @films_array = (@films_array.sort_by {|key, value| key[:title]})
  end

get "/movies" do
build_films("movies.csv")
  if params["page"] != nil
    erb :paging
  elsif params["page"] == nil && params["query"] == nil && params["movie_id"] == nil
    erb :index
  else params["movie_id"] == nil
    erb :search
  end
end

get "/movies/:movie_id" do
  build_films("movies.csv")
  erb :details
end


