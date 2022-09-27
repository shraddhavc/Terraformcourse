## Authenticating Azure from Terraform

### 1. Authenticating using az cli
```
az login
az account list
az account set --subscription <SUBSCRIPTION_ID>
az account show
```


### 2. Authenticating using environment variables (SP, MSI)

```
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"
```

- Using SP
    - Windows PS
        ```
        $Env:ARM_CLIENT_ID = "<APPID_VALUE>"
        $Env:ARM_CLIENT_SECRET = "<PASSWORD_VALUE>"
        $Env:ARM_SUBSCRIPTION_ID = "<SUBSCRIPTION_ID>"
        $Env:ARM_TENANT_ID = "<TENANT_VALUE>"
        ```

    - Windows CMD
        ```
        set ARM_CLIENT_ID = "<APPID_VALUE>"
        set ARM_CLIENT_SECRET = "<PASSWORD_VALUE>"
        set ARM_SUBSCRIPTION_ID = "<SUBSCRIPTION_ID>"
        set ARM_TENANT_ID = "<TENANT_VALUE>"
        ```

    - MAC/Linux
        ```
        export ARM_CLIENT_ID="<APPID_VALUE>"
        export ARM_CLIENT_SECRET="<PASSWORD_VALUE>"
        export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
        export ARM_TENANT_ID="<TENANT_VALUE>"
        ```

### Assignment: 
Try to authenticate using different methodes as given in the documentation
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#authenticating-to-azure


## How to call azure apis?
Get the access token and sunscription id.
```
token=$(az account get-access-token | jq -r ".accessToken")
subscriptionId=$(az account show | jq ".id" -r)
```
Azure api to get list of resource groups
```
curl -s -X GET -H "Authorization: Bearer ${token}" -H "Content-Type:application/json" -H "Accept:application/json" \
https://management.azure.com/subscriptions/${subscriptionId}/resourcegroups?api-version=2021-04-01 | jq -r ".value[].name"
```
Azure api to create a resoure group
```
resourceGroupName=my-demo-rg

curl -i -X PUT -H "Authorization: Bearer ${token}" -H "Content-Type:application/json" -H "Accept:application/json" \
https://management.azure.com/subscriptions/${subscriptionId}/resourcegroups/${resourceGroupName}?api-version=2021-04-01 \
--data '{"location": "westeurope", "tags": {"CostCenter": "15256-12"}}'
```
Azure api to create a resoure group
```
resourceGroupName=my-demo-rg

curl -i -X DELETE -H "Authorization: Bearer ${token}" -H "Content-Type:application/json" -H "Accept:application/json" \
https://management.azure.com/subscriptions/${subscriptionId}/resourcegroups/${resourceGroupName}?api-version=2021-04-01
```

