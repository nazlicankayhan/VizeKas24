library(httr)
spotify_token <- function() {
  
  response <- POST("https://accounts.spotify.com/api/token",
                   body = list(grant_type = "client_credentials", 
                               client_id = Sys.getenv("SPOTIFY_ID"), 
                               client_secret =  Sys.getenv("SPOTIFY_SECRET")),
                   encode = "form")
  
  status_code <- status_code(response)
  token <- if (status_code == 200) {
    print(paste0("Bearer ", content(response)$access_token))
  } else {
    NA
  }
  
  
  return(list(status_code = status_code, token = token))
}

(spotify_token())

