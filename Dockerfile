# 'as' is used to add a tag
FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install
#We are not using volumes since we are not changing our code
COPY . .
#The result of the build command will be inside "/app/build"
RUN npm run build


# SECOND PHASE
FROM nginx 

#Used to copy the build folder from the builder phase into nginx
COPY --from=builder /app/build /usr/share/nginx/html

#nginx starts automatically when starting the container.
