**Kippo-Graph** is a full featured script to visualize statistics from a Kippo SSH honeypot.

It uses the Libchart PHP chart drawing library by Jean-Marc Trémeaux, QGoogleVisualizationAPI PHP Wrapper for Google’s Visualization API by Thomas Schäfer, RedBeanPHP library by Gabor de Mooij, MaxMind and geoPlugin geolocation technology.

# How to use this image

Make sure your mysql container that contains kippo database is up and running:

	$ docker run --name some-mysql -P -e MYSQL_ROOT_PASSWORD=YOURPASSWORD -d mysql
	
Start kippo-graph container:

	docker run -d -P --link some-mysql:mysql --name kippo-graph dariusbakunas/kippo-graph:latest

	$ docker port kippo
	80/tcp -> 0.0.0.0:49166

You can also specify following environment variables:  

* `-e KIPPO_DB_HOST=...` (defaults to IP of the linked mysql container)
* `-e KIPPO_DB_PORT=...` (defaults to 3306)
* `-e KIPPO_DB_PASSWORD=...` (defaults to the value of the MYSQL_ROOT_PASSWORD environment variable from the linked mysql container)
* `-e KIPPO_DB_USER=...` (defaults to root)
* `-e KIPPO_DB_NAME=...` (defaults to kippo)
