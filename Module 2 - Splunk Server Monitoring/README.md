## Task-1 : Enable the Monitoring Console
1. In Splunk Web, navigate to Settings > Monitoring Console.
Look for the Monitoring Console icon on the left side of the Settings menu.

2. On the Monitoring Console navigation bar (the dark grey bar found under the black Splunk
Web navigation bar) click Settings > General Setup.

3. Verify the server name and make a note of the discovered server roles.

4. To complete the app setup, click Apply Changes > Go to Overview.

5. On the Overview page, review the following:
• Monitoring Console is running in standalone mode.

## Task-2 : Start and view Health Check for your Splunk server.

6. From the Monitoring Console, click Health Check.

7. Click Start to view the current results for the instance. Wait until the health check has completed. For the lab environment ignore any warnings, and just confirm that other components are operational.

8. Click the green information (i) icon next to your name to check the health status of splunkd.

You should see that the health reports show green.

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