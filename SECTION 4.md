# INDEX

- [HTTP METHOD ENUMERATION](#http-method-enumeration)
- [DIRECTORY ENUMERATION WITH GOBUSTER](#directory-enumeration-with-gobuster)
- [DIRECTORY ENUMERATION WITH BURPSUITE](#directory-enumeration-with-burpsuite)
- [SCANNING WITH ZAPROXY](#scanning-with-zaproxy)
- [SCANNING WITH NIKTO](#scanning-with-nikto)
- [PASSIVE CRAWLING WITH BURP SUITE](#passive-crawling-with-burp-suite)
- [SQL INJECTION WITH SQLMAP](#sql-injection-with-sqlmap)
- [XSS ATTACK WITH XSSER](#xss-attack-with-xsser)
- [ATTACKING BASIC AUTH WITH BURP SUITE](#attacking-basic-auth-with-burp-suite)
- [ACTIVE CRAWLING WITH ZAPROXY](#active-crawling-with-zaproxy)

## THEORY

**Websites**: Files on a server that we can access with a browser. Most common used formats are HTML, CSS for styles and JavaScript for functionality. These files are saved in web servers like Apache, IIS, Nginx,... or in off-premise hosts like Amazon, Azure...

**HTTP Protocol**: The protocol used by the client and server to communicate in web applications. HTTP Protocol has different headers, and the most common ones are:

- In the request (sent by the client):
  - Method: GET, POST, OPTIONS...
  - Host: location of a server
  - User-agent: browser being used
  - Body info

- In the response (sent by the server):
  - Status code: 2XX, 3XX, 4XX,...
  - Content Type: indicates the media type or MIME

**HTTP Methods**:
- GET: ask for files on the server
- POST: sends info to the server, form, login,...
- OPTIONS: indicates HTTP methods available in the server
- PUT: put files on the server

**HTTP Status Codes**:
- 2XX: OK
- 3XX: redirections
- 4XX: client error
- 5XX: server error

**HTTP Sessions**: HTTP does not maintain sessions, so cookies are needed so accounts can stay activated.

**HTTP vs HTTPS**: HTTP Secure wraps info sent to the server encrypted.

## LABS

### HTTP METHOD ENUMERATION

**Commands**: curl, dirb
**Tools**: Burp
**Notes**:
- **Curl**:
  - To use HEAD with curl, you have to use the -I option.
  - To use PUT with curl, you have to use the -T option.
  - Methods have to be in UPPERCASE and with the -X option.
  
- **Burp**:
  - Intercept the request, and in the header of the method, we change it to the method we want to see if it exists. If we want to use the PUT method to upload files, then we indicate PUT /<path.txt> and in the body information, we write at the end the text that we want the file to contain.

```markdown
dirb <url>
curl -X <method> <url> -v
curl -I <url> -v
curl -X <method> <url> -d <parm1=value&parm2=value...> -v
curl <url> --upload-files <file>
curl -T <file> <url>
curl -X DELETE <url>
