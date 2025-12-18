
-- Swimming competitions project database

CREATE DATABASE IF NOT EXISTS swimming;
USE swimming;

-- ADDRESSES
CREATE TABLE addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    postal_code VARCHAR(20),
    country VARCHAR(50) NOT NULL
);

-- CLUBS
CREATE TABLE clubs (
    club_id INT AUTO_INCREMENT PRIMARY KEY,
    club_name VARCHAR(100) NOT NULL,
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES addresses(address_id)
);

-- PARTICIPANTS
CREATE TABLE participants (
    participant_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('M','F') NOT NULL,
    birth_date DATE NOT NULL,
    club_id INT,
    address_id INT,
    FOREIGN KEY (club_id) REFERENCES clubs(club_id),
    FOREIGN KEY (address_id) REFERENCES addresses(address_id)
);

-- POOLS
CREATE TABLE pools (
    pool_id INT AUTO_INCREMENT PRIMARY KEY,
    pool_name VARCHAR(100) NOT NULL,
    pool_length_m INT NOT NULL,
    lanes_count INT NOT NULL,
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES addresses(address_id)
);

-- COMPETITIONS
CREATE TABLE competitions (
    competition_id INT AUTO_INCREMENT PRIMARY KEY,
    competition_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    pool_id INT NOT NULL,
    FOREIGN KEY (pool_id) REFERENCES pools(pool_id)
);

-- SWIM_STYLES
CREATE TABLE swim_styles (
    style_id INT AUTO_INCREMENT PRIMARY KEY,
    style_name VARCHAR(50) NOT NULL
);

-- DISTANCES
CREATE TABLE distances (
    distance_id INT AUTO_INCREMENT PRIMARY KEY,
    meters INT NOT NULL
);

-- AGE_GROUPS
CREATE TABLE age_groups (
    age_group_id INT AUTO_INCREMENT PRIMARY KEY,
    min_age INT NOT NULL,
    max_age INT NOT NULL,
    label VARCHAR(20) NOT NULL
);

-- ROUNDS
CREATE TABLE rounds (
    round_id INT AUTO_INCREMENT PRIMARY KEY,
    round_name VARCHAR(50) NOT NULL,
    round_order INT NOT NULL
);
-- round_name (Heats, Semifinal, Final)


-- COMPETITION_GROUPS
CREATE TABLE competition_groups (
    group_id INT AUTO_INCREMENT PRIMARY KEY,
    competition_id INT NOT NULL,
    age_group_id INT NOT NULL,
    gender ENUM('M','F') NOT NULL,
    FOREIGN KEY (competition_id) REFERENCES competitions(competition_id),
    FOREIGN KEY (age_group_id) REFERENCES age_groups(age_group_id)
);

-- REGISTRATIONS
CREATE TABLE registrations (
    registration_id INT AUTO_INCREMENT PRIMARY KEY,
    participant_id INT NOT NULL,
    competition_id INT NOT NULL,
    style_id INT NOT NULL,
    distance_id INT NOT NULL,
    group_id INT NOT NULL,
    seed_time_seconds DECIMAL(5,2),
    FOREIGN KEY (participant_id) REFERENCES participants(participant_id),
    FOREIGN KEY (competition_id) REFERENCES competitions(competition_id),
    FOREIGN KEY (style_id) REFERENCES swim_styles(style_id),
    FOREIGN KEY (distance_id) REFERENCES distances(distance_id),
    FOREIGN KEY (group_id) REFERENCES competition_groups(group_id)
);

-- HEATS
CREATE TABLE heats (
    heat_id INT AUTO_INCREMENT PRIMARY KEY,
    group_id INT NOT NULL,
    round_id INT NOT NULL,
    heat_number INT NOT NULL,
    FOREIGN KEY (group_id) REFERENCES competition_groups(group_id),
    FOREIGN KEY (round_id) REFERENCES rounds(round_id)
);

-- HEAT_ASSIGNMENTS
CREATE TABLE heat_assignments (
    heat_assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    heat_id INT NOT NULL,
    registration_id INT NOT NULL,
    lane_number INT NOT NULL,
    FOREIGN KEY (heat_id) REFERENCES heats(heat_id),
    FOREIGN KEY (registration_id) REFERENCES registrations(registration_id)
);

-- RESULTS
CREATE TABLE results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    heat_assignment_id INT NOT NULL,
    final_time_seconds DECIMAL(5,2),
    finish_position INT,
    disqualified BOOLEAN,
    FOREIGN KEY (heat_assignment_id) REFERENCES heat_assignments(heat_assignment_id)
);
