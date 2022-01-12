**Description**

Creates a minimal VM in a vCenter host cluster, provisions, updates, then packages as a vCenter VM template for later deployments. 

**Prerequisites**

- VMware vCenter (7.0+) with a user account that has the appropriate permissions to run the job (Ref: https://www.packer.io/docs/builders/vsphere/vsphere-iso#required-vsphere-permissions)
- Windows Server 2022 ISO located on a datastore accessible to the host/cluster (Eval link below).
- A Windows, Mac, or other *Nix machine with Packer installed/available to run. Also consider adding the Packer executable to your system's path (especially if using this as part of Actions/CICD)

**Usage:**

General usage: `packer build <repo_path>/win2022.gui/` (modify the command as needed for *Nix vs Windows machines/runners)
Notes: 
- This assumes you change the variables in the corresponding `variables.pkr.hcl`. 
- This assumes the template does not already exist. Use the `-force` flag to destroy and recreate the template.
- Use the `-var` switch to pass precedence variables. Useful for running on GitHub Actions/Gitlab CICD using masked variables for sensitive data (env creds).

Windows Server 2022 eval ISO (for lab/development use): https://software-download.microsoft.com/download/sg/20348.169.210806-2348.fe_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso