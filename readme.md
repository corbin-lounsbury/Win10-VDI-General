**Description**

Creates a Windows 10 VDI VM in a vCenter host cluster, provisions, updates, then packages as a vCenter VM template for later deployments. 

**Prerequisites**

- VMware vCenter (7.0+) with a user account that has the appropriate permissions to run the job (Ref: https://www.packer.io/docs/builders/vsphere/vsphere-iso#required-vsphere-permissions)
- Windows 10 ISO located on a datastore accessible to the host/cluster. Currently tested working with build 21H2 (Eval link below).
- A Windows, Mac, or other *Nix machine with Packer installed/available to run. Also consider adding the Packer executable to your system's path (especially if using this as part of Actions/CICD)

**Usage:**

General usage: `packer build <repo_path>/win10.vdi/` (modify the command as needed for *Nix vs Windows machines/runners)
Notes: 
- This assumes you change the variables in the corresponding `variables.pkr.hcl`. 
- This assumes the template does not already exist. Use the `-force` flag to destroy and recreate the template.
- Use the `-var` switch to pass precedence variables. Useful for running on GitHub Actions/Gitlab CICD using masked variables for sensitive data (env creds).

Windows 10 eval ISO (for lab/development use): https://software-download.microsoft.com/download/sg/444969d5-f34g-4e03-ac9d-1f9786c69161/19044.1288.211006-0501.21h2_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso