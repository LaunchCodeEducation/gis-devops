:orphan:

.. _walkthrough-client-deployment-s3:

========================
Deploy Zika Client to S3
========================

In this walkthrough we will be deploying the static zika client to AWS S3.

S3 is Amazon Web Services Simple Storage Service. S3 is a cloud hosted file system that can store any type of file and can be accessed from the AWS Web Console, or the AWS CLI. Since our Zika client is purely static and only needs a browser to run a file system with a basic web server can serve the files as a website. Luckily, AWS S3 can be configured to serve files with a basic web server. This will transform our S3 file system into a very simple web server for our Client.

Later in this course we will dive much deeper into AWS and some of the various services offered, but all we need to deploy a static front end is S3.

Setup
=====

Download AWS CLI
----------------

We will be using the AWS CLI as our primary means of interfacing with S3.

You can download the AWS CLI through brew with the following command:

.. sourcecode:: bash

    brew install awscli

This takes a couple of minutes to install.

After it is complete you can verify it installed correctly by checking it's version:

.. sourcecode:: bash

    awscli --version

You should see a line of output describing the version of the AWS CLI tool you just installed on your machine.

Setup AWS Account
-----------------

Your instructor should have provided you with some AWS information, most notably a username, password, and login link. Click that link now and login to the AWS Web Console.

You will be prompted to change your password the first time you log in.

After logging in and changing your password your account has been created under the greater LaunchCode GIS-DevOps account.

Save your username, password, and login link as we will be using them again when we work with AWS in future weeks.

For now we will not need anything else from the AWS Web Console. You can close the window if you choose.

Configure AWS CLI with Account Credentials
------------------------------------------

The next step is to configure our AWS CLI with our AWS credentials so that it can access our resources like S3. You will need your AWS access key id, and your AWS secret access key. You can find them with the information your instructor shared with you about your account.

.. admonition:: note

    Alternatively you can generate a new secret key id, and secret access key through the AWS Web Console under your account ``My Security Credentials`` and then under the *Access keys for CLI, SDK, & API access* section.

We will do this using the aws cli:

.. sourcecode:: bash

    aws configure

This command will prompt you for two things which you will need to paste into your terminal. First your access key id, and second your secret access key. Both are long strings of characters. The secret key id, and and secret access key are your way of identifying yourself to AWS through the AWS CLI. These are not things you should share with anyone else. If you ever feel they have been compromised you can revoke access to any keys, and generate new ones through the AWS Web Console mentioned in the note above.

Next we will be configuring our default region. For our S3 buckets we will be placing them in the AWS North Virginia region also known as ``us-east-1``.

Using the aws cli:

.. sourcecode:: bash

    aws configure set region us-east-1

After setting your default region you can verify everything was configured properly by running:

.. sourcecode:: bash

    aws configure list

You should see a few lines of output most notably you should see the three things we just set:

- secret access key id
- secret access key
- region

Make an S3 Bucket
=================

For whatever reason AWS calls the individual file systems you can create a **bucket**. After creating a bucket you can put whatever files you want into that bucket. In our case we will be uploading our Zika Client build artifacts (index.html, bundle.js) into the bucket.

But we first have to create a new bucket with the aws cli:

.. sourcecode:: bash

    aws s3 mb s3://launchcode-gisdevops-c7-<your-name>-zika-client

S3 Bucket names are **Globally Unique** across all AWS users. For this reason you usually want to pre-pend descriptive information about your bucket to the bucket name. If the name you have chosen already exists your bucket will fail to create.

You can check that your bucket was created successfully by listing all the buckets associated with the greater LaunchCode GIS-DevOps account:

.. sourcecode:: bash

    aws s3 ls

You will see many lines of output among them should be the bucket you created for this deployment.

Prepare Project For Deployment
==============================

Right now our Zika Clients are making WMS requests to publicly hosted geoservers. However, it is making WFS requests to a locally hosted geoserver container. This container will not be running on our user's computers so we will need to update our WFS requests to access a publicly hosted goeserver that contains the data we need.

Your instructor should have a new URL for you to use to make your WFS requests to a public geoserver instance.

You will need to update your source code so that any of your WFS requests to ``localhost:8080`` are updated to the address provided.

Create Build Artifacts
======================

Now that we have our bucket which is our deployment destination we need to generate the build artifacts of our Zika Client. Right now, we have a huge mess of files, index.html, index.js, additional .js files, a *ton* of node_modules. All of these things need to be included on S3 for our content to be served properly.

Luckily we are using buildpack and NPM which will bundle all of our HTML, CSS, and JavaScript into two simple files ``index.html`` and ``bundle.js``.

You can build this project with the NPM build command. Navigate to your project directory:

.. sourcecode:: bash

    cd path/to/your/zika-client

Then you can run the NPM build script to create your project build artifacts:

.. sourcecode:: bash

    npm run build

You will notice this creates a new directory in your project directory named ``dist/``. Look into this directory:

.. sourcecode:: bash

    ls dist/

You will notice there are two files: ``index.html`` and ``bundle.js``. These are our build artifacts and what we want to deploy through S3. 

As a part of our ``npm run build`` script web pack combined all of our node_modules, JavaScript, HTML, and css into these two files making our deployment quite straight forward.

.. admonition:: note

    Remember we do **not** want to commit build artifacts to our version control software (git). You will want to add the ``dist/`` directory to your .gitignore file. Reach out to your instructor if you need a refresher on how to do this.

Move Build Artifacts to S3 Bucket
=================================

We will need to use the aws cli to copy the ``index.html`` and ``bundle.js`` files to the S3 bucket we created earlier. You will want to run this next command from within your project directory:

.. sourcecode:: bash

    aws s3 cp --recursive --acl public-read dist/ s3://<your-bucket-name>

This command does two things it recursively copies all the contents from your local ``dist/`` directory into the S3 bucket, and set's their access privileges to ``public read only``. This means anyone can request access to these files, but can only read them. This is crucial for serving this content.

You can check that your files were copied to your bucket properly by listing the contents of your bucket:

.. sourcecode:: bash

    aws s3 ls s3://<your-bucket-name>

You should see in the output two files: ``index.html`` and ``bundle.js``.

Configure Bucket to Static Host
===============================

All S3 buckets can be configured to host static files, but this functionality does not come as part of the S3 bucket default behavior. We will need to configure this bucket to act as a web server and to tell it which file is the entry point:

.. sourcecode:: bash

    aws s3 website s3://<your-bucket-name> --index-document index.html

And that's it! We have configured our bucket to serve the index.html file when users make HTTP requests to our bucket.

Access Deployed Zika Client
===========================

In your browser make a request to:

.. sourcecode:: bash

    http://<your-bucket-name>.s3-website-us-east-1.amazonaws.com

Redeploying After Changes
=========================

Deploying our project once is great. However, as we continue to work on our project we will need to periodically upload new build artifacts to our S3 bucket to have it reflect our new changes.

After you have made changes to your application and you want to redeploy you will need to do two things:

- build new artifacts
- sync the new artifacts with your s3 bucket

You will first make some changes to your source code, it could be UI updates, bug fixes, or possible a new feature you've added, then you will need to build new artifacts:

.. sourcecode:: bash

    npm run build

You will need to use the S3 sync command to update the existing content of a bucket:

.. sourcecode:: bash

    aws s3 sync --acl public-read dist/ s3://<your-bucket-name>

By default S3 sync will sync directories to an S3 bucket. It recursively copies from the provided local directory to the S3 bucket provided.

Automating our redeployments with NPM
=====================================

The steps to redeploy our application are always the same. 

We have to build artifacts, and then we have to sync the changes to our S3 bucket. This is a task that is perfect for automation!

It would be great instead of having to copy paste both of those command each time, if we could just run one command that would do both of these tasks in one fell swoop. Luckily we are working with NPM which manages dependencies, and coordinates tasks.

Let's take a look at our current ``package.json``:

.. sourcecode:: json

    "scripts": {
        "clean": "rm -rf dist/*",
        "build": "npm run clean && webpack --config webpack.prod.js",
        "prestart": "npm run start:services",
        "start": "webpack-dev-server --config webpack.dev.js --open",
        "install:geoserver-config": "bash -c 'if [[ ! -e ./geoserver-config ]]; then $(git clone git@gitlab.com:LaunchCodeTraining/zika-project/geoserver-config.git); fi'",
        "postinstall": "npm run install:geoserver-config",
        "prestart:services": "npm run install:geoserver-config",
        "prestop:services": "npm run install:geoserver-config",
        "start:services": "docker-compose -f docker-compose.yml -f ./geoserver-config/docker-compose.preconfigured.yml up -d",
        "stop:services": "docker-compose  -f docker-compose.yml -f ./geoserver-config/docker-compose.preconfigured.yml down",
    },

Pretty straight forward we have been using these scripts as we have been developing our application. Let's add two new scripts at the bottom of the ``"scripts"`` section:

.. sourcecode:: json

    "scripts": {
        "clean": "rm -rf dist/*",
        "build": "npm run clean && webpack --config webpack.prod.js",
        "prestart": "npm run start:services",
        "start": "webpack-dev-server --config webpack.dev.js --open",
        "install:geoserver-config": "bash -c 'if [[ ! -e ./geoserver-config ]]; then $(git clone git@gitlab.com:LaunchCodeTraining/zika-project/geoserver-config.git); fi'",
        "postinstall": "npm run install:geoserver-config",
        "prestart:services": "npm run install:geoserver-config",
        "prestop:services": "npm run install:geoserver-config",
        "start:services": "docker-compose -f docker-compose.yml -f ./geoserver-config/docker-compose.preconfigured.yml up -d",
        "stop:services": "docker-compose  -f docker-compose.yml -f ./geoserver-config/docker-compose.preconfigured.yml down",
        "predeploy": "npm run build",
        "deploy": "aws s3 sync --acl public-read dist/ s3://launchcode-gisdevops-c7-paul-zika-client"
    },

We added a ``"predeploy"`` script that will run before any script named ``"deploy"`` which we also added.

``"predeploy"`` simply runs the ``"build"`` script which removes the dist directory, and then activates webpack to build ``index.html`` and ``bundle.js``.

Then our ``"deploy"`` script runs which calls the aws s3 sync command for our bucket.

Make a change to your application and tryout our new deploy script.