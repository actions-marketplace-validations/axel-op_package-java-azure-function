# Package an Azure Function in Java

A GitHub Action to package an Azure Function in Java with Maven.

This action uses the [`azure-functions-maven-plugin`](https://github.com/microsoft/azure-maven-plugins/tree/develop/azure-functions-maven-plugin).

## Inputs/outputs

### Inputs

- `function-name` (**required**): the name of the function app.
- `working-directory`: the root directory of the function.

### Outputs

- `deployment-directory`: absolute path to the directory containing the files to deploy (see usage in the example below).
- `deployment-file`: absolute path to the ZIP file that should be deployed in case of a [ZIP deployment](https://learn.microsoft.com/en-us/azure/azure-functions/deployment-zip-push).

## Example workflow

This GitHub Actions workflow shows how to deploy an Azure Function using the GitHub Action [`Azure/functions-action`](https://github.com/Azure/functions-action):

```yml
name: Example workflow

on:
  push:
    branches:
      - main

jobs:
  deploy-azure-function:
    runs-on: ubuntu-latest
    env:
      FUNCTION_NAME: name-of-function
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-java@v2
        with:
          java-version: 11
          distribution: adopt
      - uses: axel-op/package-java-azure-function@main
        id: package
        with:
          function-name: ${{ env.FUNCTION_NAME }}
      - name: Deploy on Azure
        uses: Azure/functions-action@v1
        with:
          app-name: ${{ env.FUNCTION_NAME }}
          package: ${{ steps.package.outputs.deployment-directory }}
          publish-profile: ${{ secrets.AZURE_PUBLISH_PROFILE }}
          scm-do-build-during-deployment: true
```
