### Ready to use Nominatim

This is a containr based on [`mediagis/nominatim-docker`](https://github.com/mediagis/nominatim-docker) with 2 differences:

1. It imports US and TIGER data
2. It is self-contained. In other workds, the huge databse is stored within the container.
Therefore this container is ~250G and most probably not suitable for most cloud docker hosts.

You would need a machine with ~64GB to build it.

After being built it can be run with smaller resources.

### Usage

1. `docker build -t nominatim .`
2. _wait for several hours_
3. `docker run nominatim -p 8080:8080`
4.  `curl http://localhost:8080`
