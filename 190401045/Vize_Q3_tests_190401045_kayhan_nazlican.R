# Function to test my_artists data frame
test_my_artists <- function() {
  stopifnot(exists("my_artists")) # Test 3.1
  stopifnot(is.data.frame(my_artists)) # Test 3.2
  stopifnot(ncol(my_artists) == 2) # Test 3.3
  stopifnot(all(names(my_artists) == c("artist", "id"))) # Test 3.4
  
  print("All tests for my_artists passed!")
}

# Run the tests
test_my_artists()
