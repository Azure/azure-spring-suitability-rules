# azure-spring-suitability-rules

## Purpose
This repo is Cloud Suitability Analyzer rules for Azure Spring Apps. 
Cloud Suitability Analyzer or CSA for short is a VMWare project to automatically scan for potential cloud remediation issues and cloud accommodation issues embedded in legacy applications.  
CSA is entirely data driven using rules comprised of patterns that are first written in `yaml` and then loaded in the CSA command-line executable. 
To scan your applications to migrate to Azure Spring Apps, download latest release, find proper script, and go for it!

## Run

### 1. Download
Download the latest CSA package for Azure Spring Apps at https://github.com/Azure/azure-spring-suitability-rules/releases.
Find the proper script or executable for your local machine.

|         Script         | Platform |
| ---------------------- | -------- |
| `run-csa-windows.bat`  | Windows  |
|  `run-csa-linux.sh`    | Linux    |
| `run-csa-osx.sh`       | OSX      |

| Executable | Platform |
| ---------- | -------- |
| `csa.exe`  | Windows  |
| `csa-l`    | Linux    |
| `csa`      | OSX      |

### 2. Scan your application files

Navigate to the directory of azure-spring-suitability-rules in command line, run the script with <path of application> and flag [-p].
When the flag `-p` missing, CSA considers <path of application> as a single application. 
When the flag `-p` is on, CSA considers each sub-directory under <path of application> as a stand-alone application.

```bash
# cmd on windows
run-csa-windows.bat <path of application> [-p]
# powershell on windows
.\run-csa-windows.bat <path of application> [-p]
```
```bash
./run-csa-linux.sh <path of application> [-p]
```
```bash
./run-csa-osx.sh <path of application> [-p]
```

The script do things including: initializing rules and score model, analyzing application at given path, open a web service for report at http://localhost:3001.
It prints logs in log.txt file. If encountering any issues including not working, unexpected failure, please send the log.txt to azure-spring-suitability-rules owners for troubleshooting.

To terminate running, you can type `Ctrl C`.

### 3. Special commands

You can also run some commands on the executable by yourself.
In some certain circumstances, this can be quite useful.

If you want to disable one rule, you can delete it by this command.
```bash
# windows
csa.exe rules delete <rule name>
# linux
csa-l rules delete <rule name>
# osx
csa rules delete <rule name>
```
To re-import any rule, navigate to the directory of azure-spring-suitability-rules in command line, then run this command.
```bash
# windows
csa.exe rules import <rule name>
# linux
csa-l rules import <rule name>
# osx
csa rules import <rule name>
```
It will import the rule from [./rules] directory under current path.

For more infomation about CSA and it's commands, please refer to https://github.com/vmware-tanzu/cloud-suitability-analyzer or https://github.com/vmware-tanzu/cloud-suitability-analyzer/blob/master/csa-app/util/Shared.go