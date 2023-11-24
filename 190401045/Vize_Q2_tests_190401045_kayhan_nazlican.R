# Function to test spotify_search_artist
test_spotify_search_artist <- function() {
  stopifnot(exists("spotify_search_artist")) # Test 2.1
  stopifnot(is.function(spotify_search_artist)) # Test 2.2
  output <- spotify_search_artist("The Door")
  stopifnot(is.list(output)) # Test 2.3
  stopifnot(length(output) == 2) # Test 2.4
  stopifnot(names(output)[1] == "status_code") # Test 2.5
  stopifnot(is.numeric(output$status_code)) # Test 2.6
  stopifnot(output$status_code == 200) # Test 2.7
  stopifnot(names(output)[2] == "search_results") # Test 2.8
  #print("search done2")
  stopifnot(is.data.frame(output$search_results)) # Test 2.9
  stopifnot(ncol(output$search_results) == 2) # Test 2.10
  stopifnot(all(names(output$search_results) == c("artist", "id"))) # Test 2.11
  stopifnot(output$search_results$id[0] == "22WZ7M8sxp5THdruNY3gXt") # Specific Test for "The Doors"
  
  print("All tests for spotify_search_artist passed!")
}

# Run the tests
test_spotify_search_artist()