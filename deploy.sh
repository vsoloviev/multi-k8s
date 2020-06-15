docker build -t vsoloviev/multi-client:latest -t vsoloviev/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t vsoloviev/multi-server:latest -t vsoloviev/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t vsoloviev/multi-worker:latest -t vsoloviev/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vsoloviev/multi-client:latest
docker push vsoloviev/multi-server:latest
docker push vsoloviev/multi-worker:latest

docker push vsoloviev/multi-client:$SHA
docker push vsoloviev/multi-server:$SHA
docker push vsoloviev/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vsoloviev/multi-client:$SHA
kubectl set image deployments/client-deployment client=vsoloviev/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=vsoloviev/multi-worker:$SHA
