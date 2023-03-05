import pandas as pd
from sqlalchemy import create_engine

class SQLHelper():
    
    def __init__(self):
        self.database_path = "Resources/hawaii.sqlite"
        self.connection_str = f"sqlite:///{self.database_path}"
        self.engine = create_engine(self.connection_str)

    
    def executeQuery(self, query):
        df = pd.read_sql(query, self.engine)
        return(df)
    
    def getprcp(self):
        query = """
                    SELECT
                        date,
                        station,
                        prcp
                    FROM
                        measurement
                    WHERE
                        date>= '2016-08-23'
                        and prcp is not null
                    ORDER BY
                        date asc,
                        station asc;
                """
        return(self.executeQuery(query))


    def getstn(self):
        query = """
                    SELECT * FROM station order by id asc;
                """
        return(self.executeQuery(query))


    def getTobs(self):
            query="""
                    SELECT
                        date,
                        tobs
                    FROM
                        measurement
                    WHERE
                        date>= '2016-08-23'
                        and tobs is not null
                        and station="USC00519281"
                    order by
                        date asc;
                    
                    """
            return(self.executeQuery(query))

    def getTempDateStart(self, start):
        query = f"""SELECT
                        min(tobs) as min_tobs,
                        max(tobs) as max_tobs,
                        avg(tobs) as avg_tobs
                    FROM
                        measurement
                    WHERE
                        date >= '{start}';
                """
        return(self.executeQuery(query))

    def getTempDateRange(self, start, end):
        query = f"""SELECT
                        min(tobs) as min_tobs,
                        max(tobs) as max_tobs,
                        avg(tobs) as avg_tobs
                    FROM
                        measurement
                    WHERE
                        date >= '{start}'
                        and date <= '{end}';
                """
        return(self.executeQuery(query))
