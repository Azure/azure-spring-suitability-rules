# azure-spring-suitability-rules

## Purpose
This repo is for Cloud Suitability Analyzer rules of Azure Spring Apps. Cloud Suitability Analyzer or CSA for short is a VMWare project to automatically scan for potential cloud remediation issues and cloud accommodation issues embedded in legacy applications.  CSA is entirely data driven using rules comprised of patterns that are first written in `yaml` and then loaded in the CSA command-line executable. To scan your applications to migrate to Azure Spring Apps, use rules folder in this repo, download latest CSA executable and go for it!

## Run

### 1. Download
Download latest CSA executable at https://github.com/vmware-tanzu/cloud-suitability-analyzer/releases, find the proper one for your local machine.

| Executable | Platform |
| ---------- | -------- |
| `csa.exe`  | Windows  |
| `csa-l`    | Linux    |
| `csa`      | OSX      |

Clone azure-spring-suitability-rules to local.

### 2. Set up environment

To effectively use `csa` from the command-line, it will be helpful not to type in the full path every time. So include `csa's` location in your path.

#### Adding the path on Linux

Change to your home directory.

`cd $HOME`

Open the `.bashrc` file with a text editor.

Add the following line to the file. Replace the <csa directory> with the location directory of `csa`

`export PATH=<csa directory>:$PATH`

Save the file and exit.

Use the source command to force Linux to reload the .bashrc file which normally is read only when you log in each time.

`source .bashrc`

#### Adding the path on OSX

Change to your home directory.

`cd $HOME`

Open the `.bash_profile` file with a text editor.

Add the following line to the file. Replace the <CSA directory> with the location directory of `CSA`

`export PATH=<csa directory>:$PATH`

Save the file and exit.

Use the source command to force Linux to reload the .bashrc file which normally is read only when you log in each time.

`source .bash_profile`

#### Adding path on Windows

[Instructions to change your PATH on Windows 10](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/)


### 3. Load rules and score model into CSA executable

Run command at azure-spring-suitability-rules root: `csa score-models import --over-write-models`

You'll see message including:
> Successfully imported [*] rule(s) found @[./rules]
> 
> Replacing [0] existing bins with [1] new ones!
> 
> Successfully imported [1] bins(s) found @[bins.yaml]
> 
> Replacing [0] existing scoring models with [1] new ones!
> Successfully imported [1] Scoring Model(s) found @[./scoring-models]

### 4. Scan your application files

Navigate to your application root directory in command line, run `csa`. This is a default mode that CSA considers current directory a portfilio. 

```bash
csa
```

To tell `csa` to treat each sub-directory under current directory as a stand-alone application, use the`-p` flag on the command-line.

```bash
csa -p
```

To target a directory with source code simple run

```bash
   csa -p <path>
```

For more infomation about CSA  please refer to https://github.com/vmware-tanzu/cloud-suitability-analyzer.
