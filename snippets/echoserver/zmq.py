# -*- coding: utf-8 -*-

import time
import threading

import zmq


def server():
    print('Start server')
    context = zmq.Context()
    receiver = context.socket(zmq.PULL)
    receiver.bind("tcp://*:5555")
    while True:
        ret = receiver.recv()
        if ret == 'KILL':
            break
    receiver.close()
    context.term()


def client():
    context = zmq.Context()
    sender = context.socket(zmq.PUSH)
    sender.connect("tcp://localhost:5555")

    for i in xrange(100000):
        message = "Hello:" + str(i)
        sender.send(message)
    print("Try to close client")
    sender.send('KILL')
    sender.close()
    context.term()
    print("Close Done")


def main():
    server_thread = threading.Thread(target=server)
    server_thread.start()

    start_time = time.time()
    client()
    end_time = time.time()
    print("Passed %f" % (end_time - start_time))

    server_thread.join()


if __name__ == "__main__":
    main()
