# Mac11
### Create a Windows 11 Installer USB for Intel Macs

---

## Instructions:
1. Download Windows 11 from the <a href="https://www.microsoft.com/en-us/software-download/windows11#:~:text=Download Windows 11 Disk Image">Microsoft website</a>
2. [OPTIONAL] Convert the windows 11 image to <a href="https://github.com/MineFartS/tiny11">tiny11</a>
3. Mount the downloaded ISO image using Windows Explorer.
4. Insert a USB Drive with at least 8GB
5. Open PowerShell as Administrator. 
6. Start the script :
```powershell
irm https://raw.githubusercontent.com/MineFartS/mac11/refs/heads/main/run.ps1 | iex
``` 
7. Follow the instructions given.
8. Sit back and relax :)