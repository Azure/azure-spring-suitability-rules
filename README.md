# azure-spring-suitability-rules

## Purpose
This repo is Cloud Suitability Analyzer rules for Azure Spring Apps. 

Cloud Suitability Analyzer or CSA for short is a VMWare project to automatically scan for potential cloud remediation issues and cloud accommodation issues embedded in legacy applications.
CSA is dependent on rules comprised of patterns and loaded in `csa` command-line executable. 

To scan your applications to migrate to Azure Spring Apps, download latest release, find proper script, and go for it!

## Run

### 1. Download
Download the latest CSA package for Azure Spring Apps at https://github.com/Azure/azure-spring-suitability-rules/releases.
Find the proper script or executable for your local machine.

|         Script         | Platform |
| ---------------------- | -------- |
| `run-csa-windows.bat`  | Windows  |
| `run-csa-linux.sh`     | Linux    |
| `run-csa-osx.sh`       | OSX      |

| Executable | Platform |
| ---------- | -------- |
| `csa.exe`  | Windows  |
| `csa-l`    | Linux    |
| `csa`      | OSX      |

### 2. Scan your application files

Navigate to the directory of azure-spring-suitability-rules in command line, run the script with <path of application> and flag [-p].
When the flag `-p` missing, CSA is in default mode in which considers <path of application> as a portfilio. 
When the flag `-p` is on, CSA considers each sub-directory under <path of application> as a stand-alone application.
Note that `-p` can be only be used with directory path, cannot be used with file path.

```command
# cmd on windows
run-csa-windows.bat <path of application> [-p]
# powershell on windows
.\run-csa-windows.bat <path of application> [-p]
```
```command
./run-csa-linux.sh <path of application> [-p]
```
```command
./run-csa-osx.sh <path of application> [-p]
```

The script do things including: initializing rules and score model, analyzing application at given path, open a web service for report at http://localhost:3001.
It prints logs in log.txt file. If encountering any issues including not working, unexpected failure, please send the log.txt to azure-spring-suitability-rules owners for troubleshooting.

To terminate running, you can type `Ctrl C`.

If encountering error message like "./run-csa-linux.sh: cannot execute: required file not found", please run `dos2unix run-csa-linux.sh` to make sure the file is linux compatible.

### 3. Scan your jar file

> **Caution:** JAVA_17 needed in environment for jar scanning

Navigate to the directory of azure-spring-suitability-rules in command line, run the script with <jar path> and flag [--decompile-dir=<decompile-path>].
When the flag `[--decompile-dir=<decompile-path>]` missing, CSA will decompile and analyze it in a tmp directory.
If you want to check the decompiled files, set When the flag `[--decompile-dir=<decompile-path>]`, then you can find the decompiled files in `<decompile-path>`.

It can only handle one jar at one time, please don't input a directory path as a jar path.

```command
# cmd on windows
run-jar-windows.bat <jar-path> [--decompile-dir=<decompile-path>]
# powershell on windows
.\run-jar-windows.bat <jar-path> [--decompile-dir=<decompile-path>]
```
```command
./run-jar-linux.sh <jar-path> [--decompile-dir=<decompile-path>]
```
```command
./run-jar-osx.sh <jar-path> [--decompile-dir=<decompile-path>]
```
Similar with earlier mentioned scripts, the scripts in this section do things including: initializing rules and score model, analyzing jar file at given path, open a web service for report at http://localhost:3001.
It prints logs in log-jar.txt file. If encountering any issues including not working, unexpected failure, please send the log-jar.txt to azure-spring-suitability-rules owners for troubleshooting. 

### 4. Special commands

You can also run some commands on the executable by yourself.
In some certain circumstances, this can be quite useful.

If you want to open CSA report without analyzing the application again, you can open ui by this command:
```command
# windows
csa.exe ui
# linux
csa-l ui
# osx
csa ui
```
If you want to disable one rule, you can delete it by this command:
```command
# windows
csa.exe rules delete <rule name>
# linux
csa-l rules delete <rule name>
# osx
csa rules delete <rule name>
```
To re-import any rule, navigate to the directory of azure-spring-suitability-rules in command line, then run this command:
```command
# windows
csa.exe rules import <rule name>
# linux
csa-l rules import <rule name>
# osx
csa rules import <rule name>
```
It will import the rule from [./rules] directory under current path.

For more infomation about CSA and it's commands, please refer to https://github.com/vmware-tanzu/cloud-suitability-analyzer or https://github.com/vmware-tanzu/cloud-suitability-analyzer/blob/master/csa-app/util/Shared.go
