# AI Document Processor (ADP)

## Description
AI Document Processor Accelerator is designed to help companies leverage LLMs to automate document and file processing tasks. The accelerator uses bicep templates to provision Azure Function App, Storage account, and static web app to manage your documents life cycle from raw PDF, word doc, or .mp3, extract meaningful entities and insights, and write an output report, CSV, or JSON to a blob storage container. 

## Business Value
- *Developer Foundation* -  AI Document Processor is intended to serve as an initial foundation to build your workflow on top of. Developers can write custom logic within the azure functions and leverage existing utility functions to write to blob and call Azure OpenAI models.
- *Business User UI* - Business users can leverage the UI to update prompts and files to immediately test the results.
- *Automated Infrastructure Provisioning* - The bicep templates spin up the required infrastructure and builds a deployment pipeline for Azure Functions and the Static Web App 
- *RBAC Configuration* - The bicep templates spin up infrastructure with managed identities and appropriate access to reduce initial overhead tasks such as granting permissions between services. 

## Resources
- Azure OpenAI
- Azure Function App
- App Service Plan
- Azure Storage Account
- Azure Static Web App
- Key Vault
- Application insights

## Pre-Requisites
- az cli
- azd cli
- npm 9.x.x
- node 18.x.x
- Python 3.11
  
## Instructions

1. Fork repo to your GH account
2. Clone your forked repo
3. To deploy bicep template run:
  - azd auth login
  - az login
  - azd up
  - Enter your forked GH repo link `https://github.com/{your_user_name}/llm-doc-processing`
  - Enter your User Principal ID when prompted
  - To get your User principal ID run `az ad signed-in-user show --query id -o tsv`

2. After deployment is complete configure Static Web App
   - Navigate to **"Configuration"**
   - Switch **Deployment Authorization Policy** to Github
   - Enter "./webapp/frontend/" in the **App Location** field
   - Ensure the **Api Location** field is empty
   - Enter "dist" in the **App artifact location** field
   - Click **Apply**
   - GH Actions workflow should be created in your GH repo
  


##  MIT License
https://opensource.org/license/MIT 

Copyright (c) 2025 Mark Remmey

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

