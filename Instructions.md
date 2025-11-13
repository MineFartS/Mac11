# Mac11
## Instructions:

---

1. Open a separate computer running windows 10/11

2. Acquire a <a href="https://github.com/MineFartS/tiny11">tiny11</a> image.

3. Mount the tiny11 ISO using Windows Explorer.

4. Insert a USB Drive with at least 8GB

5. Open PowerShell as Administrator.

6. Run the builder script on the separate computer:
```powershell
irm https://raw.githubusercontent.com/MineFartS/mac11/refs/heads/main/build.ps1 | iex
``` 

7. Follow the instructions given and wait for script to complete.

8. Unplug the flash drive from your computer and plug it into the mac

9. Turn on the mac while holding *Option/Alt* to open the boot menu

10. Select the usb drive to boot into the installer

11. Navigate through the windows installer *(It uses the windows 10 installer, but it will innstall windows 11)*

12. Follow the onscreen instructions to install windows and wait for the installation to complete

13. Once windows boots into the OOBE, press *shift+f10* or *shift+fn+f10* to open the command prompt

14. In the command prompt window on the mac, enter the following commands:
```
Microsoft Windows [Version 10.0.22621.2283]
(c) Microsoft Corporation. All rights reserved.

C:\Users\Administrator>powershell
Windows PowerShell
Copyright (C) Microsoft Corporation. All rights reserved.

Install the latest PowerShell for new features and improvements! https://aka.ms/PSWindows

PS C:\Users\Administrator> Get-CimInstance -Class Win32_ComputerSystem

Name             PrimaryOwnerName     Domain               TotalPhysicalMemory  Model               Manufacturer
----             ----------------     ------               -------------------  -----               ------------
MACBOOKAIR       Phil                 philh.local          8382951424           MacBookAir9,1       Apple Inc.
```

15. Remember the **Model** for step 17/18 *(Ex: MacBookAir9,1)*

16. Plug a USB *(can be the same one as earlier)* into the seperate computer

17. On the separate computer, run the following script:
```powershell
irm https://raw.githubusercontent.com/MineFartS/mac11/refs/heads/main/bootcamp.ps1 | iex
``` 

18. Follow the instructions given and wait for script to complete.

19. Unplug the usb, and plug it into the mac.

20. Use the command prompt on the mac to open explorer
```powershell
PS C:\Users\Administrator> explorer
```

21. Navigate to the flash drive and run *setup.exe*

22. Wait for bootcamp to finish installing

23. Finish normal windows setup