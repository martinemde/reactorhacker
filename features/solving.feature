Feature: Solve a word set
  In order to hack the computer
  a game player
  wants to type in the words and solve the puzzle

  Scenario: Short word set
    Given I am on the home page
    When I fill in the word set with:
      """
      tells
      lance
      typed
      truly
      tanks
      trick
      males
      taken
      those
      """
    And I press "Solve"
    Then I should see "I suggest you pick MALES."
    And I should see "How many correct?"
    When I fill in "How many correct?" with "2"
    And I press "Pick"
    Then I should see "TELLS"
    And I should see "TANKS"
    And I should see "TAKEN"
    Then I should see "I suggest you pick TAKEN."
    And I should see "How many correct?"
    When I fill in "How many correct?" with "1"
    And I press "Pick"
    Then I should see "Solved! The answer is TELLS."
    When I press "Erase & Start Over"
    Then I should be on the homepage
    And the "Word Set" field should contain ""
