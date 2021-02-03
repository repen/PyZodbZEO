from config import BASE_DIR, REMOTE_SERVER
import os, time
import subprocess
import signal


storage_path = os.path.join( BASE_DIR, "storage", "Data.fs" )
log_path = os.path.join( BASE_DIR, "Log", "zeo.log" )

server_cert = os.path.join( BASE_DIR, "ssl", "server_cert.crt" )
server_key  = os.path.join( BASE_DIR, "ssl", "server.key" )
client_cert = os.path.join( BASE_DIR, "ssl", "client-cert.pem" )


config = f"""
<zeo>
  address {REMOTE_SERVER}:4110
  <ssl>
    certificate {server_cert}
    key {server_key}
    authenticate {client_cert}
  </ssl>
</zeo>

<filestorage>
  path {storage_path}
</filestorage>

<eventlog>
  <logfile>
    path {log_path}
    format %(asctime)s %(message)s
  </logfile>
</eventlog>
"""
print(config)

conf_path = os.path.join( BASE_DIR, "runzero.cn" )


with open(conf_path, "w") as f:
    f.write(config)

# "runzeo -C "
# out_bytes = subprocess.check_output( [ 'runzeo', '-C', conf_path ] )
# print( out_bytes.decode('utf-8') )

try:
    # out_bytes = subprocess.check_output( [ 'runzeo', '-C', conf_path ] )
    proc = subprocess.Popen(
      f"runzeo -C {conf_path}", shell=True, stdout=subprocess.PIPE, preexec_fn=os.setsid)
    output, err = proc.communicate()
    p_status = p.wait()
    print("Command output: " + output)
    # while True:time.sleep(1000)
except KeyboardInterrupt as e:
    os.killpg(proc.pid, signal.SIGTERM)
