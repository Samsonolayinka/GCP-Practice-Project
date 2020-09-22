Task 1: Deploy a web server VM instance

    Create VM instanc `us-central1-a` zone and  a `debian-9-stretch` image, run:

    ```
    gcloud compute instances create cutomerhost \
    --zone us-central1-a \
    --machine-type e2-medium \
    --image-project debian-cloud \
    --image debian-9-stretch-v20200910 \
    --subnet default \
    --metadata startup-script="apt-get update; apt-get install apache2 php php-mysql -y; service apache2 restart;"
    ```

   
    We are going to `allow HTTP` traffic to our VM instance, run:

         ```
         gcloud compute firewall-rules create default-allow-http \
         --direction=INGRESS \
         --priority=1000 \
         --network=default \
         --action=ALLOW \
         --rules=tcp:80 \
         --source-ranges=0.0.0.0/0 \
         --target-tags=http-server
         ```

    
    To apply the firewall rule to our VM instance, run:

    ```
    gcloud compute instances add-tags cutomerhost --tags http-server
    ```

Task 2: Create a Cloud Storage bucket using the gsutil command line

   Create a storage bucket in US location, run:

   ```
   gsutil mb -l US gS://$DEVSHELL_PROJECT_ID
   ```

   Copy image to our storage bucket.
   
   ```
   gsutil cp gs://cloud-training/gcpfci/my-excellent-blog.png gs://$DEVSHELL_PROJECT_ID/my-excellent-blog.png
   ```

    Verify item was copied.
   To check that the image was copied to our storage bucket, run:

   ```
   gsutil ls -l gs://$DEVSHELL_PROJECT_ID/
   ```

   Make image accessible public
   To make the image publicly available to everyone we wil adjust the access control for our image, run:

   ```
   gsutil acl ch -u allUsers:R gs://$DEVSHELL_PROJECT_ID/my-excellent-blog.png
   ```

Create the Cloud SQL instance

   Create a `MySQL cloud SQL instance `wbsite-db` with root password set to `mypassword`and in the`us-central1-a` zone.

   ```
   gcloud sql instances create wbsite-db  --root-password mypassword  --zone us-central1-a --database-version MYSQL_5_6
   ```

Create a user in our instance
  
   ```
   gcloud sql users create root --instance wbsite-db --host % --password mypassowrd
   ```

Update authorized networks
  
   ```
   export cutomerhost_xip=$(gcloud compute instances describe cutomerhost --zone us-central1-a --format 'get(networkInterfaces[0].accessConfigs[0].natIP)')
   ```

   - We are saving the `cutomerhost` vm external IP to `cutomerhost_xip` external environment variable. We will reference it later.

   add the IP address to the `blog-db` instance authorized networks, run:

   ```
   gcloud sql instances patch blog-db --authorized-networks $cutomerhost_xip/32 --quiet
   ```

   - The command adds our vm external IP into the authorized address on our SQL instance.

Configure an application in Compute Engine instance to use Cloud SQL

SSH into `cutomerhost` vm

```
gcloud compute ssh cutomerhost --zone us-central1-a --quiet
```

Navigate to the web server index file
   Switch the command prompt path server default html directory, run:

   ```
   cd /var/www/html
   ```

Open the `index.php` to edit it
   Using nano lets to create and edit the `index.php` file, run:

   ```
   sudo nano index.php
   ```

   Paste in the following content into the file:

   ```php
   <html>
   <head><title>Welcome to my excellent blog</title></head>
   <body>
   <h1>Welcome to my excellent blog</h1>
   <?php
   $dbserver = "CLOUDSQLIP";
   $dbuser = "root";
   $dbpassword = "root";
   
   $conn = new mysqli($dbserver, $dbuser, $dbpassword);
   if (mysqli_connect_error()) {
    echo ("Database connection failed: " . mysqli_connect_error());
   } else {
    echo ("Database connection succeeded.");
   }
   ?>
   </body></html>
   ```

   - Replace the `root` with your instance password, fo rour case this will be `1234567`
   - To get the IP address for the `blog-db` sql instance. Open another tab and run:

     ```
     gcloud sql instances describe blog-db --format 'get(ipAddresses.ipAddress)'
     ```
