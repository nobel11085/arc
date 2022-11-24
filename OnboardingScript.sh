
export subscriptionId="0d7951be-fd37-4c23-9cd9-71a6684c1a9e";
export resourceGroup="SHM_ARC";
export tenantId="0b1fe380-1e00-4fd5-a92d-acd5dd364a5f";
export location="westeurope";
export authType="token";
export correlationId="f8ad730a-3f75-44d2-a547-fbfc2195cc90";
export cloud="AzureCloud";

# Download the installation package
output=$(wget https://aka.ms/azcmagent -O ~/install_linux_azcmagent.sh 2>&1);
if [ $? != 0 ]; then wget -qO- --method=PUT --body-data="{\"subscriptionId\":\"$subscriptionId\",\"resourceGroup\":\"$resourceGroup\",\"tenantId\":\"$tenantId\",\"location\":\"$location\",\"correlationId\":\"$correlationId\",\"authType\":\"$authType\",\"messageType\":\"DownloadScriptFailed\",\"message\":\"$output\"}" "https://gbl.his.arc.azure.com/log" &> /dev/null || true; fi;
echo "$output";

# Install the hybrid agent
bash ~/install_linux_azcmagent.sh;

# Run connect command
sudo azcmagent connect --resource-group "$resourceGroup" --tenant-id "$tenantId" --location "$location" --subscription-id "$subscriptionId" --cloud "$cloud" --tags "Datacenter=Advania,City=Stockholm,StateOrDistrict=Stockholm,CountryOrRegion=Sweden" --correlation-id "$correlationId";
