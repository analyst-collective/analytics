
import sqlparse
import psycopg2
import sys, os

if __name__ == '__main__':

    if len(sys.argv) != 2:
        print "Usage: {} [creds file]".format(sys.argv[0])
        sys.exit(1)

    creds_file = sys.argv[1]

    conn_string = None
    with open(creds_file) as creds_fh:
        creds = creds_fh.read().strip().splitlines()

        if len(creds) != 5:
            raise RuntimeError("Credentials file {} invalid!".format(creds_file))

        user, pw, host, port, db = creds
        conn_string = "dbname='{}' port='{}' user='{}' password='{}' host='{}'".format(db, port, user, pw, host)

    connection = psycopg2.connect(conn_string)

    models = os.listdir("models")

    for model in models:
        print "MODEL {}".format(model)

        path = os.path.join('models', model)
        files = [os.path.join(path, f) for f in os.listdir(path) if os.path.isfile(os.path.join(path, f)) and f.endswith('.sql')]

        for filepath in sorted(files):
            statements_to_execute = []

            print "-FILE {}".format(filepath)
            with open(filepath) as fh:
                contents = fh.read()
                statements = sqlparse.parse(contents);
                for statement in statements:
                    num_significant_statements = [token for token in statement.tokens if not token.is_whitespace()]
                    if len(num_significant_statements) == 0:
                        continue
                    statements_to_execute.append(statement)

            for statement in statements_to_execute:
                print str(statement)[0:100].replace("\n", " ") + ("..." if len(str(statement)) > 99 else "")
                # TODO : execute query here
            print
        print
