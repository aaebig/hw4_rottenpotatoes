Feature: search for movies by director

  As a movie buff
  So that I can have accurate movie information
  I want to create and delete movies

Background: movies in database

  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas | 1977-05-25   |
  | Blade Runner | PG     | Ridley Scott | 1982-06-25   |
  | Alien        | R      |              | 1979-05-25   |
  | THX-1138     | R      | George Lucas | 1971-03-11   |

Scenario: delete a movie
  Given I am on the details page for "Alien"
  And I press "Delete"
  Then I should be on the home page
  And I should see "Movie 'Alien' deleted"
  When I check the following ratings: G, PG, PG-13, R
  And I press "ratings_submit"
  Then I should not see "Alien"

Scenario: add a movie
  Given I am on the home page
  And I follow "Add new movie"
  And I fill in "Title" with "Clue"
  And I press "Save Changes"
  Then I should be on the home page
  And I should see "Clue was successfully created."
  When I check the following ratings: G, PG, PG-13, R
  And I press "ratings_submit"
  Then I should see "Clue"

