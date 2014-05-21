require 'sinatra'
require 'csv'

  def build_films(csvfile)
    @films_hash = {}
    CSV.foreach(csvfile, headers: true) do |row|
      film_hash = {}
      film_hash[:movie_id] = row["id"]
      # film_hash[:title] = row["title"]
      film_hash[:year] = row["year"]
      film_hash[:syn] = row["synopsis"]
      film_hash[:rating] = row["rating"]
      film_hash[:genre] = row["genre"]
      film_hash[:studio] = row["studio"]
      @films_hash[row["title"]] = film_hash
    end
  @films_hash = (@films_hash.sort_by {|key, value| key})
  puts "hello"
  end

get "/movies" do
  build_films("movies.csv")
  erb :index
end

get "/movies/:movie_id" do
  puts "goodbye"
  build_films("movies.csv")
  erb :views
end
