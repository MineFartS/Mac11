# Mac11
### Create a Windows 11 Installer USB for Intel Macs

---

## Requirements:
- Intel Mac
- USB Flash Drive (at least 8GB)
- Computer running windows 10/11

## Instructions:
1. Create a <a href="https://github.com/MineFartS/tiny11">tiny11</a> image.
2. Mount the ISO image using Windows Explorer.
3. Insert a USB Drive with at least 8GB
4. Open PowerShell as Administrator. 
5. Start the script :
```powershell
irm https://raw.githubusercontent.com/MineFartS/mac11/refs/heads/main/run.ps1 | iex
``` 
6. Follow the instructions given.
7. Sit back and relax :)