*** Settings ***
Library                             SeleniumLibrary

*** Keywords ***
Begin Web Test
    Open browser                    about:blank     ${BROWSER}

Go To Web Page
    Load Page
    Verify Page Loaded

Load Page
    Go to                           ${URL}

Verify Page Loaded
    Wait until page contains        Infotiv Car Rental

Login
    [Arguments]                     ${username}     ${password}
    Username Input                  ${username}
    Password Input                  ${password}
    Click login
    Verify login

Username Input
    [Arguments]                     ${username}
    Click element                   xpath://*[@id="email"]
    Press keys                      xpath://*[@id="email"]      ${username}

Password Input
    [Arguments]                     ${password}
    Click element                   xpath://*[@id="password"]
    Press keys                      xpath://*[@id="password"]      ${password}

Click login
    Click button                    xpath://*[@id="login"]

Verify login
    Wait until page contains        You are signed in as Jonna

Choose startdate
    [Arguments]                     ${choose_start_date}    ${chosen_start_date}
    Click element                   xpath://*[@id="start"]
    Press keys                      xpath://*[@id="start"]      ${choose_start_date}
    Verify chosen startdate         ${chosen_start_date}

Verify chosen startdate
    [Arguments]                     ${chosen_start_date}
    ${actual_start_date}            Get value      id=start
    Should be equal                 "${chosen_start_date}"    "${actual_start_date}"

Choose enddate
    [Arguments]                     ${choose_end_date}    ${chosen_end_date}
    Click element                   xpath://*[@id="end"]
    Press keys                      xpath://*[@id="end"]      ${choose_end_date}
    Verify chosen enddate           ${chosen_end_date}

Verify chosen enddate
    [Arguments]                     ${chosen_end_date}
    ${actual_end_date}              Get value      id=end
    Should be equal                 "${chosen_end_date}"    "${actual_end_date}"

Click Continue
    Click button                    id:continue
    Verify Rental Dates Are Correct

Verify Rental Dates Are Correct
    ${actual_text}                  Get text    xpath://*[@id="questionText"]
    Should be equal                 "${actual_text}"   "What would you like to drive?"

Book car - Audi Q7
    Click button                    xpath://*[@id="bookQ7pass5"]
    Verify Car Selection - Audi Q7

Verify Car Selection - Audi Q7
    ${actual_text}                  Get text    xpath://*[@id="questionText"]
    Should be equal                 "${actual_text}"   "Confirm booking of Audi Q7"

Input CardNumber
    [Arguments]                     ${card_number}
    Click element                   xpath://*[@id="cardNum"]
    Press keys                      xpath://*[@id="cardNum"]      ${card_number}

Input CardName
    [Arguments]                     ${card_name}
    Click element                   xpath://*[@id="fullName"]
    Press keys                      xpath://*[@id="fullName"]      ${card_Name}

Choose CardMonth
    Click element                   xpath://*[@id="confirmSelection"]/form/select[1]
    Click element                   xpath://*[@id="month3"]
    Sleep                           1 seconds

Choose CardYear
    Click element                   xpath://*[@id="confirmSelection"]/form/select[2]
    Click element                   xpath://*[@id="month2022"]
    Sleep                           1 seconds

Input CVC
    Click element                   xpath://*[@id="cvc"]
    Press keys                      xpath://*[@id="cvc"]  542
    Sleep                           1 seconds

Confirm Credit Card
    Click button                    xpath://*[@id="confirm"]
    Wait until page contains        You can view your booking on your page

Confirm booking
    ${text_confirmation}            Get text    xpath://*[@id="questionTextSmall"]
    Should be equal                 "A Audi Q7 is now ready for pickup 2021-04-02"      "${text_confirmation}"

Clear all bookings
    Click button                    xpath://*[@id="mypage"]
    Click button                    xpath://*[@id="unBook1"]
    Handle alert
    Click button                    xpath://*[@id="mypage"]
    Wait until page contains        You have no bookings
    Verify no bookings left

Verify no bookings left
    ${actual_text}                  Get text    xpath://*[@id="historyText"]
    Should be equal                 "You have no bookings"      "${actual_text}"
    Sleep                           1 seconds

I have logged in with correct info
    Go To Web Page
    Login                           jonna.hagberg@iths.se       hagberg

I have chosen rental period
    Choose startdate                0402    2021-04-02
    Choose enddate                  0404    2021-04-04
    Click Continue

Chosen a car
    Sleep                           2 seconds
    Book car - Audi Q7

Entered my credit card info correctly
    Input CardNumber            0002223334445556
    Input CardName              Jonna Hagberg
    Choose CardMonth
    Choose CardYear
    Input CVC
    Confirm Credit Card

I should get a confirmation of the booking
    Confirm booking

End Web Test
    Clear all bookings
    Close browser