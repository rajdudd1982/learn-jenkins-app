#!/bin/bash
imageName="playwrite_image"
containerName="playwright"
#build docker image

#npm ci
#npm run build
docker build -f infrastructure/ci_cd/Dockerfile_playwright -t ${imageName} .


docker rm ${containerName}

#run container
docker run -d -it  --name ${containerName} ${imageName}


docker exec -i ${containerName} bash -c 'npm install serve'

#run serve
docker exec -i ${containerName} bash -c 'npx serve -s /app/build -p 3000'

docker exec ${containerName} npx playwright test