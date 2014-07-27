# traceback

import traceback

print(traceback.format_exc())


# get current dir

import os

BASE_DIR = os.path.normpath(os.path.join(os.path.dirname(__file__), '../'))

print(BASE_DIR)

# logging.basicConfig

import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s %(levelname)s %(message)s')

