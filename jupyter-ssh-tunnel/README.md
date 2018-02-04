# SSH tunnel for remote jupyter notebook

So you have a server and want to use jupyter notebook from there?

Here is what I do:

1. **On local machine**: 
  1. `$ssh your-sever@host`
2. **On server**:
  1. `$screen -S jupyter-notebook` so that you can safely close connection to server
  2. `$jupyter notebook --no-browser --port=8888`
    - copy token
  3. `crl+d`
  4. `$exit`
3. **On local machine
  - `$ssh -N -f -L localhost:8888:localhost:8888 your-server@host` 
    - or use my a little simlified version: `bash ssh-tunnel.sh 8888 8888 your-server@host`
  - go in browser and look for `localhost:8888`
