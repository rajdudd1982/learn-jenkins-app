#!/bin/bash
imageName="playwrite_image"
containerName="playwright"
#build docker image

#npm ci
#npm run build
docker build -f infrastructure/ci_cd/Dockerfile_playwright -t ${imageName} .


docker rm ${containerName}

#run container
docker run -p 3021:3000 --name ${containerName} ${imageName} 2> docker_run.log 


docker exec -it ${containerName} bash -c 'npm install serve'

#run serve
docker exec -it ${containerName} bash -c 'npx serve -s /app/build -p 3000'

docker exec ${containerName} npx playwright test --reporter=allure-playwright