# cloudscan_controller
Currently, swarms have not been tested with the setup, but should be able to be done relatively easily as the network configuration would be completed IAW docker swarm specifications.

# Setup
The easist setup for multinode on the same host is to create a docker network (@see docker network --help)

# Build
```
docker build --no-cache -t ${CS_IMG} .
```

# Run
```
docker run -p 8280:8080 --network=${NETWORK_HOST} --ip ${CS_IP} --name cs.hpe.com -d ${CS_IMG}
```

# Link to SSC
In ssc Admin tab, point to cloudscan controller URL to what is defined in files/config.properties. If all are started with the same network, the containers should be able to reach each other by name(--name cs.hpe.com).
