import socket
import time
import threading


def server():
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server_socket.bind(('localhost', 9999))
    server_socket.listen(100)

    while True:
        client, _ = server_socket.accept()
        while True:
            ret = client.recv(1024 * 10)
            if ret == '':
                break
            client.send(ret)
        print('Close connection')
        client.close()


def client():
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect(('localhost', 9999))

    for i in xrange(100000):
        client_socket.send('HEllo')
        ret = client_socket.recv(1024 * 10)
    client_socket.send('')
    client_socket.close()

print('Start server')
server_thread = threading.Thread(target=server)
server_thread.setDaemon(True)
server_thread.start()

time.sleep(0.5)

print('Start client')
start_time = time.time()
client()
end_time = time.time()

print('%f msec passed' % (end_time - start_time,))
