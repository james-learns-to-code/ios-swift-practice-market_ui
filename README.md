# ios-swift-test-market

Market application for iOS

## Purpose

Demonstrate app for online market service.

## Echo server

For implement echo server, i made echo-server application using python(https://github.com/james-learns-to-code/python-http-echo-server).  
For establishing echo server. I need a server instance.  
I already has a AWS lightsail instance for running web server, but i don't wanna use it.  
So i decide to using raspberry pi for running instance.  

## Routing

I want to use my own domain 'http://goodeffect.com' for receiving request.  
So i create A record named 'api' and directed raspberry pi's IP address.  
Also my raspberry pi using WIFI connection, so i have to port forwarding for routing request to raspberry pi.   
Therefore, api url is started with 'http://api.goodeffect.com:11000/  
