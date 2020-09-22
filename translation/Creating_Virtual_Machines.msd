Task 1: Create a utility virtual machine with the Name UTILITY_VM 
        Run the command In Cloud Shell:
        gcloud beta compute --project=qwiklabs-gcp-00-a05c0fd29986 instances create utility-vm --zone=us-central1-c --machine-type=n1-standard-1 --subnet=default --network-tier=PREMIUM --maintenance-policy=MIGRATE --service-account=888277796849-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --image=debian-10-buster-v20200910 --image-project=debian-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=utility-vm --no-shielded-secure-boot --no-shielded-vtpm --no-shielded-integrity-monitoring --reservation-affinity=any 


Task 2: Create a Windows virtual machine with the Name UTILITY_VM_EU
      Run the command In Cloud Shell:
      gcloud beta compute --project=qwiklabs-gcp-00-a05c0fd29986 instances create utility-vm-eu --zone=europe-west2-a --machine-type=n1-standard-2 --subnet=default --network-tier=PREMIUM --maintenance-policy=MIGRATE --service-account=888277796849-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --tags=http-server,https-server --image=windows-server-2016-dc-core-v20200908 --image-project=windows-cloud --boot-disk-size=100GB --boot-disk-type=pd-ssd --boot-disk-device-name=utility-vm-eu --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any
      gcloud compute --project=qwiklabs-gcp-00-a05c0fd29986 firewall-rules create default-allow-http --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=http-server
      gcloud compute --project=qwiklabs-gcp-00-a05c0fd29986 firewall-rules create default-allow-https --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:443 --source-ranges=0.0.0.0/0 --target-tags=https-server
      
      Set the password for the VM
        Click on the name of your Windows VM to access the VM instance details.
        You don't have a valid password for this Windows VM: you cannot log in to the Windows VM without a password. Click Set Windows password.
        Click Set.
        Copy the provided password, and click CLOSE.
 
 Task 3: Create a custom virtual machine with the Name UTILITY_VM_US
          Run the command In Cloud Shell:
          gcloud beta compute --project=qwiklabs-gcp-00-a05c0fd29986 instances create utility-vm-us --zone=us-west1-b --machine-type=e2-custom-6-32768 --subnet=default --network-tier=PREMIUM --maintenance-policy=MIGRATE --service-account=888277796849-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --image=debian-10-buster-v20200910 --image-project=debian-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=utility-vm-us --no-shielded-secure-boot --no-shielded-vtpm --no-shielded-integrity-monitoring --reservation-affinity=any
          
          
            Connect via SSH to your custom VM
            For the custom VM you just created, click SSH.

            To see information about unused and used memory and swap space on your custom VM, run the following command:
            free
            
            To see details about the RAM installed on your VM, run the following command:
            sudo dmidecode -t 17
            
            To verify the number of processors, run the following command:
            nproc
            To see details about the CPUs installed on your VM, run the following command:
            lscpu
            
            To exit the SSH terminal, run the following command:
            exit
 
 
