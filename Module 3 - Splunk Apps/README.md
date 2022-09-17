## Task-1 : Explore Splunk apps on Splunkbase.
In this task, you explore the Splunkbase website and view some of the Splunk apps currently available on that site.
1. Visit https://splunkbase.splunk.com/. (Note that to download any apps from Splunkbase, you first need a Splunk.com account. You do not need to create a Splunk.com account for this exercise.)
2. Find and click on See All Apps:
3. Search for apps that meet the following criteria:

    • Categories: IT Operations

    • App Type: App (no add-ons)

    • Splunk Version: 8.1

    • Splunk Built & Other: Splunk Supported

## Task-2 : Install the class app.
In this task, you install a custom Splunk app from a file and change the permissions of the app so that only the
admin role has read and write access.

5. For this exercise, download the sample app (admin81.spl) from https://splk.it/edu-sysadmin-81.
6. In Splunk Web, navigate to Settings > Indexes and note the indexes that are currently configured for this instance.
    
    You should see a number of internal indexes starting with an underscore (_), such as _internal and _thefishbucket. There are also some default indexes, such as main.

7. In Splunk Web, navigate to Apps > Manage Apps page. Alternatively, click the gear icon () if you are on the Home page (launcher).
8. Click Install app from file > Choose File to locate the admin81.spl file you downloaded in step 5.
9. Click Upload.
    Notice on the Apps page that System Admin 8.1 Class App now appears in the list.

10. In Splunk Web, navigate to Settings > Indexes.

Notice that a new index called “websales” has been installed.

11. Navigate to the Apps > System Admin 8.1 Class App.

System Admin 8.1 Class App is listed on the Home page as well as under the Apps dropdown.

12. Click Apps > Manage Apps.
13. For the System Admin 8.1 Class App, click Permissions.
14. Configure the permissions so only the admin role has Read and Write permissions.

15. Click Save.
NOTE: To be able to click on the checkboxes for admin, you will first need to uncheck Read and Write
permissions for Everyone.

## Task-3 : Update the initial trial license to an Enterprise license.

9. In Splunk Web, select Settings > Licensing to access the Licensing page.
    
    What license group is your server currently configured to use? Trial license group
10. Get a temporary Splunk license to use for testing in this lab.

You need the splunk.license.big.license file on your local system. In this exercise, there are two
ways to obtain the required license file (choose one):

    • Download it from https://splk.it/edu-lab-licenses.
    • Check with your instructor if your class is using an alternate source to obtain the license.
11. From the Licensing page, click Add license.

12. Click Choose File and locate the file downloaded to your local system: splunk.license.big.license
13. Click Open and then click Install.
14. Click Restart Now > OK.
15. After the restart, log back into Splunk Web with user admin and your assigned password, navigate back to the Licensing page, and answer the following questions:
What license group is your server configured to use now? Enterprise license group

What is the maximum daily index volume licensed for your environment now? 200 MB

## Task-4: Modify the license pool.
16. From the Licensing page, click the Edit link next to the auto_generated_pool_enterprise pool.

17. From Allocation, click A specific amount and set the allocation to 150 MB.
18. From Indexers, click Specific indexers.
19. From the Available indexers field, select your host and move it to the Associated indexers field.
20. Click Submit > OK.
21. Confirm the settings you have configured for this pool on the Licensing page.

## Task-5: Enable an alert to monitor the license usage.
22. Navigate to Settings > Monitoring Console and scroll down to the Alerts section of the Overview page
and click Enable or Disable.

23. Click the Enable next to the DMC Alert - Total License Usage Near Daily Quota alert.
24. To confirm, click Enable. An alert will be provided if 90% of your pool quota is consumed.
25. Click the Edit button next to the DMC Alert - Total License Usage Near Daily Quota alert.

26. Change the License Quota Usage to 80 and click Save. Notice the alert text was updated to show “80%”.

## Task-6: Create a Splunk diag file for a Splunk server using the command line.
27. From your Splunk server, generate a baseline diag file using the splunk diag command in a console
window.

```bash
cd /opt/splunk/bin/
./splunk diag
```

Happy Splunking..!!



Team - SplunkMania