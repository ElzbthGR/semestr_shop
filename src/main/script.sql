create table bucket (
	email_user varchar(50) not null,
	id_product integer not null
);

create table comments (
	id serial not null,
	email_user varchar(50) not null,
	id_product integer not null,
	comment varchar(50)
);

create table products (
	id serial not null,
	title varchar(50) not null,
	description varchar(500) not null,
	photo_url varchar(200) not null,
	price integer not null,
	date_create timestamp default now()
);

create table tokens (
	email varchar(50) references users(email),
	token varchar(50) unique
);

create table users (
	email varchar(50) primary key,
	password varchar(50) not null,
	name varchar(50) not null,
	is_admin integer default 0
);


