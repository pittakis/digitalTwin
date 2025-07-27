--initDatabse.sql
-- DROP DATABASE IF EXISTS mydatabase;
-- CREATE DATABASE mydatabase OWNER admin;
-- GRANT ALL PRIVILEGES ON DATABASE mydatabase TO admin;


-- building table
CREATE TABLE IF NOT EXISTS buildings (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    locations JSON DEFAULT '{}'::JSON
);

-- user table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    building_id INTEGER NOT NULL REFERENCES buildings(id)
);

-- sensor types table
CREATE TABLE IF NOT EXISTS sensor_types (
    id SERIAL PRIMARY KEY,
    type VARCHAR(100) NOT NULL
);

-- sensors table
CREATE TABLE IF NOT EXISTS sensors (
    id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255),
    latest_data JSON DEFAULT '{}'::JSON,
    last_updated  TIMESTAMP,
    building_id INTEGER NOT NULL REFERENCES buildings(id),
    type_id INTEGER NOT NULL REFERENCES sensor_types(id)
);

CREATE TABLE IF NOT EXISTS sensor_data (
    id SERIAL PRIMARY KEY,
    sensor_id VARCHAR(255) REFERENCES sensors(id) ON DELETE CASCADE,
    data JSON NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- fill database with initial data
-- buildings
INSERT INTO buildings (name) VALUES ('FASADA');

-- sensor types
INSERT INTO sensor_types (type) VALUES 
('AirQuality'), 
('Heater'), 
('EnergyMeter');

-- users
INSERT INTO users (username, password, building_id) VALUES  ('admin', 'admin123!', 1);

-- Insert AirQuality sensors
INSERT INTO sensors (id, name, location, building_id, type_id) VALUES
('70:ee:50:83:2a:6c', 'AirQuality_Kitchen', 'Kitchen', 1, 1),
('70:ee:50:83:2e:54', 'AirQuality_ClassRoom1', 'Classroom 1', 1, 1),
('70:ee:50:83:4e:60', 'AirQuality_ClassRoom2', 'Classroom 2', 1, 1),
('70:ee:50:83:2f:44', 'AirQuality_ClassRoom3', 'Classroom 3', 1, 1),
('70:ee:50:83:2a:82', 'AirQuality_ClassRoom4', 'Classroom 4', 1, 1),
('70:ee:50:83:32:66', 'AirQuality_ClassRoom5', 'Classroom 5', 1, 1),
('70:ee:50:83:2a:36', 'AirQuality_CheckRoom', 'Checkroom', 1, 1),
('70:ee:50:83:2e:4e', 'AirQuality_ViceDirectorOffice', 'Vice Director Office', 1, 1),
('70:ee:50:83:2f:6c', 'AirQuality_DirectorOffice', 'Director Office', 1, 1),
('70:ee:50:83:35:00', 'AirQuality_Corridor', 'Corridor', 1, 1),
('70:ee:50:83:4d:e8', 'AirQuality_OfficeFirstFloor', 'Office 1st Floor', 1, 1);

-- Insert EnergyMeter sensors
INSERT INTO sensors (id, name, location, building_id, type_id) VALUES
('shellypro3em-08f9e0e5121c', 'EnergyMeter_Kindergarden_1', 'Kindergarten', 1, 3),
('shellypro3em-34987a45dcd4', 'EnergyMeter_Kindergarden_2', 'Kindergarten', 1, 3),
('shellypro3em-34987a46bc6c', 'EnergyMeter_Kindergarden_3', 'Kindergarten', 1, 3);

-- Insert Heater sensors
INSERT INTO sensors (id, name, location, building_id, type_id) VALUES
('shellytrv-588e81a41b41', 'Heater_ClassRoom1_1', 'Classroom 1', 1, 2),
('shellytrv-588e81a41b77', 'Heater_ClassRoom1_2', 'Classroom 1', 1, 2),
('shellytrv-bc33ac022fa8', 'Heater_ClassRoom1_3', 'Classroom 1', 1, 2),
('shellytrv-842e14fe1fc2', 'Heater_ClassRoom1_4', 'Classroom 1', 1, 2),
('shellytrv-bc33ac022f76', 'Heater_ClassRoom2_1', 'Classroom 2', 1, 2),
('shellytrv-bc33ac022fb6', 'Heater_ClassRoom2_2', 'Classroom 2', 1, 2),
('shellytrv-842e14ffcbea', 'Heater_ClassRoom2_3', 'Classroom 2', 1, 2),
('shellytrv-588e816162de', 'Heater_ClassRoom3_1', 'Classroom 3', 1, 2),
('shellytrv-842e14ffca22', 'Heater_ClassRoom3_2', 'Classroom 3', 1, 2),
('shellytrv-588e81616fe8', 'Heater_ClassRoom3_3', 'Classroom 3', 1, 2),
('shellytrv-588e81617272', 'Heater_ClassRoom4_1', 'Classroom 4', 1, 2),
('shellytrv-588e81a63315', 'Heater_ClassRoom4_2', 'Classroom 4', 1, 2),
('shellytrv-842e14fe1d64', 'Heater_ClassRoom4_3', 'Classroom 4', 1, 2),
('shellytrv-588e81a41b47', 'Heater_ClassRoom5_1', 'Classroom 5', 1, 2),
('shellytrv-8cf681be1032', 'Heater_ClassRoom5_2', 'Classroom 5', 1, 2),
('shellytrv-8cf681a52e44', 'Heater_ClassRoom5_3', 'Classroom 5', 1, 2),
('shellytrv-8cf681b70b5a', 'Heater_ClassRoom5_4', 'Classroom 5', 1, 2),
('shellytrv-cc86ecb3e4cd', 'Heater_CheckRoom', 'Checkroom', 1, 2),
('shellytrv-8cf681be1608', 'Heater_ViceDirectorOffice', 'Vice Director Office', 1, 2),
('shellytrv-8cf681d9a230', 'Heater_DirectorOffice', 'Director Office', 1, 2),
('shellytrv-588e81a6306d', 'Heater_Corridor_1', 'Corridor', 1, 2),
('shellytrv-842e14ffcb48', 'Heater_Corridor_2', 'Corridor', 1, 2),
('shellytrv-8cf681b70b5e', 'Heater_Corridor_3', 'Corridor', 1, 2),
('shellytrv-8cf681b9c952', 'Heater_Corridor_4', 'Corridor', 1, 2),
('shellytrv-b4e3f9d9e3d7', 'Heater_Corridor_5', 'Corridor', 1, 2),
('shellytrv-b4e3f9e30ab3', 'Heater_Corridor_6', 'Corridor', 1, 2),
('shellytrv-8cf681d9a228', 'Heater_Corridor_7', 'Corridor', 1, 2),
('shellytrv-8cf681e9a780', 'Heater_Corridor_8', 'Corridor', 1, 2),
('shellytrv-b4e3f9d6249d', 'Heater_Corridor_9', 'Corridor', 1, 2),
('shellytrv-8cf681a52e2e', 'Heater_Kitchen_1', 'Kitchen', 1, 2),
('shellytrv-8cf681c1abc8', 'Heater_Kitchen_2', 'Kitchen', 1, 2),
('shellytrv-8cf681b9c9ae', 'Heater_Kitchen_3', 'Kitchen', 1, 2),
('shellytrv-8cf681cd22c2', 'Heater_Kitchen_4', 'Kitchen', 1, 2),
('shellytrv-8cf681b70e6c', 'Heater_Bathroom_1', 'Bathroom', 1, 2),
('shellytrv-8cf681cd15a2', 'Heater_Bathroom_2', 'Bathroom', 1, 2),
('shellytrv-8cf681be083a', 'Heater_Bathroom_3', 'Bathroom', 1, 2),
('shellytrv-8cf681b9c924', 'Heater_SocialRoom', 'Social room', 1, 2),
('shellytrv-8cf681cd1598', 'Heater_StaffToilet', 'Staff toilet', 1, 2),
('shellytrv-8cf681a51bae', 'Heater_OfficeRoom1', 'Office room 1', 1, 2),
('shellytrv-b4e3f9d9bc83', 'Heater_OfficeRoom2', 'Office room 2', 1, 2),
('shellytrv-842e14ffaf1c', 'Heater_OfficeRoom3', 'Office room 3', 1, 2);