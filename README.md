# api-automation-robotframework

## Overview
This repository contains automated API tests using **Robot Framework**.  
The tests cover the Purgmalum ( https://www.purgomalum.com)  and validate key functionality such as response validation, payload correctness, and error handling.

## Tech Stack Used
| Category                 | Technology / Tool          | Purpose                                   |
| ------------------------ | -------------------------- | ----------------------------------------- |
| **Language**             | Python 3.9.6               | Core programming language                 |
| **Automation Framework** | Robot Framework            | Test automation framework                 |
| **API Automation**       | Requests Library           | robotframework-requests,requests          |
| **Test Reporting**       | Robot Framework Reports    | Generates detailed test execution reports |
| **Version Control**      | Git & GitHub               | Source code management                    |
| **IDE**                  | PyCharm                    | Development and debugging                 |
| **Package Management**   | pip                        | Install and manage Python dependencies    |
| **CI/CD**                |  GitHub Actions            | Github Actions workflows                  |


## Prerequisites
Before running the tests locally, ensure the following:

- Python 3.10+
- Required Python libraries (see `requirements.txt`)
- pip install -r requirements.txt


## Git Clone the Repository:

- git clone https://github.com/ankita-churi/api-tests-automation-robotframework.git
- cd api-tests-automation-robotframework

## Running the Tests Locally
You can run tests with custom environment and tags:
  
robot --variable ENV:prod -i smoke -d reports tests/Test_PurgoMalum_API.robot
