

class Credentials(object):
    def __init__(self, filename):
        with open(filename) as creds_fh:
            creds = creds_fh.read().strip().splitlines()

            if len(creds) != 5:
                raise RuntimeError("Credentials file {} invalid!".format(filename))

            user, pw, host, port, db = creds

            self.conn_string = "dbname='{}' port='{}' user='{}' password='{}' host='{}'".format(db, port, user, pw, host)

