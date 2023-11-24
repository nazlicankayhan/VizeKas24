# Function to test spotify_token
test_spotify_token <- function() {
  stopifnot(exists("spotify_token")) # Test 1.1
  stopifnot(is.function(spotify_token)) # Test 1.2
  
  output <- spotify_token()
  
  stopifnot(is.list(output)) # Test 1.3
  stopifnot(length(output) == 2) # Test 1.4
  stopifnot(names(output)[1] == "status_code") # Test 1.5
  stopifnot(is.numeric(output$status_code)) # Test 1.6
  stopifnot(output$status_code == 200) # Test 1.7
  stopifnot(names(output)[2] == "token") # Test 1.8
  stopifnot(is.character(output$token)) # Test 1.9
  stopifnot(startsWith(output$token, "Bearer ")) # Test 1.10
  stopifnot(nchar(output$token) == 122) # Test 1.11
  print("All tests passed!")
}

# Run the tests
test_spotify_token()


