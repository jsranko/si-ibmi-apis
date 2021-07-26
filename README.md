# si-ibm-apis (IBM i Apis Framework / SIIIA)

SIIIA Framework tries to reduce the complexity of the system apis to capsule and thereby provide a simple usable modules/serviceprograms. 

## Install

### Set PATH variable

Extend the environment variable PATH, so that the OpenSource packages do not have to enter qualified:

```
export PATH=/QOpenSys/pkgs/bin:$PATH
```

### Install git

Opensource package **git** must be installed. For installation execute the following command:
```
yum install git
```

### Clone project
A local copy of the project must be created:
```
git -c http.sslVerify=false clone https://github.com/jsranko/si-ibmi-apis.git
```

### Build project

```
cd si-ibmi-apis
bash setup.sh
```

## Configuration

Configure project before it is created 

```
{
   "library":"SIIIA",
   "job_ccsid":"037",
   "pase_ccsid":"1208"
}
```
**library** - Describe
**job_ccsid** - Describe
**pase_ccsid** - Describe
