
import sqlparse, psycopg2, sys, os

class Runner(object):
    def __init__(self, config, creds, models_dir):
        self.config = config
        self.creds = creds
        self.models_dir = models_dir

        #self.connection = psycopg2.connect(creds.conn_string)

    def models(self):
        return self.config['models']

    def drop_schema(self):
        print "dropping schema {schema}".format(**self.config)

    def create_schema(self):
        print "creating schema {schema}".format(**self.config)

    def clean_schema(self):
        self.drop_schema()
        self.create_schema()

    def execute(self, sql):
        debug = sql.replace("\n", " ").strip()[0:100]
        print debug
        pass

    def interpolate(self, sql):
        try:
            return sql.format(**self.config)
        except KeyError as e:
            print "Error interpolating key: {{{error_key}}} in model: {model}".format(error_key=str(e).replace("'", ""), model=model_name)
            return None

    def create_model(self, model_fh):
        contents = model_fh.read()
        statements = sqlparse.parse(contents);
        for statement in statements:
            sql = self.interpolate(str(statement))
            if sql is None: continue # could throw an error here! Definitely don't execute the sql though
            self.execute(sql)

    def create_models(self):
        for model_name in self.models():
            # right now, this only checks for model.sql in the model dir. It can ideally load the SQL file DAG
            model_file = os.path.join(self.models_dir, model_name, 'model.sql')

            with open(model_file) as model_fh:
                self.create_model(model_fh)
