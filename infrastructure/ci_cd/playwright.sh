#!/bin/bash
imageName="playwrite_image"
containerName="playwright"
#build docker image

npm ci
npm run build
docker build -f Dockerfile_playwright -t ${imageName} .

#run container
docker run -d -p 3021:3000 --name ${containerName} ${imageName}


docker exec -it ${containerName} bash -c 'npm install serve'

#run serve
docker exec -it ${containerName} bash -c 'npx serve -s /app/build -p 3000'

docker exec ${containerName} npx playwright test --reporter=allure-playwright