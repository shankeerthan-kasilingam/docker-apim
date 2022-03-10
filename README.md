# Min-HA APIM 4.0 Cluster in docker-compose

The docker-compose yaml is configured for the following diagram.

![](assets/20220310_115701_WSO2_APIM 4 Event Hub Design (1).png)

The following nodes are configured in the docker-compose yaml.


| Product                     | Exposed ports in docker/host                      | Port offset | LB endpoints                                |   | Upldate level |
| ----------------------------- | --------------------------------------------------- | ------------- | --------------------------------------------- | --- | --------------- |
| APIM 4.0  Gateway1          | 9448,8285,8248,8104,9104                          | 0           | 8243,8280                                   |   | 81            |
| APIM 4.0  Gateway2          | 9449,8286,8249,8105,9105                          | 0           | 8243,8280                                   |   | 81            |
| APIM 4.0  Traffic manager 1 | 9453,5682,9621,9721                               | 0           | 4000                                        |   | 81            |
| APIM 4.0  Traffic manager 2 | 9454,5683,9622,9722                               | 0           | 4000                                        |   | 81            |
| APIM 4.0  Control Plane 1   | 9443,5672,9611,9711                               | 0           | 443 (external use)<br />5000 (internal use) |   | 81            |
| APIM 4.0  Control Plane 2   | 9444,5673,9612,9712                               | 0           | 443(external use) 5000(internal use)        |   | 81            |
| IS 5.11     KM 1            | 9458                                              | 40          | 9483                                        |   | 121           |
| IS 5.11     KM 2            | 9459                                              | 40          | 9483                                        |   | 121           |
| Choreo Analytics            | It's connected in the deployment.toml of Gateways |             |                                             |   |               |
| MySQL                       | 3306                                              |             |                                             |   |               |
| Nginx                       | 8280,443,9483,4000,8243,5000                      |             |                                             |   |               |


Files and Directories


| Path                                                    | Description                  |   |
| --------------------------------------------------------- | ------------------------------ | :-- |
| docker-compose/apim-is-as-km-with-analytics             | Contains docker-compose.yml  |   |
| docker-compose/apim-is-as-km-with-analytics/conf        | Contains config of nodes     |   |
| docker-compose/apim-is-as-km-with-analytics/dockerfiles | Contains dockefiles of nodes |   |


### Building images and Starting containers

> $> cd docker-compose/apim-is-as-km-with-analytics
>
> $> docker-compose build --no-cache
>
> $> docker-compose up


### Accessing Portals

Admin Portal : https://<your-ip> {your-ip-address}/admin

Publisher Portal: https://{your-ip-address}/publisher

Developer Portal(or Store): https://{your-ip-address}/devportal

Manamgnet console(Carbon console) https://{your-ip-address}/carbon

Credentials :

* Username: admin
* Password: admin

You might not able to see the admin portal even if you provide correct credentials. In that case, Please go to Management console and create a role "admin" in PRIMARY DOMAIN and assign it to your user.

Similary if you were not able to access the devportal (store) after selfsignup, please go to Management Console and assign role "Internal/subscriber" to your user.


Notes

* Please replace the IP address (192.168.104.82) in all the files to yours IP address of machine/VM
* For the IS 1 and IS 2, purposely port offsets are configured. It's neccessary, otherwise JWT validations will fails.
* Self signed certifcates are used for all nodes. After configuring current setup successfully, you may change the certificates and keys.
* The both Gateways are configured to deploy all the API artificats. This can be changed. The endpoints https://{your-ip}:8283 and https://{your-ip}:8280 are load balanced. So Nginx will distribute the requests.
* For the Portals (Publisher portal, Admin Portal, Developer portal, and Management console), loadbalancing is configured based on IP_HASH of Nginx.
* For Gatways, and throttling the information has to be published to both Traffic managers. So Active-Passive or Failover TCP/SSL loadbalancing might not work.
* Only HTTP/S endpoints are configured for loadbalacing.
