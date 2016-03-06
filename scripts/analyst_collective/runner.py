
import sys
import os
import sqlparse, psycopg2, fnmatch, jinja2, pprint

class Runner(object):
    def __init__(self, config, creds, models_dir):
        self.config = config
        self.creds = creds
        self.models_dir = models_dir
        self.template_env = jinja2.Environment(loader=jinja2.FileSystemLoader(searchpath=models_dir))
        self.connection = psycopg2.connect(creds.conn_string)

    def __template_context(self):
        return {'schema': self.config['schema']}

    def models(self):
        return set(self.config['models'])

    def drop_schema(self):
        ctx = self.__template_context()
        sql = jinja2.Template("drop schema if exists {{ schema }} cascade").render(ctx)
        self.execute(sql)

    def create_schema(self):
        ctx = self.__template_context()
        sql = jinja2.Template("create schema {{ schema }}").render(ctx)
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
                template = self.template_env.get_template(f)
                ctx = self.__template_context()
                ctx.update({'model': namespace})

                statements = sqlparse.parse(template.render(ctx))
                for statement in statements:
                    raw_sql = str(statement)
                    if raw_sql is None or len(raw_sql.strip()) == 0:
                        continue # could throw an error here! Definitely don't execute the sql though
                    self.execute(raw_sql)
