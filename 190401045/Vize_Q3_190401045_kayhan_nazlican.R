library(httr)
library(jsonlite)

# Function to fetch Spotify token
spotify_token <- function() {
  response <- POST("https://accounts.spotify.com/api/token",
                   body = list(grant_type = "client_credentials", 
                               client_id = Sys.getenv("SPOTIFY_ID"), 
                               client_secret =  Sys.getenv("SPOTIFY_SECRET")),
                   encode = "form")
  
  status_code <- status_code(response)
  token <- if (status_code == 200) {
    paste0("Bearer ", content(response)$access_token)
  } else {
    NA
  }
  
  return(list(status_code = status_code, token = token))
}

# Function to search for an artist on Spotify
spotify_search_artist <- function(artist_name) {
  token_response <- spotify_token()
  if (is.na(token_response$token)) {
    stop("Failed to retrieve Spotify token")
  }
  
  search_url <- "https://api.spotify.com/v1/search"
  headers <- c('Authorization' = token_response$token, 'Content-Type' = 'application/json')
  params <- list(q = artist_name, type = "artist", limit = 5)
  
  response <- GET(search_url, add_headers(.headers = headers), query = params)
  status_code <- status_code(response)
  
  # Initialize an empty data frame with artist and id columns
  search_results <- data.frame(artist = character(), id = character(), stringsAsFactors = FALSE)
  
  if (status_code == 200) {
    content <- fromJSON(rawToChar(response$content))
    if (length(content$artists$items) > 0) {
      artist_info <- content$artists$items[[1]]
      search_results <- rbind(search_results, data.frame(artist = artist_info$name, id = artist_info$id, stringsAsFactors = FALSE))
    }
  }
  
  return(list(status_code = status_code, search_results = search_results))
}

# List of artist names
artist_names <- c("Artist1", "Artist2", "Artist3", "Artist4", "Artist5")

# Use lapply and combine the results
my_artists <- do.call("rbind", lapply(artist_names, function(artist) {
  result <- spotify_search_artist(artist)
  # Make sure result is always a data frame
  if (is.data.frame(result$search_results)) {
    return(result$search_results)
  } else {
    # Return a data frame with NA values if the search result is not a data frame
    return(data.frame(artist = artist, id = NA, stringsAsFactors = FALSE))
  }
}))


# Print the contents of my_artists
print("Contents of my_artists:")
print(my_artists)