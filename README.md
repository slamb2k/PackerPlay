# PackerPlay
Experimenting with state configuration management tools. Packer, Azure Automation and DSC to start with...

Told you I would go and sort this out…

After some research and a few calls to IT Pros, this is the recommendation…

1. Use Packer to create a custom image that is sys prepped and ready for deployment. This will provide consistency, immutable provisioning and optimised deployment times.

What’s the advantages of creating an image with Packer?

- It’s based on the marketplace image so you know it patched fully.
- A majority of the VM settings can be specified in the builder config.
- Further configuration, package installation, user creation or application code deployment can occur when the provisioner is executed. 
- It will be available for anyone to install from the Azure portal, REST API, PowerShell or Azure CLI.

The entire Packer image generation process can be automated with VSTS build tasks and the Packer templates continuously integrated out of version control. 

2.	Now that the base image is established, any further customisation can be achieved using the VM extensions. Of particular interest is the Custom Script extension. While this is straight-forward to use manually and allows significant flexibility, the focus should still be on automation and a creation of a continuous build pipeline.

How can VM extensions be used?

- The extensions can be executed using the Azure CLI, PowerShell, the Azure portal or the REST API.
- The custom script extension also integrates with ARM templates and can be executed after provisioning resources.
- Scripts can be downloaded from Azure storage or GitHub, or provided to the Azure portal at extension run time.
- DSC extensions can be executed as a part of Azure Resource Management template execution. 

3.	In order to regularly maintain our images, we can use Automation Accounts to update state configuration of our VMs.

- Role-based access control - Control access to the account with an Automation operator role that enables tasks to be run without giving authoring capabilities.
- Variables - Provide a way to hold content that can be used across runbooks and configurations. You can change values without having to modify any of the runbooks and configurations that reference them.
- Credentials - Securely store sensitive information that can be used by runbooks and configurations at runtime.
- Certificates - Store and make available at runtime so they can be used for authentication and securing deployed resources.
- Connections - Store a name / value pairs of information that contains common information when connecting to systems in connection resources. Connections are defined by the module author for use at runtime in runbooks and configurations.
- Schedules - Used in the service to trigger automation on predefined times.
- Integration with source control - Promotes configuration as code where runbooks or configurations can be checked into a source control system.
- PowerShell modules - Modules are used to manage Azure and other systems. Import into the Automation account for Microsoft, third party, community, or custom defined cmdlets and DSC resources.

Automation manages the entire lifecycle of the infrastructure, ensures consistency and reports on compliance drift.
 
With the three activities detailed above we take control of of the critical aspects of resource state configuration management.

:one: With Packer the initial provisioning of a VMs can be automated, governed and monitored just like any application code the team creates.

:two: Using VM extensions we can simply and effectively provide customisations and additions to the VM state without requiring constant rebuilding and redeploying of the VM image.

:three: Finally, we can use the state definitions that we are creating to deploy the required components to additionally monitor and ensure that VMs remain within the desired parameters.
