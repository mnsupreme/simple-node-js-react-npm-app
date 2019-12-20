sudo docker run -u root --name jenkinsci -u root -d -p 8080:8080 -p 5000:5000 -v $HOME/jenkins:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):$(which docker) --privileged=true jenkinsci/blueocean

sudo docker run --name PostGres postgres

sudo  docker run --rm   -p 9000:9000 -e sonar.jdbc.username=sonar -e sonar.jdbc.password=sonar -e sonar.jdbc.url=jdbc:postgresql://172.17.0.2/sonar -v sonarqube_conf:/opt/sonarqube/conf  -v sonarqube_extensions:/opt/sonarqube/extensions   -v sonarqube_logs:/opt/sonarqube/logs   -v sonarqube_data:/opt/sonarqube/data   --name SonarTest sonarqube

sudo sysctl -w vm.max_map_count=262144

sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' PostGres

curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker \
  && rm docker-${DOCKERVERSION}.tgz