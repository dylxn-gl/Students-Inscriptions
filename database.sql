--Creamos la base de datos
CREATE DATABASE students;

--Creamos las tablas 
CREATE TABLE student (
  id serial PRIMARY KEY,
  name VARCHAR(50),
  age INT,
  mail VARCHAR(100),
  cellphone INT
);

CREATE TABLE teacher (
  id serial PRIMARY KEY,
  name VARCHAR(50),
  age INT,
  mail VARCHAR(100),
  cellphone VARCHAR(15)
);

CREATE TABLE course (
  id serial PRIMARY KEY,
  name VARCHAR(100),
  description VARCHAR(50),
  teacher INT,
  FOREIGN KEY (teacher) REFERENCES teacher(id)
);

CREATE TABLE inscriptions (
  id serial PRIMARY KEY,
  student INT,
  course INT,
  startdate TIMESTAMP,
  enddate TIMESTAMP,
  FOREIGN KEY (student) REFERENCES student(id),
  FOREIGN KEY (course) REFERENCES course(id)
);
