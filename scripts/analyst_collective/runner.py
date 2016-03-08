
import sqlparse, psycopg2, sys, os

class Runner(object):
    def __init__(self, config, creds, models_dir):
        self.config = config
        self.creds = creds
        self.models_dir = models_dir

        self.connection = psycopg2.connect(creds.conn_string)

    def models(self):
        return self.config['models']

    def try_create_schema(self):
        sql = self.interpolate("create schema if not exists {schema}")
        self.execute(sql)

    def clean_schema(self):
        self.try_create_schema()

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

    def create_models(self):
        for model_name in self.models():
            # right now, this only checks for model.sql in the model dir. It can ideally load the SQL file DAG
            model_file = os.path.join(self.models_dir, model_name, 'model.sql')

            contents = ""
            with open(model_file) as model_fh:
                contents = model_fh.read()

            statements = sqlparse.parse(contents);
            for statement in statements:
                prefixed = self.add_prefix(str(statement), model_name)
                sql = self.interpolate(prefixed, model_name)

                if len(sql.strip()) == 0:
                    # we could throw an error here! Definitely don't execute the sql though
                    continue

                self.execute(sql)

