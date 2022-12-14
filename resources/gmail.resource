*** Variables ***
${email}                    # add these as test suite varialbes
${app_password}             # make this hidden/crypted
${sender}
${subject}
# regular expression used to parse links from email
${url_regex}                http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+

# Used protocol
# https://developers.google.com/gmail/imap/imap-smtp
# # imap.gmail.com:993

# Setting the app password in Google
# https://support.google.com/accounts/answer/185833?hl=en

# Used libraries
# https://lasselindqvist.github.io/robotframework-imaplibrary2/doc/ImapLibrary2.html
# https://github.com/lasselindqvist/robotframework-imaplibrary2
# https://docs.python.org/3/library/re.html

*** Keywords ***
Get Links From Email
    [Documentation]         Open Inbox and read email body. Returns a list of links found in email.
    [Arguments]             ${email}                    ${app_password}     ${sender}             ${subject}
    Open Mailbox            host=imap.gmail.com         port=993            user=${email}         password=${app_password}
    ${latest} =             Wait For Email              sender=${sender}    subject=${subject}    timeout=300
    ${parts} =              Walk Multipart Email        ${latest}
    FOR                     ${i}                        IN                  ${parts}
        Walk Multipart Email                            ${latest}
        ${ctype}=           Get Multipart Content Type
        ${payload} =        Get Multipart Payload       decode=True
        @{links}=           re.findall                  ${url_regex}        ${payload}
        Log                 ${payload}
        Log                 ${links}
    END
    Close Mailbox
    [Return]                @{links}
