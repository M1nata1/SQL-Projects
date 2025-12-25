drop table if exists Users, PaymentCards, Subscriptions, SubscriptionPlans, UserFollowsAuthors, UserSavedAlbums, Authors, Albums, Playlists, Tracks, Musics, MusicTag, Tags, ListeningStory cascade;
create table Users (
	user_ID serial primary key,
	user_name varchar(255) not null,
	user_surname varchar(255) not null,
	email varchar(255) not null,
	password_hash varchar(255) not null,
	phone_number varchar(255),
	profile_photo varchar(255),
	gender varchar(255),
	date_of_birth varchar(255),
	region varchar(255) not null
);

create table PaymentCards (
	paymentID serial primary key,
	userID integer not null,
	providerToken varchar(255) not null,
	last_4_digits varchar(4) not null,
	card_brand varchar(255) not null,
	is_default varchar(255) not null,
	foreign key (user_id) references Users(user_id)
);

create table SubscriptionPlans (
	subscription_plan_id serial,
	subscription_name varchar(255) not null,
	subscription_price decimal(10,2) not null,
	subscription_duration_days integer not null
);

create table Subscriptions (
	subscription_ID serial,
	status varchar(255) not null,
	start_date varchar(255) not null,
	end_date varchar(255) not null,
	auto_renew boolean not null,
	subscription_plan_id integer not null,
	user_id integer not null,
	foreign key (subscription_plan_id) references SubscriptionPlans(subscription_plan_id),
	foreign key (user_id) references Users(user_id)
);

create table Authors (
	author_id serial,
	author_name varchar(255) not null,
	author_surname varchar(255) not null,
	count_of_auditions integer not null,
);

create table Albums (
	album_id serial,
	album_name varchar(255) not null,
	album_poster varchar(255) not null,
	album_release_date varchar(255) not null,
	author_id integer not null,
	foreign key (author_id) references Authors(author_id)
);

create table Musics (
	music_ID serial,
	mus
)
create table Tags (
	tag_ID serial,
	tag_name varchar(255) not null,
	tag_type varchar(255) not null
);

create table MusicTag (
	music_tag_ID serial,
	tag_ID integer not null unique,
	music_ID integer not null unique,
)

