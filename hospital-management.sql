-- Create Database
CREATE DATABASE hospital_management;
USE hospital_management;

-- Departments
CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Doctors
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Patients
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    gender ENUM('Male','Female','Other') NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    address TEXT
);

-- Rooms
CREATE TABLE Rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type ENUM('General','Private','ICU') NOT NULL,
    availability BOOLEAN NOT NULL DEFAULT TRUE
);

-- Admissions
CREATE TABLE Admissions (
    admission_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    room_id INT NOT NULL UNIQUE, -- one-to-one (room allocated to only one admission at a time)
    admission_date DATE NOT NULL,
    discharge_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

-- Appointments
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason TEXT,
    status ENUM('Scheduled','Completed','Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Medications
CREATE TABLE Medications (
    medication_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Prescriptions
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL UNIQUE, -- one prescription per appointment
    prescribed_date DATE NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Prescription_Medications (Many-to-Many)
CREATE TABLE Prescription_Medications (
    prescription_id INT NOT NULL,
    medication_id INT NOT NULL,
    dosage VARCHAR(50) NOT NULL,
    frequency VARCHAR(50) NOT NULL,
    duration VARCHAR(50),
    PRIMARY KEY (prescription_id, medication_id),
    FOREIGN KEY (prescription_id) REFERENCES Prescriptions(prescription_id),
    FOREIGN KEY (medication_id) REFERENCES Medications(medication_id)
);


-- Departments
INSERT INTO Departments (name) VALUES 
('Cardiology'),
('Neurology'),
('Orthopedics'),
('Pediatrics');

-- Doctors
INSERT INTO Doctors (first_name, last_name, specialization, phone, email, department_id) VALUES
('John', 'Smith', 'Cardiologist', '0712345678', 'jsmith@hospital.com', 1),
('Emily', 'Davis', 'Neurologist', '0723456789', 'edavis@hospital.com', 2),
('Michael', 'Brown', 'Orthopedic Surgeon', '0734567890', 'mbrown@hospital.com', 3),
('Sophia', 'Wilson', 'Pediatrician', '0745678901', 'swilson@hospital.com', 4);

-- Patients
INSERT INTO Patients (first_name, last_name, dob, gender, phone, email, address) VALUES
('Alice', 'Johnson', '1990-05-14', 'Female', '0798765432', 'alicej@example.com', 'Nairobi, Kenya'),
('Brian', 'Kiptoo', '1985-08-21', 'Male', '0787654321', 'bkiptoo@example.com', 'Eldoret, Kenya'),
('Catherine', 'Wanjiku', '2000-11-30', 'Female', '0776543210', 'cwanjiku@example.com', 'Mombasa, Kenya');

-- Rooms
INSERT INTO Rooms (room_number, room_type, availability) VALUES
('101', 'General', TRUE),
('102', 'Private', TRUE),
('201', 'ICU', TRUE);

-- Admissions
INSERT INTO Admissions (patient_id, room_id, admission_date, discharge_date) VALUES
(1, 1, '2025-09-01', NULL),
(2, 2, '2025-09-05', '2025-09-10');

-- Appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, reason, status) VALUES
(1, 1, '2025-09-15 10:00:00', 'Chest pain', 'Completed'),
(2, 2, '2025-09-16 11:30:00', 'Headache and dizziness', 'Completed'),
(3, 4, '2025-09-20 09:00:00', 'Fever and cough', 'Scheduled');

-- Medications
INSERT INTO Medications (name, description) VALUES
('Paracetamol', 'Pain reliever and fever reducer'),
('Amoxicillin', 'Antibiotic used for bacterial infections'),
('Aspirin', 'Used to reduce pain, fever, or inflammation');

-- Prescriptions
INSERT INTO Prescriptions (appointment_id, prescribed_date) VALUES
(1, '2025-09-15'),
(2, '2025-09-16');

-- Prescription_Medications
INSERT INTO Prescription_Medications (prescription_id, medication_id, dosage, frequency, duration) VALUES
(1, 1, '500mg', 'Twice daily', '5 days'),
(1, 3, '100mg', 'Once daily', '7 days'),
(2, 2, '250mg', 'Thrice daily', '10 days');
