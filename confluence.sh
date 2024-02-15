docker network create --subnet 172.40.0.0/16 --ip-range 172.40.240.0/20 confluence

echo "docker network created"

docker run -v /data/confluence-data_volume:/var/atlassian/application-data/confluence --name="confluence" --net confluence --ip 172.40.240.2 -d --restart unless-stopped -p 8090:8090 -p 8091:8091 atlassian/confluence

docker exec -it confluence bash -c "apt update -y && apt install iproute2 -y"

echo "Confluence is running http://localhost:8090" 


docker run --name postgres -v /data/postgres_data_volume:/var/lib/postgresql/data --net confluence --ip 172.40.240.3 --restart unless-stopped -e POSTGRES_PASSWORD=mysecretP@SSWORDFORCONFluENce -d postgres

docker exec -it postgres bash -c "apt update -y && apt install iproute2 -y"

echo "postgres is running"
