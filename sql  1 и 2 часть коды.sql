-- ЧАСТЬ 1. СОЗДАНИЕ СТРУКТУРЫ БД

CREATE DATABASE IF NOT EXISTS finance_db;
USE finance_db;

CREATE TABLE industries (
    industry_id INT PRIMARY KEY,
    industry_name VARCHAR(100) NOT NULL
);

CREATE TABLE locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE companies (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(150) NOT NULL,
    inn VARCHAR(12) NOT NULL UNIQUE,
    foundation_year INT,
    headquarters VARCHAR(100),
    industry_id INT NOT NULL,
    location_id INT,
    FOREIGN KEY (industry_id) REFERENCES industries(industry_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE managers (
    manager_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(150) NOT NULL,
    position VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    company_id INT NOT NULL,
    FOREIGN KEY (company_id) REFERENCES companies(company_id) ON DELETE CASCADE
);

CREATE TABLE financial_indicators (
    company_id INT NOT NULL,
    report_year INT NOT NULL,
    roa DECIMAL(8,2),
    ros DECIMAL(8,2),
    roe DECIMAL(8,2),
    asset_turnover DECIMAL(8,2),
    debt_eq DECIMAL(8,2),
    revenue DECIMAL(15,2),
    profit DECIMAL(15,2),
    PRIMARY KEY (company_id, report_year),
    FOREIGN KEY (company_id) REFERENCES companies(company_id) ON DELETE CASCADE
);

CREATE TABLE system_users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    role_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- ВСТАВКА ДАННЫХ

INSERT INTO industries VALUES 
(1, 'Нефтегаз'), (2, 'Банковский сектор'), (3, 'Металлургия'), 
(4, 'Автомобилестроение'), (5, 'Химическая промышленность'), (6, 'Телекоммуникации');

INSERT INTO locations (city_name) VALUES 
('Москва'), ('Санкт-Петербург'), ('Норильск'), ('Набережные Челны'), ('Великий Новгород'), ('Казань'), ('Екатеринбург');

INSERT INTO companies (company_id, company_name, inn, foundation_year, headquarters, industry_id, location_id) VALUES 
(1, 'ПАО Газпром', '7736050003', 1989, 'Москва', 1, 1),
(2, 'ПАО Сбербанк', '7707083893', 1841, 'Москва', 2, 1),
(3, 'ПАО Норникель', '8401005730', 1993, 'Норильск', 3, 3),
(4, 'ПАО КАМАЗ', '1650032058', 1969, 'Набережные Челны', 4, 4),
(5, 'ПАО Роснефть', '7706107510', 1993, 'Москва', 1, 1),
(6, 'ПАО Лукойл', '7708004767', 1991, 'Москва', 1, 1),
(7, 'ПАО МТС', '7740000076', 1993, 'Москва', 6, 1),
(8, 'ПАО Ростелеком', '7707049388', 1993, 'Москва', 6, 1),
(9, 'ПАО Акрон', '5321019764', 1961, 'Великий Новгород', 5, 5),
(10, 'ПАО ФосАгро', '7722035361', 2001, 'Москва', 5, 1);

INSERT INTO managers (full_name, position, phone, company_id) VALUES 
('Иванов Иван Иванович', 'Генеральный директор', '+7(495)111-11-11', 1),
('Петров Петр Петрович', 'Финансовый директор', '+7(495)222-22-22', 1),
('Сидорова Анна Сергеевна', 'Председатель правления', '+7(495)333-33-33', 2),
('Смирнов Алексей Владимирович', 'Директор по развитию', '+7(495)444-44-44', 2),
('Кузнецов Дмитрий Олегович', 'Финансовый аналитик', '+7(495)555-55-55', 3),
('Васильев Сергей Николаевич', 'Генеральный директор', '+7(855)666-66-66', 4),
('Михайлов Андрей Викторович', 'Коммерческий директор', '+7(495)777-77-77', 5),
('Федорова Елена Дмитриевна', 'Главный бухгалтер', '+7(495)888-88-88', 6);

INSERT INTO financial_indicators VALUES 
(1, 2022, 5.3, 10.5, 12.1, 0.5, 1.2, 11673000, 1226000),
(1, 2023, 4.8, 10.5, 11.5, 0.4, 1.3, 10500000, 1100000),
(2, 2022, 3.0, 26.7, 15.0, 0.1, 0.8, 4500000, 1200000),
(2, 2023, 3.1, 27.0, 15.5, 0.1, 0.9, 4800000, 1300000),
(3, 2022, 12.0, 25.0, 20.0, 0.5, 0.5, 1200000, 300000),
(3, 2023, 11.5, 24.3, 19.5, 0.4, 0.6, 1150000, 280000),
(4, 2022, 1.7, 3.3, 3.0, 0.5, 2.5, 150000, 5000),
(4, 2023, 1.9, 3.7, 3.2, 0.5, 2.4, 160000, 6000),
(5, 2022, 5.3, 11.2, 13.2, 0.5, 1.1, 8500000, 950000),
(5, 2023, 5.3, 11.1, 13.3, 0.5, 1.0, 8800000, 980000),
(6, 2022, 5.0, 10.2, 12.5, 0.5, 0.9, 7800000, 800000),
(6, 2023, 5.2, 10.5, 12.8, 0.5, 0.9, 8100000, 850000),
(7, 2022, 4.6, 8.5, 10.2, 0.6, 1.5, 650000, 55000),
(7, 2023, 4.6, 8.5, 10.3, 0.5, 1.4, 680000, 58000),
(8, 2022, 3.8, 7.2, 9.5, 0.5, 1.4, 580000, 42000),
(8, 2023, 3.9, 7.5, 9.8, 0.5, 1.3, 600000, 45000),
(9, 2022, 7.8, 15.9, 15.5, 0.5, 0.7, 220000, 35000),
(9, 2023, 8.1, 15.8, 16.0, 0.5, 0.7, 240000, 38000),
(10, 2022, 9.2, 15.5, 17.0, 0.6, 0.6, 310000, 48000),
(10, 2023, 9.6, 15.7, 17.5, 0.6, 0.6, 330000, 52000);

INSERT INTO system_users (username, role_name, email) VALUES 
('analyst_ivan', 'Аналитик', 'ivan@finance.ru'),
('investor_petr', 'Инвестор', 'petr@mail.ru'),
('manager_svetlana', 'Менеджер', 'sveta@company.ru'),
('admin_db', 'Администратор БД', 'admin@finance.ru'),
('analyst_olga', 'Аналитик', 'olga@finance.ru'),
('investor_max', 'Инвестор', 'max@mail.ru');

ALTER TABLE companies ADD COLUMN description TEXT;

UPDATE companies SET headquarters = 'Санкт-Петербург' WHERE company_id = 6;

DELETE FROM managers WHERE manager_id = 8;

CREATE USER 'analyst'@'localhost' IDENTIFIED BY 'Analyst123!';
GRANT SELECT, INSERT, UPDATE ON finance_db.* TO 'analyst'@'localhost';

CREATE USER 'investor'@'localhost' IDENTIFIED BY 'Investor123!';
GRANT SELECT ON finance_db.* TO 'investor'@'localhost';

CREATE USER 'manager'@'localhost' IDENTIFIED BY 'Manager123!';
GRANT SELECT ON finance_db.* TO 'manager'@'localhost';

CREATE USER 'admin_db'@'localhost' IDENTIFIED BY 'Admin123!';
GRANT ALL PRIVILEGES ON finance_db.* TO 'admin_db'@'localhost';

FLUSH PRIVILEGES;

DESCRIBE industries;
DESCRIBE locations;
DESCRIBE companies;
DESCRIBE managers;
DESCRIBE financial_indicators;
DESCRIBE system_users;


-- ЧАСТЬ 2. ЗАПРОСЫ

-- 1. Неявное соединение (WHERE + ORDER BY)
SELECT c.company_name, i.industry_name, f.revenue
FROM companies c, industries i, financial_indicators f
WHERE c.company_id = f.company_id 
  AND c.industry_id = i.industry_id
  AND f.revenue > 5000000
ORDER BY f.revenue DESC;

-- 2. Явное соединение (JOIN)
SELECT c.company_name, m.full_name, m.position
FROM companies c
JOIN managers m ON c.company_id = m.company_id;

-- 3. Агрегация (SUM, AVG, COUNT, MAX, MIN)
SELECT 
    SUM(revenue) AS total_revenue,
    AVG(profit) AS avg_profit,
    COUNT(company_id) AS total_companies,
    MAX(roa) AS max_roa,
    MIN(roa) AS min_roa
FROM financial_indicators;

-- 4. Группировка (GROUP BY) и фильтрация (HAVING)
SELECT i.industry_name, AVG(f.revenue) AS avg_revenue
FROM industries i
JOIN companies c ON i.industry_id = c.industry_id
JOIN financial_indicators f ON c.company_id = f.company_id
GROUP BY i.industry_name
HAVING AVG(f.revenue) > 2000000;

-- 5. Вложенные подзапросы (IN, ALL)
SELECT company_name 
FROM companies 
WHERE company_id IN (
    SELECT company_id 
    FROM financial_indicators 
    WHERE revenue > (SELECT AVG(revenue) FROM financial_indicators)
);

SELECT company_name 
FROM companies 
WHERE company_id IN (
    SELECT company_id 
    FROM financial_indicators 
    WHERE roa > ALL (
        SELECT roa 
        FROM financial_indicators 
        WHERE company_id IN (SELECT company_id FROM companies WHERE industry_id = 1)
    )
);

-- 6. Функции управления потоком (CASE)
SELECT 
    c.company_name,
    f.revenue,
    CASE 
        WHEN f.revenue > 10000000 THEN 'Крупная'
        WHEN f.revenue BETWEEN 1000000 AND 10000000 THEN 'Средняя'
        ELSE 'Малая'
    END AS company_size
FROM companies c
JOIN financial_indicators f ON c.company_id = f.company_id;

-- 7. Представление (VIEW) и WITH
CREATE VIEW top_companies AS
SELECT c.company_name, i.industry_name, f.revenue
FROM companies c
JOIN industries i ON c.industry_id = i.industry_id
JOIN financial_indicators f ON c.company_id = f.company_id
WHERE f.revenue > 5000000;

SELECT * FROM top_companies;

WITH avg_revenue_by_industry AS (
    SELECT i.industry_name, AVG(f.revenue) AS avg_rev
    FROM industries i
    JOIN companies c ON i.industry_id = c.industry_id
    JOIN financial_indicators f ON c.company_id = f.company_id
    GROUP BY i.industry_name
)
SELECT * FROM avg_revenue_by_industry WHERE avg_rev > 2000000;

-- 8. EXPLAIN и индексы
EXPLAIN SELECT * FROM companies WHERE industry_id = 1;
CREATE INDEX idx_industry ON companies(industry_id);
CREATE INDEX idx_year ON financial_indicators(report_year);

-- 9. Транзакции
START TRANSACTION;
INSERT INTO companies (company_id, company_name, inn, foundation_year, headquarters, industry_id, location_id) 
VALUES (12, 'ПАО Тест2', '1234567891', 2020, 'Москва', 1, 1);
INSERT INTO financial_indicators (company_id, report_year, roa, ros, roe, asset_turnover, debt_eq, revenue, profit) 
VALUES (12, 2024, 10.5, 5.0, 15.0, 1.0, 0.5, 1000000, 100000);
COMMIT;

-- 10. PREPARE / EXECUTE / DEALLOCATE
PREPARE get_company_data FROM 'SELECT company_name, inn FROM companies WHERE company_id = ?';
SET @id = 1;
EXECUTE get_company_data USING @id;
DEALLOCATE PREPARE get_company_data;