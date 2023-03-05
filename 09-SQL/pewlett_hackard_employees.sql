
CREATE TABLE "departments" (
    "dep_num" varchar(10)   NOT NULL,
    "dep_name" varchar(100)   NOT NULL,
    "last_updated" timestamp default localtimestamp  NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dep_num"
     )
);

CREATE TABLE "dep_emp" (
    "id" serial   NOT NULL,
    "emp_num" int   NOT NULL,
    "dep_num" varchar(10)   NOT NULL,
    "last_updated" timestamp default localtimestamp  NOT NULL,
    CONSTRAINT "pk_dep_emp" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "dep_mngmt" (
    "id" serial   NOT NULL,
    "dep_num" varchar(10)   NOT NULL,
    "emp_num" int   NOT NULL,
    "last_updated" timestamp default localtimestamp  NOT NULL,
    CONSTRAINT "pk_dep_mngmt" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "employees" (
    "emp_num" int   NOT NULL,
    "pos_id" varchar(10)   NOT NULL,
    "b_day" date   NOT NULL,
    "first_name" varchar(100)   NOT NULL,
    "last_name" varchar(100)   NOT NULL,
    "gender" varchar(10)   NOT NULL,
    "start_date" date   NOT NULL,
    "last_updated" timestamp default localtimestamp  NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_num"
     )
);

CREATE TABLE "salary" (
    "id" serial   NOT NULL,
    "emp_num" int   NOT NULL,
    "income" float   NOT NULL,
    "last_updated" timestamp default localtimestamp  NOT NULL,
    CONSTRAINT "pk_salary" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "positions" (
    "pos_id" varchar(10)   NOT NULL,
    "position" varchar(50)   NOT NULL,
    "last_updated" timestamp default localtimestamp  NOT NULL,
    CONSTRAINT "pk_positions" PRIMARY KEY (
        "pos_id"
     )
);

ALTER TABLE "dep_emp" ADD CONSTRAINT "fk_dep_emp_emp_num" FOREIGN KEY("emp_num")
REFERENCES "employees" ("emp_num");

ALTER TABLE "dep_emp" ADD CONSTRAINT "fk_dep_emp_dep_num" FOREIGN KEY("dep_num")
REFERENCES "departments" ("dep_num");

ALTER TABLE "dep_mngmt" ADD CONSTRAINT "fk_dep_mngmt_dep_num" FOREIGN KEY("dep_num")
REFERENCES "departments" ("dep_num");

ALTER TABLE "dep_mngmt" ADD CONSTRAINT "fk_dep_mngmt_emp_num" FOREIGN KEY("emp_num")
REFERENCES "employees" ("emp_num");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_pos_id" FOREIGN KEY("pos_id")
REFERENCES "positions" ("pos_id");

ALTER TABLE "salary" ADD CONSTRAINT "fk_salary_emp_num" FOREIGN KEY ("emp_num")
REFERENCES "employees"("emp_num");