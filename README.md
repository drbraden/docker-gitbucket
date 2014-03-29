# Docker-Gitbucket

# Building the docker image


    $ git clone https://github.com/drbraden/docker-gitbucket.git
    $ cd docker-gitbucket
    docker-gitbucket$ docker build -t gitbucket .


# Running the docker image
First, you need to create a folder that will hold all of the gitbucket data (repos, wikis, issues, settings, everything).  Without this step, all of your data would be lost anytime the container closed, whether it be from a system crash, a docker kill command, or someone tripping over the powercord.  Having the data directory external to the app will give us persistence.

I like to go with /var/docker/gitbucket.

It also makes it easier to perform backups.  You can just stop the container, copy and/or ship off the data to it's backup home, and then restart the container.  Easy peasy.


    docker run -d -p 8080:8080 -p 8081:8081 -p 8082:22 -v /var/docker gitbucket:/data:rw gitbucket


This command launches an existing gitbucket:

|Option|Description|
|:--------|:----------|
|-d						|Daemonize the container into a background job|
|-p 8080:8080	|Maps real port 8080 to container's 8080 (http)|
|-p 8081:8081	|Maps real port 8081 to container's 8081 (git ssh)|
|-p 8082:22			|Maps real port 8082 to container's 22 (system ssh, pw in logs)|
|-v /var/docker/gitbucket:/data:rw	|Maps host's /var/docker/gitbucket to the container's /data, with read+write access|
## License

Docker-Gitbucket is under New BSD License. See the bundled LICENSE file for details.

## Credits
Forked from a project copyrighted by Alexis Couronne <alexis.couronne@gmail.com>
