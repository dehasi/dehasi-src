---
layout: post
title:  "Mock with Spring Cloud Contract"
---

There are a couple of examples, where an API contract exists.
I.e when there are a backend and a frontend parts. They both can be developed separately. 
Sometimes people create mock servers to stub responses from a backend. But there is a risk, 
that contract can be changed, but the mock server can’t. In this case, this inconsistency will be caught only in integration part. 

Another example, when there are few microservices which talk with each other. 
In this case, the inconsistency can be found only after deploying and end-to-end tests.

It would be nice to have a way to mock a third party API and always keep it consistent.

Well, there is no problem with running mocks. We can just use Wiremock library to run them.
Wiremock is a library which emulates HTTP based server. We need to give them request and response examples, described in JSON format.

The last thing is where we can this JSONs? Obviously, we can write them manually, 
but Spring Cloud Contract can generate them for us. We just need to prepare spring cloud contracts contracts.
And then run 
`mvn spring-cloud-contract:convert` 
In my example WireMock stubs mappings directory in (you can see your from maven logs): 
```
A:\scc\target\stubs\META-INF\me.greet\greet\0.0.1-SNAPSHOT\mappings
[INFO] Creating new stub [A:\scc\target\stubs\META-INF\me.greet\greet\0.0.1-SNAPSHOT\mappings\greet\afternoon_greet.json]
```

Also we can generate a jar with stubs by
`mvn spring-cloud-contract:generateStubs `
command. It put the result from the previous command to the `***-stubs.jar` file.

Maven logs
```
[INFO] --- spring-cloud-contract-maven-plugin:1.2.2.RELEASE:generateStubs (default-cli) @ greet ---
[INFO] Files matching this pattern will be excluded from stubs generation [**/*.groovy]
[INFO] Building jar: A:\scc\target\greet-0.0.1-SNAPSHOT-stubs.jar
```
Now it even possible to deploy our stubs in our maven repo and share them with other people in team. 
To unpack jar we can use `jar xf jar-file` command.

Now, when we have mocks, let’s try use them.
The easiest way is run wiremock as a standalone process http://wiremock.org/docs/running-standalone/
We need to download a jar file and put our folder which has name “mappings” and cootains mocks to the root  directory.
Something as below
```
A:\wmso>ls -R
.:
mappings  wiremock-standalone-2.14.0.jar
./mappings:
greet
./mappings/greet:
afternoon_greet.json
```
And then run standalone wiremock.
Logs example:
```
A:\wmso>java -jar wiremock-standalone-2.14.0.jar
SLF4J: Failed to load class "org.slf4j.impl.StaticLoggerBinder".
SLF4J: Defaulting to no-operation (NOP) logger implementation
SLF4J: See http://www.slf4j.org/codes.html#StaticLoggerBinder for further details.
 /$$      /$$ /$$                     /$$      /$$                     /$$
| $$  /$ | $$|__/                    | $$$    /$$$                    | $$
| $$ /$$$| $$ /$$  /$$$$$$   /$$$$$$ | $$$$  /$$$$  /$$$$$$   /$$$$$$$| $$   /$$
| $$/$$ $$ $$| $$ /$$__  $$ /$$__  $$| $$ $$/$$ $$ /$$__  $$ /$$_____/| $$  /$$/
| $$$$_  $$$$| $$| $$  \__/| $$$$$$$$| $$  $$$| $$| $$  \ $$| $$      | $$$$$$/
| $$$/ \  $$$| $$| $$      | $$_____/| $$\  $ | $$| $$  | $$| $$      | $$_  $$
| $$/   \  $$| $$| $$      |  $$$$$$$| $$ \/  | $$|  $$$$$$/|  $$$$$$$| $$ \  $$
|__/     \__/|__/|__/       \_______/|__/     |__/ \______/  \_______/|__/  \__/
port:                         8080
enable-browser-proxying:      false
no-request-journal:           false
verbose:                      false
```
As you can see from logs, wiremock server runs on port 8080 (it can be changed with option --port). When we go to the following address.
http://localhost:8080/greet/john
we will receive our expected response 
`{"greet":"Good afternoon John"}`

So now we can give the mocks to our frontend team and they can be sure, that they use the actual API.





[spring-init]: https://start.spring.io
