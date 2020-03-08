docker build -t abhaydubey/multi-client:latest -t abhaydubey/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t abhaydubey/multi-server:latest -t abhaydubey/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t abhaydubey/multi-worker:latest -t abhaydubey/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push abhaydubey/multi-client:latest
docker push abhaydubey/multi-server:latest
docker push abhaydubey/multi-worker:latest

docker push abhaydubey/multi-client:$SHA
docker push abhaydubey/multi-server:$SHA
docker push abhaydubey/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=abhaydubey/multi-server:$SHA
kubectl set image deployments/client-deployment client=abhaydubey/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=abhaydubey/multi-worker:$SHA