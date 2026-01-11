-- =====================================
-- Swimming Competition Database - SCHEMA
-- FINAL SIMPLIFIED VERSION
-- =====================================

DROP DATABASE IF EXISTS swimming;
CREATE DATABASE swimming;
USE swimming;

-- =====================================
-- 1. ADDRESSES
-- =====================================
CREATE TABLE addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    zip_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
    UNIQUE (street, city, zip_code)
);

-- =====================================
-- 2. CLUBS
-- =====================================
CREATE TABLE clubs (
    club_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    address_id INT,
    FOREIGN KEY (address_id)
        REFERENCES addresses(address_id)
        ON DELETE RESTRICT
);

-- =====================================
-- 3. PARTICIPANTS
-- =====================================
CREATE TABLE participants (
    participant_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    gender ENUM('M','F') NOT NULL,
    club_id INT,
    address_id INT,
    email VARCHAR(100) UNIQUE,

    FOREIGN KEY (club_id)
        REFERENCES clubs(club_id)
        ON DELETE SET NULL,
    FOREIGN KEY (address_id)
        REFERENCES addresses(address_id)
        ON DELETE SET NULL
);

-- =====================================
-- 4. POOLS
-- =====================================
CREATE TABLE pools (
    pool_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    length_m INT NOT NULL,
    lanes INT NOT NULL,
    address_id INT NOT NULL,
    UNIQUE (name, address_id),

    FOREIGN KEY (address_id)
        REFERENCES addresses(address_id)
        ON DELETE RESTRICT
);

-- =====================================
-- 5. COMPETITIONS
-- =====================================
CREATE TABLE competitions (
    competition_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    pool_id INT NOT NULL,

    FOREIGN KEY (pool_id)
        REFERENCES pools(pool_id)
        ON DELETE RESTRICT
);

-- =====================================
-- 6. AGE GROUPS
-- =====================================
CREATE TABLE age_groups (
    age_group_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    min_age INT NOT NULL,
    max_age INT NOT NULL
);

-- =====================================
-- 7. COMPETITION GROUPS
-- =====================================
CREATE TABLE competition_groups (
    group_id INT AUTO_INCREMENT PRIMARY KEY,
    age_group_id INT NOT NULL,
    gender ENUM('M','F') NOT NULL,
    UNIQUE (age_group_id, gender),

    FOREIGN KEY (age_group_id)
        REFERENCES age_groups(age_group_id)
        ON DELETE RESTRICT
);

-- =====================================
-- 8. DISTANCES
-- =====================================
CREATE TABLE distances (
    distance_id INT AUTO_INCREMENT PRIMARY KEY,
    meters INT NOT NULL UNIQUE
);

-- =====================================
-- 9. STYLES
-- =====================================
CREATE TABLE styles (
    style_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- =====================================
-- 10. REGISTRATIONS
-- =====================================
CREATE TABLE registrations (
    registration_id INT AUTO_INCREMENT PRIMARY KEY,
    participant_id INT NOT NULL,
    competition_id INT NOT NULL,
    style_id INT NOT NULL,
    distance_id INT NOT NULL,
    group_id INT NOT NULL,
    seed_time_seconds DECIMAL(5,2),

    UNIQUE (participant_id, competition_id, style_id, distance_id),

    FOREIGN KEY (participant_id)
        REFERENCES participants(participant_id)
        ON DELETE RESTRICT,
    FOREIGN KEY (competition_id)
        REFERENCES competitions(competition_id)
        ON DELETE RESTRICT,
    FOREIGN KEY (style_id)
        REFERENCES styles(style_id)
        ON DELETE RESTRICT,
    FOREIGN KEY (distance_id)
        REFERENCES distances(distance_id)
        ON DELETE RESTRICT,
    FOREIGN KEY (group_id)
        REFERENCES competition_groups(group_id)
        ON DELETE RESTRICT
);

-- =====================================
-- 11. ROUNDS
-- =====================================
CREATE TABLE rounds (
    round_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    round_order INT NOT NULL
);

-- =====================================
-- 12. HEATS
-- =====================================
CREATE TABLE heats (
    heat_id INT AUTO_INCREMENT PRIMARY KEY,
    competition_id INT NOT NULL,
    group_id INT NOT NULL,
    style_id INT NOT NULL,
    distance_id INT NOT NULL,
    round_id INT NOT NULL,
    heat_number INT NOT NULL,

    UNIQUE (
        competition_id,
        group_id,
        style_id,
        distance_id,
        round_id,
        heat_number
    ),

    FOREIGN KEY (competition_id)
        REFERENCES competitions(competition_id)
        ON DELETE RESTRICT,
    FOREIGN KEY (group_id)
        REFERENCES competition_groups(group_id)
        ON DELETE RESTRICT,
    FOREIGN KEY (style_id)
        REFERENCES styles(style_id)
        ON DELETE RESTRICT,
    FOREIGN KEY (distance_id)
        REFERENCES distances(distance_id)
        ON DELETE RESTRICT,
    FOREIGN KEY (round_id)
        REFERENCES rounds(round_id)
        ON DELETE RESTRICT
);

-- =====================================
-- 13. HEAT ASSIGNMENTS
-- =====================================
CREATE TABLE heat_assignments (
    heat_assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    heat_id INT NOT NULL,
    registration_id INT NOT NULL,
    lane_number INT NOT NULL,

    UNIQUE (heat_id, lane_number),

    FOREIGN KEY (heat_id)
        REFERENCES heats(heat_id)
        ON DELETE CASCADE,
    FOREIGN KEY (registration_id)
        REFERENCES registrations(registration_id)
        ON DELETE CASCADE
);

-- =====================================
-- 14. RESULTS
-- =====================================
CREATE TABLE results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    heat_assignment_id INT NOT NULL,
    final_time_seconds DECIMAL(5,2),
    finish_position INT,
    disqualified BOOLEAN DEFAULT FALSE,

    FOREIGN KEY (heat_assignment_id)
        REFERENCES heat_assignments(heat_assignment_id)
        ON DELETE CASCADE
);

/*
RESULTS interpretation:

| Situation            | Rule                                               |
|---------------------|----------------------------------------------------|
| Did not show up     | final_time_seconds IS NULL AND disqualified = FALSE|
| Disqualified        | disqualified = TRUE                                |
| Swam                | final_time_seconds IS NOT NULL                     |
| Did not qualify     | registration exists but no heat_assignment         |
*/
