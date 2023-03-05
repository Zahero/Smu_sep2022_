from flask import Flask, jsonify
import pandas as pd
from sqlHelper import SQLHelper

# Flask Setup
#################################################
app = Flask(__name__)
sqlHelper=SQLHelper()

#################################################
# Flask Routes
#################################################

@app.route("/")
def welcome():
    return (
        f"""Welcome to the Hawaii Weather API!<br>
        <a href='/api/v1.0/precipitation'>/api/v1.0/precipitation</a><br>
        <a href='/api/v1.0/stations'>/api/v1.0/stations</a><br>
        <a href='/api/v1.0/tobs'>/api/v1.0/tobs</a><br>
        <a href='/api/v1.0/<start>'>/api/v1.0/start<start></a><br>
        <a href='/api/v1.0/<start>/<end>'>/api/v1.0/start<start>/end<end></a><br>
        """

    )

@app.route("/api/v1.0/precipitation")
def get_prcp():
    df=sqlHelper.getprcp()
    data=df.to_dict(orient="records")
    return(jsonify(data))

@app.route("/api/v1.0/stations")
def get_stns():
    df = sqlHelper.getstn()
    data = df.to_dict(orient="records")
    return(jsonify(data))

@app.route("/api/v1.0/tobs")
def get_tobs():
    df = sqlHelper.getTobs()
    data = df.to_dict(orient="records")
    return(jsonify(data))

@app.route("/api/v1.0/<start>")
def get_temp_date_date(start):
    df = sqlHelper.getTempDateStart(start)
    data = df.to_dict(orient="records")
    return(jsonify(data))

@app.route("/api/v1.0/<start>/<end>")
def get_temp_data_range(start, end):
    df = sqlHelper.getTempDateRange(start, end)
    data = df.to_dict(orient="records")
    return(jsonify(data))



if __name__ == "__main__":
    app.run(debug=True)



