# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert page.body =~ /#{e1}.*#{e2}/m
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/,\s/).each do |rating|
    if uncheck
      step %Q[uncheck "ratings_#{rating}"] 
    else
      step %Q[check "ratings_#{rating}"]
    end
  end
end

Then /^I should see all of the movies$/ do
  rows = page.find("table#movies/tbody").all('tr')
  table = rows.map { |r| r.all('td').map { |c| c.text } }
  assert table.count.should == Movie.count
end

Then /^I should see none of the movies$/ do
  rows = page.find("table#movies/tbody").all('tr')
  table = rows.map { |r| r.all('td').map { |c| c.text } }
  assert table.count.should == 0
end

Then /^the director of "(.*)" should be "(.*)"$/ do |movie, director|
  assert step %Q[I should see "Details about #{movie}"]
  assert step %Q[I should see "Director: #{director}"]
end
