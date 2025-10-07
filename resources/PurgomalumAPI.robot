*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Resource    API_Utilities.robot

*** Keywords ***
Run Profinity API
    [Arguments]    ${testname}  ${base_url}  ${endpoint}  ${alias}=${SESSION_NAME}
    ${data}=        Read Testdata From Json    ${testname}
    ${params}=        Create Dictionary    text=${data["text"]}
    Run Keyword If    'add' in ${data}          Set To Dictionary    ${params}    add=${data["add"]}
    Run Keyword If    'fill_text' in ${data}    Set To Dictionary    ${params}    fill_text=${data["fill_text"]}
    Run Keyword If    'fill_char' in ${data}    Set To Dictionary    ${params}    fill_char=${data["fill_char"]}

    ${exists}=    Run Keyword And Return Status    Session Exists    ${alias}
    Run Keyword If    not ${exists}    Create Session    ${alias}    ${base_url}
    ${response}=        Call GET API    ${base_url}    ${endpoint}    ${params}   ${alias}  expected_status=200
    RETURN   ${response}

Validate Json Response
    [Arguments]    ${response}  ${expected}  ${jsonpath}
    ${data}=        Read Testdata From Json    ${testname}
    ${response_json}=    Evaluate    json.loads('''${response.text}''')    modules=json
    ${actual_result}=    Get From Dictionary    ${response_json}    ${jsonpath}
    Log    Actual: '${actual_result}' | Expected: '${data["expected"]}'
    Should Be Equal    ${actual_result}    ${data["expected"]}

Validate Text Response
    [Arguments]    ${response}    ${expected}
    ${data}=        Read Testdata From Json    ${testname}
    Log    Actual: '${response.text}' | Expected: '${data["expected"]}'
    Should Be Equal    ${response.text}    ${data["expected"]}

