docker build -t test-nginx:latest .
docker run -d -p 8080:8080 test-nginx:latest
#After this you should be able to access container on 127.0.0.1:8080