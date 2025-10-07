*** Settings ***
Documentation    PurgoMalum API Automation Suite
Variables        ../config/variables.json
Resource         ../Resources/PurgomalumAPI.robot
Library    Collections

Suite Setup  Initialize Suite
Suite Teardown    Delete All Sessions


*** Variables ***
${SESSION_NAME}    purgomalum

*** Keywords ***
Initialize Suite
    ${base_url} =  Setup Session  purgomalum
    Set Suite Variable    ${BASE_URL}    ${base_url}
    Log Many    ENV=${ENV}    BASE_URL=${BASE_URL}

*** Test Cases ***

TC01 [+ve] Clean text with no profanity
    [Tags]    smoke    regression
    ${response}=    Run Profinity API    ${testname}  ${base_url}   /service/plain  ${SESSION_NAME}
    Validate Text Response    ${response}    ${testname}


TC02 [+ve] Custom word censored with default value *
    [Tags]  smoke  regression
    ${response} =  Run Profinity API    ${testname}  ${base_url}  /service/json  ${SESSION_NAME}
    Validate Json Response   ${response}  ${testname}  result

TC03 [+ve] Custom word via Multiple Add params
    [Tags]  smoke  regression
    ${response} =  Run Profinity API    ${testname}  ${base_url}  /service/json  ${SESSION_NAME}
    Validate Json Response   ${response}  ${testname}  result

TC04 [+ve] Custom word censored with fill_text
    [Tags]  smoke  regression
    ${response} =  Run Profinity API    ${testname}   ${base_url}  /service/json  ${SESSION_NAME}
    Validate Json Response   ${response}  ${testname}  result

TC05 [+ve] Custom word censored with fill_char
    [Tags]  smoke  regression
    ${response} =  Run Profinity API    ${testname}  ${base_url}  /service/json  ${SESSION_NAME}
    Validate Json Response   ${response}  ${testname}  result

TC06 [+ve] Valid request with max allowed add words (10) and fill_char
    [Tags]  smoke  regression
    ${response} =  Run Profinity API    ${testname}  ${base_url}  /service/json  ${SESSION_NAME}
    Validate Json Response   ${response}  ${testname}  result

TC07 [-ve] Missing required text parameter
    [Tags]  smoke  regression
    ${response} =  Run Profinity API    ${testname}  ${base_url}  /service/json  ${SESSION_NAME}
    Validate Json Response   ${response}  ${testname}  jsonpath=error

TC08 [-ve] Invalid characters in add parameter
    [Tags]  smoke  regression
    ${response} =  Run Profinity API    ${testname}  ${base_url}  /service/json  ${SESSION_NAME}
    Validate Json Response   ${response}  ${testname}  jsonpath=error

TC09 [-ve] Invalid fill_text with unsupported symbol
    [Tags]  smoke  regression
    ${response} =  Run Profinity API    ${testname}  ${base_url}  /service/json  ${SESSION_NAME}
    Validate Json Response   ${response}  ${testname}  jsonpath=error

TC10 [-ve] Exceeding max length for fill_text (>20 chars)
    [Tags]   regression
    ${response} =  Run Profinity API    ${testname}  ${base_url}  /service/json  ${SESSION_NAME}
    Validate Json Response   ${response}  ${testname}  jsonpath=error

TC11 [-ve] Invalid fill_char with unsupported symbol
    [Tags]  regression
    ${response} =  Run Profinity API    ${testname}  ${base_url}  /service/plain    ${SESSION_NAME}
    Validate Text Response   ${response}  ${testname}

TC12 Contains Profanity Check
    [Documentation]    Verify that the text contains profanity
    [Tags]    smoke  regression

    ${response} =  Run Profinity API    ${testname}  ${base_url}  /service/containsprofanity    ${SESSION_NAME}
    Should Be Equal    ${response.text}    true

TC13 XML Response Check
    [Tags]  smoke  regression
    ${response} =  Run Profinity API    ${testname}  ${base_url}  /service/xml    ${SESSION_NAME}
    Log    Response text: ${response.text}
