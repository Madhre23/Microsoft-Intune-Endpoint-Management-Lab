# Lab architecture

```text
Main Windows PC
  |-- Oracle VirtualBox
  |     `-- INTUNE-WIN11-01 (Windows 11 Enterprise Evaluation)
  |             |-- Company Portal / Intune MDM enrollment
  |             |-- Windows Defender and Firewall
  |             `-- PowerShell scripts (executed locally)
  |
  `-- Web browser -> Microsoft Intune admin center
                      |-- Microsoft Entra pilot security group
                      |-- Windows compliance policy
                      |-- Defender Antivirus and Firewall policies
                      |-- ASR policy (Audit configuration)
                      `-- Store / Win32 app assignments
```

This environment is cloud-managed MDM; it does not require joining the virtual machine to the on-premises Active Directory lab.
