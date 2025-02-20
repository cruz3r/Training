# Ways to connect to Azure 

Azure provides multiple resources / services going into individual things is not the goal of the first part of this. Let's go over the way's to connect to Azure
Terms to know
1. Tennant - Think of it as an organization (in AD we would have a single domain or multi domain forest.) You can have multiple Subscriptions in a tennant.
2. Subscriptions - Used for Billing. For each subscription you can have separate billing. A subscription falls under a Tennant / Microsoft Customer Agreement. This holds your resources at a high level.
3. Resources - Azure resources can be VM's, Networking' Services that MS Offers through Azure  
4. Azure Active Directory (AAD) vs Active Directory (AD) 
- AD is meant to manage on-premise infrastructure and applications.
- AAD Manages user access to cloud applications
5. Azure AD Connect - Used to connect your AD on premsie environment to the cloud AAD

1. Web portal.azure.com
- When you log on to the portal your connecting to a default subscription
- You may need to change your subscription if you are connected to multiple Subscriptions 
