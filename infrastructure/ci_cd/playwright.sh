#!/bin/bash
imageName="playwrite_image"
containerName="playwright"
#build docker image

#npm ci
#npm run build
docker build -f infrastructure/ci_cd/Dockerfile_playwright -t ${imageName} .


docker rm ${containerName}

#run container
docker run -d -it -p 3021:3000 --name ${containerName} ${imageName}


docker exec -i ${containerName} bash -c 'npm install serve'


docker exec -i ${containerName} bash -c 'PORT=3021 npx serve -s /app/build -p 3021 &'

#run serve

docker exec ${containerName} npx playwright test