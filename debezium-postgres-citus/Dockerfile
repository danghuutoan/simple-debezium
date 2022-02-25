FROM citusdata/citus:10.2

# Core build utilities 
RUN apt-get update && apt-get install -f -y software-properties-common build-essential pkg-config git postgresql-server-dev-9.6 


RUN apt-get install -y postgresql-14-wal2json