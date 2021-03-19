*** Settings ***
Documentation               Lab 2 - VG Del - Jonna Hagberg
Resource                    ../Resources/keywords.robot
Library                     SeleniumLibrary
Suite Setup                 Begin Web Test
Suite Teardown              End Web Test

*** Variables ***
${BROWSER}                  headlesschrome
${URL}                      http://rental12.infotiv.net/


*** Test Cases ***
Complete test of booking a car
    [Documentation]             Testar hela flödet att logga in, boka bil och få det bekräftat
    [Tags]                      Complete    Booking
    Given I have logged in with correct info
    When I have chosen rental period
    And Chosen a car
    And Entered my credit card info correctly
    Then I should get a confirmation of the booking
