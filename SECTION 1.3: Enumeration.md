# ENUMERATION

**Server**: specialized computer or software application designed to provide specific services, resources, or functionality to other computers or devices, known as clients, over a network. 

**Services**: Services refer to specific functionalities or tasks provided by servers or software applications.

SMB
===

Network protocol used for sharing files, printers, and resources on a local network.

Windows implementation of files share is called **CIFS** and is the modern and enhanced version of SMB in Microsoft.

**Ports**:
- 445
- 139 on top of NetBIOS


**1. Nmap scripts SMB**

`nmap -sC`: for default scripts

```
smb-os-discovery

smb-protocols

smb-security-mode

smb-enum-sessions --script-args smbusername=<>,smbpassword=<>

smb-enum-shares --script-args smbusername=<>,smbpassword=<> 

smb-enum-shares,smb-ls --script-args smbusername=<>,smbpassword=<>

smb-enum-users --script-args smbusername=<>,smbpassword=<>

smb-server-stats --script-args smbusername=<>,smbpassword=<>

smb-enum-domains --script-args smbusername=<>,smbpassword=<>

smb-enum-groups --script-args smbusername=<>,smbpassword=<>

smb-enum-services --script-args smbusername=<>,smbpassword=<>
```

**Notes**:
- If we find **$IPC** in shares then it exist null sessions

- **SMBv1**: eternalblue

**2. SMBmap**

Enumerate samba share drives across an entire domain

```
smbmap u <> p <> -d <. o el dominio> -H <ip>

smbmap u <> p <> -d <. o el dominos> -H <ip> -x <command>

smbmap u <> p <> -d <. o el dominos> -H <ip> -L : lista de drivers

smbmap u <> p <> -d <. o el dominos> -H <ip> -r <driver>

smbmap u <> p <> -d <. o el dominos> -H <ip> --upload <path> <file>

smbmap u <> p <> -d <. o el dominos> -H <ip> --download '<file>'
```

**3. Metasploit**

**Notes**:

- To initiate metasploit: `msfconsole`

- For options inside a module `show options`


```
msfconsole

    use auxiliary/scanner/smb/smb_version

    use auxiliary/scanner/smb/smb_enumusers
```

**4. nmblookup**

NetBIOS over TCP

```
nmblookup -A <ip>
```

**3.3. smbclient**

FTP client to access SMB/CIFS resources on servers. Access files on windows systems.

**Notes:**
- Use `-N` for null sessions
- Use `-U <user>` with a user
- Use `get <file>` when you are logged in a host to save a file
- Use `-L` for listing hosts
```
smbclient -L <ip> -N

smbclient //<ip>/Public -N

            ls

            get <file>

smbclient //<ip>/<user> -U <user>: with a user
```

**5. rpccliente**

Tool for executing client side MS-RPC (Windows RPC Remote Procedure Call services) functions on remote Windows systems.

**Notes**:
- Use -N for no password

```
rpcclient -U "" -N <ip>

    ?

    srvinfo

rpcclient -U "" -N <ip>

    enumdomusers

    lookupnames admin

    enumdomgroups

```

**6. enum4linux**

`enum4linux -o <IP>`: operating system information

`enum4linux -U <IP>`: get users

`enum4linux -S <IP>`: get shares

`enum4linux -G <ip>`: groups

`enum4linux -I <ip>`: printers

**7. SMB Dictionary**

**Notes**:

- Use -r with enum4linux to enumerate users via RID cycling (recursively)

`enum4linux -r -u <user> -p <pass> <ip>` 

```
msfconsole

    use auxiliary/scanner/smb/smb_login

    use auxiliary/scanner/smb/pipe_auditor
```

`hydra -l <user> -P <wordlist> <ip> smb`


`smbmap -H <ip> -u <user> -p <pass>`

```
smbclient -L <ip> -U <user>

smbclient //<ip>/<user> -U <user>
```


FTP
===

File transfer protocol: store files on a server an access them remotely

**Port**: 21

**1. Connection**

`ftp <ip>`: to connect via ftp

**2. Hydra**

`hydra -L <wordlist> -P <wordlist> <IP> ftp`

**3. Nmap scripts**
```

--script ftp-brute --script-args user-db=<path with users> -p21

--script ftp-anon
```

SSH
===

Remote administration, create a remote shell, interact with remote machine over a secured channel.

**Port**: 22

`nc <ip> 22`

`ssh <user>@<ip>`

**1. Nmap scripts**:
```
ssh2-enum-algos

ssh-hostkey --script-args ssh_hostkey=full

ssh-auth-methods --script-args="ssh.user=<>"

ssh-brute script-args userdb=<path wordlist>

ssh-run --script-args="ssh-run.cmd=<command>,ssh-run.username=<>,ssh-run.password=<>"
```
**2. Hydra**:

`hydra -l <user> -P <wordlist> <IP> ssh`

**3. Metasploit**:
```
msfconsole
    auxiliary/scanner/ssh/shh_login
    auxiliary/scanner/ssh/shh_version
```

HTTP
====

Port 80, when I see that I open web browse

**Notes**:
- WebDAV, protocol that allows us to easily save, edit, copy, move, and share files from web servers.

**1. IIS**

It uses aspx files

- `whatweb <ip>`: server version, default page, xss protection...

- `http <ip>`: headers

- `dirb http://<ip>`: directories

- `browsh --startup-url http://<ip>`: para ver como se visualiza la web

- `curl <ip> | more`

- `curl http://<ip>/<path> | more`

- `wget http://<ip>/<e.g.:index>`

- `lynx http://<ip>`

- `dirb http://<ip> <wordlist>`

**1.1 Nmap scripts**:

```
http-enum

http-headers

http-methods --script-args http-methods.url-path=<path>

http-webdav-scan

banner
```
**2. Apache**

**2.1. Nmap scripts:**

`banner`: information that my machine receives when it connects remotely the first time to another machine

**2.2. Metasploit**:
```
msfconsole

    use auxiliary/scanner/http/http_version

    use auxiliary/scanner/http/brute_dirs

    use auxiliary/scanner/http/robots_txt
```


MySQL
=====

Allows many users to store information in databases. Data can be pulled from databases and used in many things.

**Notes**:
- `/etc/shadow`: passwords of users

**Port**: 3306

**1. Connection**:
```
mysql -h <IP> -u <user>

    show databases;

    use <db>;

    select count(*) from authors;

    select * from authors;

    select load_file("<path>")
```

**2. Metasploit**:
```
msfconsole

    use auxiliary/scanner/mysql/mysql_writable_dirs

    use auxiliary/scanner/mysql/mysql_hashdump
```


**3. Nmap scripts**:

```

mysql-empty-password

mysql-info

mysql-users --script-args="mysqluser='<>'; mysqlpass"='<>'

mysql-databases

mysql-variables --script-args="mysqluser='<>'; mysqlpass"='<>'

mysql-audit --script-args="mysql-audit.username= '<>', mysql-audit.password= '<>', mysql-audit.filename='/usr/share/nmap/nselib/data/mysql-cis.audit' ": listado de privilegios

mysql-dump-hashes --script-args="username= '<>',password= '<>' "

mysqpl-query --script-args="query=<>',username"= '<>',password= '<>' "
```

MSSQL
=====

SQL version of microsoft

**Notes**:
- NTLM: Microsoft security protocols designed to provide authentication, integrity, and confidentiality to users.

**Port**: 1433

**1. Metasploit**:
```
msfconsole

    use auxiliary/scanner/mysql/mysql_login

    use auxiliary/scanner/mssql/mssql_login

    use auxiliary/admin/mssql/mssql_enum

    use auxiliary/admin/mssql/mssql_exec

    use auxiliary/admin/mssql/mssql_enum_domain_accounts
```

**2. Hydra**:

`hydra -l <user> -P <wordlist> <IP> mysql`

**3. Nmap scripts**:
```
--script ms-sql-info

--script ms-sql-ntlm-info --script-args mssql.instance-port=<port>

--script ms-sql-brute --script-args userdb=<PATH >, passdb=<PATH wordlist>

--script ms-empty-password

--script ms-sql-query --script-args mssql.username=< >, mssql.passqord =<>, ms-sql-query=<> -oN <file output>

--script ms-sql-dump-hashes --script-args mssql.username=< >, mssql.passqord =<>

--script ms-sql-xp-cmdshell --script-args mssql.username=< >, mssql.passqord =<>, ms-sql-xp-cmdshell.cmd="<>"
```