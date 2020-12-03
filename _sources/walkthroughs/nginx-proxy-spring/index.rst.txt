:orphan:

.. _nginx-proxy-spring:

========================================
NGINX as a Proxy to Spring Apache Tomcat 
========================================

This walkthrough assumes you have deployed an API built with Java/Spring to a Virtual Machine and have configured the application to run on port 8080 as a SystemD service.

If you need a refresher check out the :ref:`unit-files` walkthrough.

That walkthrough ended with us running the application as a SystemD service on port 8080. Our current EC2 instance has a security group allowing traffic on port 80. We could just open up port 8080, but a best practice would be to setup an intermediary web server that would proxy requests from port 80, to our application on port 8080.

In this case we will be using NGINX as the web server to catch requests on port 80, and then pass the request to our applications Tomcat web server running on port 8080. The response from our Tomcat web server is passed back to NGINX and then is sent back to the location of the original request.

We will need to:

- install NGINX
- configure NGINX

Install NGINX
=============

.. sourcecode:: bash

    sudo apt install nginx -y

You can verify it installed properly with:

.. sourcecode:: bash

    nginx -v

While this worked for us in this educational environment, it is not a reliable solution for running our application. In the case of the server crashing, the EC2 instance going down, or experiencing a power outage the application would need to be manually started with the command used above.

Configure NGINX
===============

We are simply using NGINX to proxy requests on port 80 to port 8080. We will need to update NGINX configuration information so that it points to our running application.

We will be overwriting ``/etc/nginx/nginx.conf`` with the following lines:

.. sourcecode:: bash

    events {}
    http {
      server {
        listen	*:80;

        location / {
        proxy_pass http://localhost:8080;
        }
      }
    }

This is simply informing the NGINX webserver running on port 80 to send all requests to ``http://localhost:8080``.

After making the change we will need to reload the NGINX configuration file:

.. sourcecode:: bash

    sudo nginx -s reload

Now you can make a request from the EC2 instance with:

.. sourcecode:: bash

    curl localhost/todos

You can do the same thing from another machine since there is a security group allowing inbound traffic from anywhere on port 80.

.. sourcecode:: bash

    curl <ec2-instance-public-ip>/todos

Review
======

This walkthrough installed and configured the NGINX web server to handle HTTP requests on port 80 and forwards them to our running application on port 8080.

This is a common practice you see in operations as it separates concerns. Our NGINX web server has one responsibility handling HTTP traffic. If we needed to do something with that traffic before passing it to our Java/Spring application we would do it with NGINX. An example of this would be enforcing SSL/TLS, a responsibility of NGINX not Java/Spring.