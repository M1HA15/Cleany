# 🧹 Cleany

## 🚀 Introduction:
Cleany is a powerful script designed to streamline the cleanup process on Windows systems, optimizing performance and freeing up disk space. This script is intended for users with administrator privileges and leverages PowerShell to perform various system maintenance tasks.

## 💻 Key Features
- 🔰 **Administrator Privileges and PowerShell Check**: Ensures seamless execution by verifying that the script is run with administrator privileges and within a PowerShell environment. This script leverages PowerShell for efficient system cleanup tasks.

- ⚒️ **Comprehensive System Cleanup Tasks:**
  - **Deleting Temporary Files:** Clears unnecessary temporary files to free up disk space.
  - **Restarting Explorer:** Enhances system performance by restarting the Explorer process.
  - **Stopping Services:** Temporarily halts specified services to facilitate cleanup.
  - **Deleting Windows Update Files:** Removes unnecessary files related to Windows updates.
  - **Cleaning System Logs:** Removes unnecessary log files to maintain system health.
  - **Running Windows Cleaner:** Initiates cleanmgr.exe for additional system cleanup.

- 🤝 **User-Friendly Restart Option**: After completing the cleanup tasks, the script provides a user-friendly prompt, allowing users to restart their computers for the changes to take full effect.

## ⚙️ Usage:
1. **📁 Download:**
Get the latest version of the script from the [Releases](https://github.com/M1HA15/Cleany/releases) page.

2. **🛡️ Run with Administrator Privileges:**
   ```bash
   > Cleany.bat
   ```

3. **🚨 Evaluate Risks & Choose to Proceed:**
   ```bash
   Would you like to continue?
     [1] Yes
     [2] No
     [3] View potential risks
     [4] Create a Restore Point

   Enter your choice (1-4): 3


   ---------------------------------------------------------------------
                         POTENTIAL RISKS
   ---------------------------------------------------------------------
   1. Deleting system files may cause instability or loss of data.
   2. Stopping essential services can affect system functionality.
   3. Restarting Explorer may temporarily interrupt desktop experience.
   4. Cleaning system logs may impact troubleshooting capabilities.
   5. Deleting Windows Update files might affect future updates.
   ---------------------------------------------------------------------



   Would you like to continue?
     [1] Yes
     [2] No
     [3] View potential risks
     [4] Create a Restore Point

   Enter your choice (1-4): 1

   Proceeding with the script...
   ```

4. **📢 Explore the author's other project (Optional):**
   ```bash
   Want to check out our other project? (Y/N): Y
   Opening default web browser...
   ```

5. **🌌 Restart (Optional):**
If you wish to do so, please restart your computer to apply the cleanup changes.
     ```bash
     Do you want to restart the computer now? (Y/N): Y
     We appreciate you using the script. Your computer will restart shortly!
     ```

## ⚠️ Disclaimer
This script is provided as-is, and the author takes no responsibility for any damage, loss of data, or unforeseen consequences caused by its usage. Additionally, be sure to understand the implications of the cleanup tasks, including potential risks associated with deleting system files, stopping essential services, and other actions, before running Cleany on your system! Use this script at your own risk

## 📝 Contributing
We welcome contributions! Please read the [Contributing Guidelines](https://github.com/M1HA15/Cleany/blob/main/CONTRIBUTING.md) before submitting issues or pull requests.

## 🚧 Report Issues
If you encounter any issues, please [report them here](https://github.com/M1HA15/Cleany/issues).

Your feedback is valuable in improving the script!

## 🚀 Developers:
- [Mihai (Author)](https://github.com/M1HA15)

## 🙏 Acknowledgments:
**Thank you for choosing Cleany**! Special gratitude to you, the user, for your support and for choosing to utilize this script.

## 📃 License
This project is licensed under the GPL-3.0 License - see the [LICENSE](https://github.com/M1HA15/Cleany/blob/main/LICENSE) file for details.
