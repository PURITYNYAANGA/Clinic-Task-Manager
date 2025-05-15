QUESTION 1

-- Delete the existing database if it exists (for clean re-runs)
DROP DATABASE IF EXISTS clinicdb;

-- Create a new database named 'clinic_db'
CREATE DATABASE clinic_db;

-- Select 'clinic_db' as the active database
USE clinic_db;

-- Create the 'Specializations' table to store medical specializations
CREATE TABLE Specializations (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique ID for each specialization
    name VARCHAR(100) NOT NULL UNIQUE                 -- Name of the specialization, must be unique
);

-- Create the 'Doctors' table to store doctor details
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,        -- Unique ID for each doctor
    full_name VARCHAR(100) NOT NULL,                 -- Doctor's full name
    email VARCHAR(100) NOT NULL UNIQUE,              -- Doctor's email, must be unique
    specialization_id INT,                           -- Links to the specialization
    FOREIGN KEY (specialization_id) REFERENCES Specializations(specialization_id) -- Foreign key to 'Specializations'
);

-- Create the 'Patients' table to store patient details
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,       -- Unique ID for each patient
    full_name VARCHAR(100) NOT NULL,                 -- Patient's full name
    dob DATE,                                        -- Date of birth
    phone VARCHAR(15) UNIQUE                         -- Phone number, must be unique
);

-- Create the 'Rooms' table to store room information for appointments
CREATE TABLE Rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,          -- Unique ID for each room
    room_number VARCHAR(10) NOT NULL UNIQUE          -- Room number, must be unique
);

-- Create the 'Appointments' table to store appointment records
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each appointment
    patient_id INT NOT NULL,                         -- Links to a patient
    doctor_id INT NOT NULL,                          -- Links to a doctor
    room_id INT,                                     -- Links to a room (optional)
    appointment_time DATETIME NOT NULL,              -- Date and time of the appointment
    notes TEXT,                                      -- Optional notes about the appointment
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id), -- Link to 'Patients'
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),    -- Link to 'Doctors'
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)           -- Link to 'Rooms'
);

-- Insert sample data into the 'Specializations' table
INSERT INTO Specializations (name) VALUES ('Cardiology'), ('Dermatology'), ('Pediatrics');

-- Insert sample data into the 'Doctors' table
INSERT INTO Doctors (full_name, email, specialization_id) VALUES
('Dr. John Doe', 'john.doe@clinic.com', 1),
('Dr. Jane Smith', 'jane.smith@clinic.com', 2);

-- Insert sample data into the 'Patients' table
INSERT INTO Patients (full_name, dob, phone) VALUES
('Alice Johnson', '1990-06-15', '0712345678'),
('Bob Mwangi', '1985-12-01', '0723456789');

-- Insert sample data into the 'Rooms' table
INSERT INTO Rooms (room_number) VALUES ('101'), ('102');

-- Insert sample data into the 'Appointments' table
INSERT INTO Appointments (patient_id, doctor_id, room_id, appointment_time, notes) VALUES
(1, 1, 1, '2025-05-05 10:00:00', 'Routine checkup'),
(2, 2, 2, '2025-05-06 11:00:00', 'Skin rash consultation');


QUESTION 2

Main.py
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import pymysql

app = FastAPI()

# MySQL connection with user's credentials
conn = pymysql.connect(
    host="localhost",
    user="Purity nyaanga",  # Corrected username
    password="",            # Empty password as provided
    database="college"      # Assuming database is named 'college'
)
cursor = conn.cursor(pymysql.cursors.DictCursor)

# Pydantic model
class Contact(BaseModel):
    name: str
    email: str
    phone: str

# Create
@app.post("/contacts/")
def create_contact(contact: Contact):
    query = "INSERT INTO Contacts (name, email, phone) VALUES (%s, %s, %s)"
    values = (contact.name, contact.email, contact.phone)
    cursor.execute(query, values)
    conn.commit()
    return {"id": cursor.lastrowid, **contact.dict()}

# Read all
@app.get("/contacts/")
def get_contacts():
    cursor.execute("SELECT * FROM Contacts")
    return cursor.fetchall()

# Update
@app.put("/contacts/{contact_id}")
def update_contact(contact_id: int, contact: Contact):
    query = "UPDATE Contacts SET name=%s, email=%s, phone=%s WHERE id=%s"
    values = (contact.name, contact.email, contact.phone, contact_id)
    cursor.execute(query, values)
    conn.commit()
    if cursor.rowcount == 0:
        raise HTTPException(status_code=404, detail="Contact not found")
    return {"message": "Updated successfully"}

# Delete
@app.delete("/contacts/{contact_id}")
def delete_contact(contact_id: int):
    cursor.execute("DELETE FROM Contacts WHERE id=%s", (contact_id,))
    conn.commit()
    if cursor.rowcount == 0:
        raise HTTPException(status_code=404, detail="Contact not found")
    return {"message": "Deleted successfully"}

CONTACT_BOOK

CREATE DATABASE contact_book;
USE contact_book;

CREATE TABLE Contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20) NOT NULL
);
