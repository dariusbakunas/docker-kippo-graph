**Kippo-Graph** is a full featured script to visualize statistics from a Kippo SSH honeypot.

It uses the Libchart PHP chart drawing library by Jean-Marc Trémeaux, QGoogleVisualizationAPI PHP Wrapper for Google’s Visualization API by Thomas Schäfer, RedBeanPHP library by Gabor de Mooij, MaxMind and geoPlugin geolocation technology.

# How to use this image

Make sure your mysql container that contains kippo database is up and running:

	$ docker start some-mysql
	
Start kippo-graph container:

	docker run -d -P --link some-mysql:mysql --name kippo-graph dariusbakunas/kippo-graph:latest

	$ docker port kippo
	80/tcp -> 0.0.0.0:49166

Browse to http://localhost:49166 (or use `boot2docker ip` to get an ip address if under OSX or windows):

![kippo_in_browser](https://cloud.githubusercontent.com/assets/2111392/7309822/3fdd6afc-e9f1-11e4-871f-8ff6e0d09492.png)

You can also specify following environment variables:  

* `-e KIPPO_DB_HOST=...` (defaults to IP of the linked mysql container)
* `-e KIPPO_DB_PORT=...` (defaults to 3306)
* `-e KIPPO_DB_PASSWORD=...` (defaults to the value of the MYSQL_ROOT_PASSWORD environment variable from the linked mysql container)
* `-e KIPPO_DB_USER=...` (defaults to root)
* `-e KIPPO_DB_NAME=...` (defaults to kippo)
