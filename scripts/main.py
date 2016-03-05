#!/usr/bin/env python

from analyst_collective import Credentials, Runner
import argparse, json, sys, os

parser = argparse.ArgumentParser(description='Analyst Collective Runner')
parser.add_argument('--credentials', default="dbcredentials.txt", type=str, help='Path to database credentials file')
parser.add_argument('--config',      default="../config.json",    type=str, help='Path to analyst collective config file')

args = parser.parse_args()

creds = Credentials(args.credentials)

config = None
with open(args.config) as config_fh:
    contents = config_fh.read()
    try:
        config = json.loads(contents)
    except ValueError as e:
        print "Could not parse config file {}".format(args.config), e
        sys.exit(1)

models_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'models')

runner = Runner(config, creds, models_dir)
runner.clean_schema()
runner.create_models()
