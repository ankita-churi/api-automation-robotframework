*** Settings ***
Library    Collections
Library    RequestsLibrary
Library    OperatingSystem
Library    ../external_keywords/PythonUtilities.py

*** Keywords ***
Setup Session
    [Arguments]    ${service_name}
    ${key}=    Set Variable    ${service_name}_${ENV}
    ${base_url}=    Get From Dictionary    ${BASE_URL}    ${key}
    Create Session    ${service_name}    ${base_url}
    RETURN    ${base_url}

Call GET API
    [Arguments]    ${base_url}    ${endpoint}    ${params}  ${alias}  ${expected_status}
    ${resp}=    GET On Session    ${alias}    ${endpoint}    params=${params}   expected_status=${expected_status}  timeout=30
    Log    Response: ${resp.status_code} - ${resp.text}
    RETURN    ${resp}

Read Testdata From Json
    [Arguments]    ${testname}
    ${value}=    get_test_data_field    ${testname}  # Renamed—no collision
    Log    DEBUG: Extracted for '${testname}': ${value}
    RETURN    ${value}
