## Docker Registry 

#### Setup Registry Server

##### Step 1. Install docker

Install docker on the server

##### Step 2. Pull docker registry image

```
docker run -d \
  -p 5000:5000 \
  --restart=always \
  --name registry \
  registry:2
```

