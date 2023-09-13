docker build -t azajvahora/fibonacci-k8s-client:latest -t azajvahora/fibonacci-k8s-client:$GIT_SHA ./client/Dockerfile ./client
docker build -t azajvahora/fibonacci-k8s-server:latest -t azajvahora/fibonacci-k8s-server:$GIT_SHA ./server/Dockerfile ./server
docker build -t azajvahora/fibonacci-k8s-worker:latest -t azajvahora/fibonacci-k8s-worker:$GIT_SHA ./worker/Dockerfile ./worker

docker push azajvahora/fibonacci-k8s-client:latest
docker push azajvahora/fibonacci-k8s-server:latest
docker push azajvahora/fibonacci-k8s-worker:latest

docker push azajvahora/fibonacci-k8s-client:$GIT_SHA
docker push azajvahora/fibonacci-k8s-server:$GIT_SHA
docker push azajvahora/fibonacci-k8s-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=azajvahora/fibonacci-k8s-server:$GIT_SHA
kubectl set image deployments/client-deployment client=azajvahora/fibonacci-k8s-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=azajvahora/fibonacci-k8s-worker:$GIT_SHA
