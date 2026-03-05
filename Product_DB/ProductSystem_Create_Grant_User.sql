-- ==============================
-- Create User
-- ==============================

CREATE USER IF NOT EXISTS 'psm'@'%'
IDENTIFIED BY 'StrongPassword123!';

-- ==============================
-- Grant All Privileges on Schema
-- ==============================

GRANT ALL PRIVILEGES
ON ProductSystem.*
TO 'psm'@'%';

-- ==============================
-- Refresh Privileges
-- ==============================

FLUSH PRIVILEGES;