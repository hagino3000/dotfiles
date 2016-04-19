# coding=utf-8
"""
Simple echo TCP Server
"""
from multiprocessing import Process
import time
import socket
from contextlib import closing


HOST = 'localhost'
PORT = 9876


def server():
    host = '127.0.0.1'
    bufsize = 4096

    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    with closing(server_socket):
        server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        server_socket.bind((HOST, PORT))
        server_socket.listen(4)  # max connection
        while True:
            conn, address = server_socket.accept()
            with closing(conn):
                msg = conn.recv(bufsize)
                print(msg)
                conn.send(msg)
    return


def client():
    def send(i):
        client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        with closing(client_socket):
            client_socket.connect((HOST, PORT))
            client_socket.send('HEllo')
            ret = client_socket.recv(1024 * 10)

    for i in xrange(100):
        send(i)


if __name__ == '__main__':
    print('Start server')
    server_process = Process(target=server)
    server_process.start()

    time.sleep(0.5)

    print('Start client')
    start_time = time.time()
    client()
    end_time = time.time()

    server_process.terminate()
    server_process.join()

    print('%f msec passed' % (end_time - start_time,))
