id
ps -ef
find / -name <file name>
grep -nri
vim
vi
nano
printf "whatever" > <path to file>
/etc/sudoers: file with permissions
file <file>
strings <binary>
echo "" > <file.txt>

# Windows
ipconfig /all
route print
net users
net localgroup administrator
systeminfo
net user administrator <new pass>
whoami
ipconfig
route print #cómo los paquetes de red deben ser dirigidos desde la computadora hacia su destino en una red
arp -a #tabla arp con las ips con las que se ha conectado el ordenador
netstat -ano
net start #running services
wmic service list brief #list of running services with columns
tasklist /SVC #list proccess with more info
schtasks /query /fo LIST #tareas programadas en la computadora.
net user: Muestra una lista de usuarios y sus propiedades.
net user <username> <password>: Crea un nuevo usuario.
net group: Muestra una lista de grupos y sus miembros.
net localgroup: Muestra grupos locales en la estación de trabajo o servidor.
net share: Muestra o configura recursos compartidos en el sistema.
net use: Conecta o desconecta una unidad de red a un recurso compartido.
net start <service>: Inicia un servicio.
net stop <service>: Detiene un servicio.
net pause <service>: Pausa un servicio.
net session: Muestra o desconecta sesiones de usuario en un servidor.
net use: Muestra o desconecta conexiones de red.
net view: Muestra una lista de recursos compartidos disponibles en la red.
net use: Conecta a un recurso compartido en otro sistema.
net accounts: Muestra o configura la configuración de cuentas del sistema.
net localgroup administrators <username> /add: Agrega un usuario al grupo de 

#Linux
ifconfig
ip addr
ifconfig -a
cat /etc/*issue
cat /etc/shadow #linux passwrods hashes
/bin/bash -i
cat etc/sudoers
ls -l /root/tool/static-binaries #Static binaries
/etc/hostnames #hostname
/etc/network/interfaces #
touch <> #create empty files
/etc/shadow #password hashes
echo "" > <file> #create a txt file

#Shells
/usr/share/windows-binaries/mimikatz/x64/mimikatz.exe
/usr/share/webshells/php