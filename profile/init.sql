CREATE TABLE IF NOT EXISTS articles (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL UNIQUE,
    slug VARCHAR(255) NOT NULL UNIQUE,
    pub_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    time_to_read INT,
    excerpt TEXT,
    html_file_path VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

INSERT INTO articles (title, slug, pub_date, time_to_read, excerpt, html_file_path) VALUES 
    ('Sample Article', 'sample-article', NOW(), 1, 'Lorem Ipsum ...', '/posts/sample.html');
