# coding=utf-8
"""
Simple echo TCP Server
"""
from multiprocessing import Process
import time
import socket
from contextlib import closing
import select


HOST = 'localhost'
PORT = 9876


def server():
    host = '127.0.0.1'
    bufsize = 4096

    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    readfds = set([server_socket])
    try:
        server_socket.bind((HOST, PORT))
        server_socket.listen(10)

        while True:
            rready, wready, xready = select.select(readfds, [], [])
            for sock in rready:
                if sock is server_socket:
                    conn, address = server_socket.accept()
                    readfds.add(conn)
                else:
                    # client socket
                    msg = sock.recv(bufsize)
                    if len(msg) == 0:
                        sock.close()
                        readfds.remove(sock)
                    else:
                        sock.send(msg.replace('HEllO', 'Bye'))

    finally:
        for sock in readfds:
            sock.close()
    return



def client(num):
    print('Start Process {0}'.format(num))
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    with closing(client_socket):
        client_socket.connect((HOST, PORT))
        for i in xrange(10):
            client_socket.send('HEllO {0} from {1}'.format(i, num))
            ret = client_socket.recv(1024 * 10)
            print(ret)



if __name__ == '__main__':
    print('Start server')
    server_process = Process(target=server)
    server_process.start()

    time.sleep(0.5)

    print('Start client')
    start_time = time.time()
    client_process1 = Process(target=client, args=('A',))
    client_process2 = Process(target=client, args=('B',))
    client_process1.start()
    client_process2.start()
    client_process1.join()
    client_process2.join()
    end_time = time.time()
    print('End client')

    print('%f msec passed' % (end_time - start_time,))

    server_process.terminate()
    server_process.join()
    print('Stop server')

