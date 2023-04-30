docker build -t tobiasaditya/multi-client:latest -t tobiasaditya/multi-client:$SHA ./client/Dockerfile ./client
docker build -t tobiasaditya/multi-server:latest -t tobiasaditya/multi-server:$SHA ./server/Dockerfile ./server
docker build -t tobiasaditya/react-worker:latest -t tobiasaditya/multi-worker:$SHA ./worker/Dockerfile ./worker
docker push tobiasaditya/multi-client:latest
docker push tobiasaditya/multi-server:latest
docker push tobiasaditya/multi-worker:latest

docker push tobiasaditya/multi-client:$SHA
docker push tobiasaditya/multi-server:$SHA
docker push tobiasaditya/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=docker_id/multi-client:$SHA
kubectl set image deployments/server-deployment server=docker_id/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=docker_id/multi-worker:$SHA
