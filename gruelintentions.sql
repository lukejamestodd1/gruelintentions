CREATE DATABASE gruelintentions;

CREATE TABLE users (
	id SERIAL4 PRIMARY KEY,
	email VARCHAR(200) NOT NULL,
	name VARCHAR(100),
	password_digest VARCHAR(400) NOT NULL
);

CREATE TABLE dishes (
	id SERIAL4 PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  image_url VARCHAR(200),
  description VARCHAR(400),
  user_id INTEGER,
  image VARCHAR(500)
);

CREATE TABLE likes (
	id SERIAL4 PRIMARY KEY,
	user_id INTEGER NOT NULL,
	dish_id INTEGER NOT NULL
);

INSERT INTO users ()




[1] pry(main)> dish = Dish.new
=> #<Dish:0x007f840ccd86c8
 id: nil,
 name: nil,
 image_url: nil,
 description: nil,
 user_id: nil,
 image: nil>
[2] pry(main)> dish.name = 'sdfsdfsdf'
=> "sdfsdfsdf"
[3] pry(main)> dish.image = File.open('test.jpg')
=> #<File:test.jpg>
[4] pry(main)> dish.save
D, [2016-01-28T11:53:22.508615 #38155] DEBUG -- :    (0.3ms)  BEGIN
D, [2016-01-28T11:53:22.524310 #38155] DEBUG -- :   SQL (3.1ms)  INSERT INTO "dishes" ("name", "image") VALUES ($1, $2) RETURNING "id"  [["name", "sdfsdfsdf"], ["image", "test.jpg"]]
D, [2016-01-28T11:53:22.812473 #38155] DEBUG -- :    (2.8ms)  COMMIT
=> true
[5] pry(main)> exit