*** Settings ***
Library                     ImapLibrary2
Library                     QForce
Library                     String
Library                     Collections
Library                     re
Resource                    ../resources/gmail.resource

# imap.gmail.com:993

*** Test Cases ***
Email Verification
    [Documentation]    Sample test to read links from email message in Gmail
    ...                My Sample email with subject testi email contains two links to https://google.fi and https://google.com
    @{links}=   Get Links From Email    email=${email}   app_password=${app_password}   sender=${sender}   subject=${subject}

    FOR  ${link}  IN  @{links}
        Log To Console   ${link}
        # ...
    END
    
    Open Browser  ${links}[0]  chrome
    # do something on the page..
    Close Browser

    Open Browser  ${links}[1]  chrome
    # do something on the page..
    Close Browser
