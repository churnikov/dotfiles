import random
import string
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--n', default=16, type=int)
args = parser.parse_args()

alphabet = string.ascii_letters + string.digits + string.punctuation
password = ''.join(random.choices(alphabet, k=args.n))

print(password)
