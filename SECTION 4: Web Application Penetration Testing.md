INDEX
=====

-   HTTP METHOD ENUMERATION
-   DIRECTORY ENUMERATION WITH GOBUSTER
-   DIRECTORY ENUMERATION WITH BURPSUITE
-   SCANNING WITH ZAPROXY
-   SCANNING WITH NIKTO
-   PASSIVE CRAWLING WITH BURP SUITE
-   SQL INJECTION WITH SQLMAP
-   XSS ATTACK WITH XSSER
-   ATTACKING BASIC AUTH WITH BURP SUITE
-   ACTIVE CRAWLING WITH ZAPROXY

THEORY
======

**Websites**

Files on a server that we can access with a browser.

Most common used formats are HTML, CSS for styles and JavaScript for functionality.

These files are saved in web servers like Apache, IIS, Nginx,... or in off premise hosts like amazon, azure...

**HTTP Protocol** is the protocol used by client and server to communicate in web applications.

HTTP Protocol has different **headers** and the most common ones are:

In the **request** (sent by client):

-   Method: GET, POST, OPTIONS...
-   Host: location of a server
-   User-agent: browser being used
-   Body info

In the **response**(sent by server):

-   Status code: 2XX, 3XX, 4XX,...
-   Content Type: indicates the media type or MIME

**HTTP Methods:**

-   GET: ask for files on the server
-   POST: sends info to the server, form, login,...
-   OPTIONS: indicates http methods available in the server
-   PUT: put files on the server
-   HEAD:  used to retrieve the headers of a resource

**HTTP Status Codes:**

-   2XX: OK
-   3XX: redirections
-   4XX: client error
-   5XX: server error

**HTTP Sessions**

HTTP does not maintain sessions so cookies are needed so accounts can stay activated

**HTTP vs HTTPS**

HTTPSecure wraps info sent to server encrypted

LABS
====

HTTP METHOD ENUMERATION
-----------------------

**Commands**: curl, dirb

**Tools**: Burp

**Notes**:

-   Curl:

    -   To use HEAD with curl you have to use the -I option
    -   To use PUT with curl you have to use the -T option
    -   Methods has to be in UPPERCASE and with -X option

-   Burp

    -   Intercept the request and in the header of the method we change to the method we want to see if it exists, if we want to use the PUT method to upload files then we indicate PUT /<path.txt> and in the body information we write at the end the text that we want the file to contain.

```
dirb <url>
curl -X <method> <url> -v
curl -I <url> -v
curl -X <method> <url> -d <parm1=value&parm2=value...> -v
curl <url> --upload-files <file>
curl -T <file> <url>
curl -X DELETE <url>
```

DIRECTORY ENUMERATION GOBUSTER
------------------------------

**Commands:** gobuster

**Notes:**

-   To follow the redirects use the -r option
```
gobuster dir -u <url> -w <ruta a la wordlist>
gobuster dir -u <url> -w <ruta a la wordlist> -b <ignored status codes>
gobuster dir -u <url> -w <ruta a la wordlist> -b <ignored status codes> -x <format files> -r
```
DIRECTORY ENUMERATION WITH BURPSUITE
------------------------------------

**Tool:** Burp Suite

**Notes:**

-   Intercept the request with burp and send it to the Intruder. Once in the intruder add $$ to the route and then load as payload a list of the most used routes

SCANNING WITH ZAPROXY
---------------------

**Tool:** ZA Proxy

**Notes:**

-   ZAPROXY is found as owasp-zap in the kali of ine, then click on manual explore

1.  Make general recognition of the app so that everything is saved in sites
2.  Select url to the page where the login is
3.  Right click > "Default Context"
4.  Enter "Authentication"
5.  Select Form-based Authentication
6.  Fill in
7.  Enter "Users"
8.  Fill in
9.  Select the default context on site
10. Launch attack

SCANNING WITH NIKTO
-------------------

**Tool:** Nikto

**Notes:**

-   It has options of trying specific vulnerabilities using -Tunning
-   Nikto -Help for extra info
```
nikto -h <url>
nikto -h <url> -Tuning <vuln number>
nikto -h <url> -Tuning <vuln number> -Display v
nikto -h <url> -Tuning <vuln number> -o <file> -Format <format>
```
PASSIVE CRAWLING WITH BURP SUITE
--------------------------------

**Tool:** Burp Suite

**Notes:**

-   Burpsuite sitemap, browse the web application so that the pages are saved.
-   Use scope so that only the pages we want appear in the sitemap.

SQL INJECTION WITH SQLMAP
-------------------------

**Tool:** sqlmap

**Notes:**

-   It is possible to save a request doing right click on the request intercepted by burp and selecting "copy to file" so then you can pass it to sqlmap
-   When burp response is affected by sqlmap payload we can try to write in the payload things like version() so it is reflected in the respone
```
sqlmap -u <url> --cookie <"copy and paste cookie intercepted by burp proxy"> -p <parameter>`
sqlmap -u <url> --cookie <""> -p <param> --dbs
sqlmap -u <url> --cookie <""> -p <param> -D <database>
sqlmap -u <url> --cookie <""> -p <param> -D <database> --tables
sqlmap -u <url> --cookie <""> -p <param> -D <database> -T <tabla> --columns
sqlmap -u <url> --cookie <""> -p <param> -D <database> -T <tabla> -C <columna> --dump
ssqlmap -r <request> -p <param>
```
XSS ATTACK WITH XSSER
---------------------

**Tool:** xsser

**Notes:**

-   Include "XSS" where we want the payload to be put
```
xsser --url <url> -p <param>
xsser --url <url> -p <param> -auto
xsser --url <url> -p <param> --Fp <specific payload>
xsser --url <url>
xsser --url <url> --Fp <specific payload>
```
ATTACKING HTTP LOGIN FORM WITH HYDRA
------------------------------------

**Tool:** hydra

**Notes:**

-   When using a service in hydra, e.g. http-post-form, the parameters should be indicated with "" and they have to indicated as in burp proxy appear. Also it has to be indicated where hydra has to substitute users and passwords wit ^USER^ and ^PASS^

`hydra -L <user wordlist> -P <password wordlist> <protocol://server> <service "ruta:param">`

ATTACKING BASIC AUTH WITH BURP SUITE
------------------------------------

**Tool:** Burp suite

**Notes:**

-   Sometimes when intercepting a request with burp login values doesn't appear and instead an Authorization header appears. When it uses Basic Auth then we can follow this way of attacking auth.
-   User decoder for Basic Auth
-   If %3d appears in encoded message then try to decode as url
-   When setting payload in intruder there is a option called "payload processing" below "payload options" that has the option of adding prefix to payload set and to add rules like encoding.

ACTIVE CRAWLING WITH ZAPROXY
----------------------------

**Tool:** ZA Proxy

**Notes:**

-   When using ZA Proxy first of all we have to navigate the website. If there is a login form then in ZA Proxy Sites it will appear a post request. This request will have input values. With ZA Proxy we can launch a Fuzz attack and select these values, click the add button and add a wordlist. In attack results we can look in payloads column which one is trying for each request.
