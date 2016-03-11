
import sqlparse, psycopg2, sys, os, fnmatch

class Runner(object):
    def __init__(self, config, creds, models_dir):
        self.config = config
        self.creds = creds
        self.models_dir = models_dir

        self.connection = psycopg2.connect(creds.conn_string)

    def models(self):
        return set(self.config['models'])

    def drop_schema(self):
        sql = self.interpolate("drop schema if exists {schema} cascade")
        self.execute(sql)

    def create_schema(self):
        sql = self.interpolate("create schema {schema}")
        self.execute(sql)

    def clean_schema(self):
        self.drop_schema()
        self.create_schema()

    def execute(self, sql):
        debug = sql.replace("\n", " ").strip()[0:200]
        print "Running: {}".format(debug)
        with self.connection as connection:
            with connection.cursor() as cursor:
                cursor.execute(sql)
                print "  {}".format(cursor.statusmessage)

    def interpolate(self, sql, model_name=""):
        try:
            return sql.format(model=model_name, **self.config)
        except KeyError as e:
            print "Error interpolating key: {{{error_key}}} in model: {model}".format(error_key=str(e).replace("'", ""), model=model_name)
            return ""

    def add_prefix(self, uninterpolated_sql, model):
        match = "{schema}."
        replace = "{schema}.{model}_"
        return uninterpolated_sql.replace(match, replace)

    def __model_files(self):
        """returns a dictionary like
{'pardot': ['pardot/model.sql'],
 'segment': ['segment/model.sql'],
 'snowplow': ['snowplow/model.sql'],
 'trello': ['trello/model.sql', 'trello/test.sql']}
"""
        indexed_files = {}
        for root, dirs, files in os.walk(self.models_dir):
            for filename in files:
                if fnmatch.fnmatch(filename, "*.sql"):
                    abs_path = os.path.join(root, filename)
                    rel_path = os.path.relpath(abs_path, self.models_dir)
                    namespace = os.path.dirname(rel_path).replace('/', '.')
                    indexed_files.setdefault(namespace, []).append(rel_path)
        return indexed_files

    def create_models(self):
        for namespace, files in self.__model_files().iteritems():
            if namespace not in self.models():
                continue

            for f in sorted(files):
                model_file = os.path.join(self.models_dir, f)
                contents = ""
                with open(model_file) as model_fh:
                    contents = model_fh.read()

                statements = sqlparse.parse(contents)
                for statement in statements:
                    prefixed = self.add_prefix(str(statement), namespace)
                    sql = self.interpolate(prefixed, namespace)

                    if sql is None or len(sql.strip()) == 0:
                        continue # could throw an error here! Definitely don't execute the sql though

                    self.execute(sql)
