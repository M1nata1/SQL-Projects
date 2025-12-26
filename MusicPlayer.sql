drop table if exists Users, PaymentCards, Subscriptions, SubscriptionPlans, UserFollowsAuthors, UserSavedAlbums, Authors, Albums, Playlists, Tracks, Musics, MusicTag, Tags, ListeningStory cascade;
create table Users (
	user_ID serial primary key,
	user_name varchar(255) not null,
	user_surname varchar(255) not null,
	email varchar(255) not null unique,
	password_hash varchar(255) not null,
	phone_number varchar(255) unique,
	profile_photo varchar(255),
	gender varchar(50),
	date_of_birth date ,
	region varchar(255) not null,
	user_is_deleted boolean not null default false
);

create table PaymentCards (
	payment_ID serial primary key,
	user_ID integer not null,
	providerToken varchar(255) not null unique,
	last_4_digits varchar(4) not null,
	card_brand varchar(255) not null,
	is_default boolean not null,
	foreign key (user_ID) references Users(user_ID) 
);

create table SubscriptionPlans (
	subscription_plan_ID serial primary key,
	subscription_name varchar(255) not null,
	subscription_price decimal(10,2) not null,
	subscription_duration_days integer not null
);

create table Subscriptions (
	subscription_ID serial primary key,
	status varchar(255) not null,
	start_date date not null,
	end_date date not null,
	auto_renew boolean not null,
	subscription_plan_ID integer not null,
	user_ID integer not null,
	foreign key (subscription_plan_ID) references SubscriptionPlans(subscription_plan_ID),
	foreign key (user_ID) references Users(user_ID) 
);

create table Authors (
	author_ID serial primary key,
	author_name varchar(255) not null,
	author_surname varchar(255) not null,
	count_of_auditions integer not null,
	author_is_deleted boolean not null default false
);

create table Albums (
	album_ID serial primary key,
	album_name varchar(255) not null,
	album_poster varchar(255) not null,
	album_release_date date not null,
	author_ID integer not null,
	foreign key (author_ID) references Authors(author_ID) 
);

create table Musics (
	music_ID serial primary key,
	music_name varchar(255) not null,
	music_poster varchar(255) not null,
	music_file varchar(255) not null,
	author_ID integer not null,
	album_ID integer not null,
	count_of_auditions integer default 0,
	music_duration integer not null, -- В секундах
	release_date date not null,
	lyrics json,
	foreign key (author_ID) references Authors(author_ID),
	foreign key (album_ID) references Albums(album_ID)
	
);

create table Tags (
	tag_ID serial primary key,
	tag_name varchar(255) not null,
	tag_type varchar(255) not null
);

create table MusicTag (
	music_tag_ID serial primary key,
	tag_ID integer not null,
	music_ID integer not null,
	foreign key (tag_ID) references Tags(tag_ID),
	foreign key (music_ID) references Musics(music_ID),
	unique (tag_ID, music_ID) -- Это чтобы одна песня не могла иметь два одинковых тега 
);

create table Playlists (
	playlist_ID serial primary key,
	playlist_name varchar(255) not null,
	playlist_poster varchar(255),
	quantity_of_auditions integer default 0,
	is_public boolean not null,
	user_ID integer not null,
	foreign key (user_ID) references Users(user_ID)
);

create table ListeningStory (
	story_id serial primary key,
	music_ID integer not null,
	user_ID integer not null,
	date_of_playing  timestamp with time zone default now() not null,
	duration_of_playing integer not null,
	foreign key (music_ID) references Musics(music_ID),
	foreign key (user_ID) references Users(user_ID)
);

create table Tracks (
	track_ID serial primary key,
	playlist_ID integer not null,
	music_ID integer not null,
	addition_date timestamp default now(),
	foreign key (music_ID) references Musics(music_ID),
	foreign key (playlist_ID) references Playlists(playlist_id)
);

create table UserFollowsAuthors (
	follow_ID serial primary key,
	user_ID integer not null,
	author_ID integer not null,
	foreign key (user_ID) references Users(user_ID),
	foreign key (author_ID) references Authors(author_ID),
	unique (user_ID, author_ID) -- Чтобы пользователь не мог подписаться два раза на одного и того же автора
);

create table UserSavedAlbums (
	saved_albums_ID serial primary key,
	user_ID integer not null,
	album_ID integer not null,
	foreign key (user_ID) references Users(user_ID),
	foreign key (album_ID) references Albums(album_ID),
	unique (user_ID, album_ID) -- Чтобы пользователь не мог добавить два раз один и тот же альбом
);

INSERT INTO Users (user_name, user_surname, email, password_hash, phone_number, profile_photo, gender, date_of_birth, region, user_is_deleted) VALUES
-- Группа 1: Казахстанские имена (Алматы/Астана)
('Arman', 'Suleimenov', 'arman.s@gmail.com', 'h4sh1', '+77011000001', 'img1.jpg', 'Male', '1990-05-12', 'Almaty', false),
('Aizhan', 'Bekova', 'aizhan.b95@mail.ru', 'h4sh2', '+77021000002', 'img2.jpg', 'Female', '1995-08-23', 'Astana', false),
('Serik', 'Akhmetov', 'serik.akhmetov@yandex.kz', 'h4sh3', '+77051000003', 'img3.jpg', 'Male', '1988-02-14', 'Shymkent', false),
('Dana', 'Nurgaliyeva', 'dana.nur@gmail.com', 'h4sh4', '+77771000004', 'img4.jpg', 'Female', '1999-11-30', 'Almaty', false),
('Ruslan', 'Kenenov', 'ruslan.k@bk.ru', 'h4sh5', '+77471000005', 'img5.jpg', 'Male', '1992-06-15', 'Karaganda', false),
('Madina', 'Ospanova', 'madina.os@gmail.com', 'h4sh6', '+77081000006', 'img6.jpg', 'Female', '2001-03-08', 'Astana', false),
('Kairat', 'Nurtas', 'kairat.n@music.kz', 'h4sh7', '+77011000007', 'img7.jpg', 'Male', '1989-01-01', 'Almaty', false),
('Aliya', 'Mustafina', 'aliya.mus@mail.ru', 'h4sh8', '+77711000008', 'img8.jpg', 'Female', '1994-09-19', 'Atyrau', false),
('Bauyrzhan', 'Islamkhan', 'bauka.islam@sport.kz', 'h4sh9', '+77021000009', 'img9.jpg', 'Male', '1993-05-05', 'Taraz', false),
('Galiya', 'Ismailova', 'galiya.ism@gmail.com', 'h4sh10', '+77051000010', 'img10.jpg', 'Female', '1985-07-22', 'Almaty', false),
('Yerlan', 'Karin', 'yerlan.k@gmail.com', 'h4sh11', '+77751000011', 'img11.jpg', 'Male', '1980-04-12', 'Astana', false),
('Saule', 'Rakhimova', 'saule.r88@yandex.ru', 'h4sh12', '+77071000012', 'img12.jpg', 'Female', '1988-12-05', 'Almaty', false),
('Dauren', 'Aidarbekov', 'dauren.aid@mail.ru', 'h4sh13', '+77081000013', 'img13.jpg', 'Male', '1996-02-28', 'Aktau', false),
('Kamila', 'Serikbayeva', 'kami.s@gmail.com', 'h4sh14', '+77471000014', 'img14.jpg', 'Female', '2002-10-10', 'Almaty', false),
('Azamat', 'Musagaliyev', 'azamat.m@tv.ru', 'h4sh15', '+77011000015', 'img15.jpg', 'Male', '1984-05-15', 'Kostanay', false),
('Bibigul', 'Tulegenova', 'bibigul.opera@art.kz', 'h4sh16', '+77021000016', 'img16.jpg', 'Female', '1950-01-01', 'Almaty', false),
('Dimash', 'Adilet', 'dimash.adilet@rich.com', 'h4sh17', '+77771000017', 'img17.jpg', 'Male', '1995-05-17', 'Almaty', false),
('Ainur', 'Toleuova', 'ainur.t@gmail.com', 'h4sh18', '+77051000018', 'img18.jpg', 'Female', '1990-08-08', 'Taldykorgan', false),
('Bakhtiyar', 'Zaynutdinov', 'bakha.z@cska.ru', 'h4sh19', '+77071000019', 'img19.jpg', 'Male', '1998-04-02', 'Taraz', false),
('Assel', 'Sadvakasova', 'assel.sad@kino.kz', 'h4sh20', '+77081000020', 'img20.jpg', 'Female', '1985-03-20', 'Almaty', false),

-- Группа 2: Русскоязычные имена (СНГ/Казахстан)
('Ivan', 'Petrov', 'ivan.p90@mail.ru', 'h4sh21', '+77011000021', 'img21.jpg', 'Male', '1990-01-15', 'Almaty', false),
('Elena', 'Smirnova', 'elena.smir@yandex.kz', 'h4sh22', '+77021000022', 'img22.jpg', 'Female', '1992-06-20', 'Astana', false),
('Dmitriy', 'Kozlov', 'dima.kozlov@bk.ru', 'h4sh23', '+77051000023', 'img23.jpg', 'Male', '1985-11-11', 'Karaganda', false),
('Olga', 'Morozova', 'olga.m@gmail.com', 'h4sh24', '+77771000024', 'img24.jpg', 'Female', '1998-03-30', 'Almaty', false),
('Alexey', 'Sokolov', 'alex.sokol@mail.ru', 'h4sh25', '+77471000025', 'img25.jpg', 'Male', '1995-09-09', 'Pavlodar', false),
('Tatiana', 'Volkova', 'tanya.v@list.ru', 'h4sh26', '+77081000026', 'img26.jpg', 'Female', '1989-12-12', 'Ust-Kamenogorsk', false),
('Andrey', 'Lebedev', 'andrey.leb@gmail.com', 'h4sh27', '+77011000027', 'img27.jpg', 'Male', '1993-07-07', 'Almaty', false),
('Natalia', 'Novikova', 'nata.nov@yandex.ru', 'h4sh28', '+77711000028', 'img28.jpg', 'Female', '1991-05-25', 'Astana', false),
('Maxim', 'Popov', 'max.popov@gmail.com', 'h4sh29', '+77021000029', 'img29.jpg', 'Male', '1987-02-28', 'Semey', false),
('Svetlana', 'Kuznetsova', 'sveta.kuz@mail.ru', 'h4sh30', '+77051000030', 'img30.jpg', 'Female', '1996-10-10', 'Almaty', false),
('Mikhail', 'Egorov', 'misha.egor@bk.ru', 'h4sh31', '+77751000031', 'img31.jpg', 'Male', '1999-01-20', 'Petropavlovsk', false),
('Yulia', 'Fedorova', 'yulia.fed@gmail.com', 'h4sh32', '+77071000032', 'img32.jpg', 'Female', '1994-08-14', 'Almaty', false),
('Nikolay', 'Vasiliev', 'kolya.vas@yandex.kz', 'h4sh33', '+77081000033', 'img33.jpg', 'Male', '1982-04-18', 'Uralsk', false),
('Irina', 'Mikhailova', 'irina.m@list.ru', 'h4sh34', '+77471000034', 'img34.jpg', 'Female', '1986-11-23', 'Kostanay', false),
('Vladimir', 'Pavlov', 'vova.pavlov@gmail.com', 'h4sh35', '+77011000035', 'img35.jpg', 'Male', '1990-06-06', 'Almaty', false),
('Ekaterina', 'Semenova', 'katya.sem@mail.ru', 'h4sh36', '+77021000036', 'img36.jpg', 'Female', '1997-02-02', 'Astana', false),
('Roman', 'Golubev', 'roma.golub@bk.ru', 'h4sh37', '+77771000037', 'img37.jpg', 'Male', '1992-09-17', 'Aktobe', false),
('Marina', 'Vinogradova', 'marina.vin@gmail.com', 'h4sh38', '+77051000038', 'img38.jpg', 'Female', '2000-05-05', 'Almaty', false),
('Igor', 'Bogdanov', 'igor.bog@yandex.ru', 'h4sh39', '+77071000039', 'img39.jpg', 'Male', '1988-12-30', 'Kyzylorda', false),
('Anastasia', 'Vorobyova', 'nastya.vor@list.ru', 'h4sh40', '+77081000040', 'img40.jpg', 'Female', '1995-07-07', 'Almaty', false),

-- Группа 3: Международные имена (Экспаты, Студенты)
('John', 'Smith', 'john.smith.kz@gmail.com', 'h4sh41', '+12025550041', 'img41.jpg', 'Male', '1985-03-12', 'New York', false),
('Emily', 'Johnson', 'emily.j@yahoo.com', 'h4sh42', '+447911120042', 'img42.jpg', 'Female', '1992-07-25', 'London', false),
('Michael', 'Brown', 'mike.brown@outlook.com', 'h4sh43', '+13105550043', 'img43.jpg', 'Male', '1990-11-05', 'Chicago', false),
('Sarah', 'Davis', 'sarah.d@gmail.com', 'h4sh44', '+14165550044', 'img44.jpg', 'Female', '1988-02-20', 'Toronto', false),
('David', 'Wilson', 'david.wilson@corp.com', 'h4sh45', '+61400120045', 'img45.jpg', 'Male', '1982-09-14', 'Sydney', false),
('Jessica', 'Miller', 'jess.miller@gmail.com', 'h4sh46', '+15125550046', 'img46.jpg', 'Female', '1995-04-18', 'Austin', false),
('James', 'Taylor', 'james.t@yahoo.co.uk', 'h4sh47', '+447800120047', 'img47.jpg', 'Male', '1998-06-30', 'Manchester', false),
('Linda', 'Anderson', 'linda.anderson@gmail.com', 'h4sh48', '+16045550048', 'img48.jpg', 'Female', '1975-01-10', 'Vancouver', false),
('Robert', 'Thomas', 'rob.thomas@gmail.com', 'h4sh49', '+12125550049', 'img49.jpg', 'Male', '1980-08-22', 'New York', false),
('Elizabeth', 'Jackson', 'liz.jackson@outlook.com', 'h4sh50', '+33612340050', 'img50.jpg', 'Female', '1991-12-05', 'Paris', false),
('William', 'White', 'will.white@gmail.com', 'h4sh51', '+491701230051', 'img51.jpg', 'Male', '1987-05-19', 'Berlin', false),
('Jennifer', 'Harris', 'jen.harris@yahoo.com', 'h4sh52', '+13055550052', 'img52.jpg', 'Female', '1993-10-02', 'Miami', false),
('Charles', 'Martin', 'charles.m@gmail.com', 'h4sh53', '+12065550053', 'img53.jpg', 'Male', '1965-03-15', 'Seattle', false),
('Susan', 'Thompson', 'susan.t@aol.com', 'h4sh54', '+14045550054', 'img54.jpg', 'Female', '1970-07-08', 'Atlanta', false),
('Joseph', 'Garcia', 'joe.garcia@gmail.com', 'h4sh55', '+34600120055', 'img55.jpg', 'Male', '1996-02-25', 'Madrid', false),
('Margaret', 'Martinez', 'maggie.m@yahoo.com', 'h4sh56', '+17135550056', 'img56.jpg', 'Female', '1989-11-12', 'Houston', false),
('Thomas', 'Robinson', 'tom.rob@gmail.com', 'h4sh57', '+16175550057', 'img57.jpg', 'Male', '1994-09-01', 'Boston', false),
('Patricia', 'Clark', 'pat.clark@outlook.com', 'h4sh58', '+12155550058', 'img58.jpg', 'Female', '1983-06-18', 'Philadelphia', false),
('Christopher', 'Rodriguez', 'chris.rod@gmail.com', 'h4sh59', '+52551230059', 'img59.jpg', 'Male', '1990-04-20', 'Mexico City', false),
('Barbara', 'Lewis', 'barb.lewis@gmail.com', 'h4sh60', '+13125550060', 'img60.jpg', 'Female', '1978-08-30', 'Chicago', false),

-- Группа 4: Знаменитости и смешанные имена
('Elon', 'Musk', 'elon.musk.real@tesla.com', 'h4sh61', '+16505550061', 'img61.jpg', 'Male', '1971-06-28', 'Austin', false),
('Rihanna', 'Fenty', 'riri.official@music.com', 'h4sh62', '+12465550062', 'img62.jpg', 'Female', '1988-02-20', 'Barbados', false),
('Cristiano', 'Ronaldo', 'cr7.siuu@juve.com', 'h4sh63', '+35191230063', 'img63.jpg', 'Male', '1985-02-05', 'Lisbon', false),
('Beyonce', 'Knowles', 'queen.b@music.com', 'h4sh64', '+12125550064', 'img64.jpg', 'Female', '1981-09-04', 'Houston', false),
('Lionel', 'Messi', 'leo.messi10@barca.com', 'h4sh65', '+34600120065', 'img65.jpg', 'Male', '1987-06-24', 'Barcelona', false),
('Shakira', 'Mebarak', 'shakira@colombia.com', 'h4sh66', '+57300120066', 'img66.jpg', 'Female', '1977-02-02', 'Barranquilla', false),
('Kanye', 'West', 'ye.west@yeezy.com', 'h4sh67', '+13235550067', 'img67.jpg', 'Male', '1977-06-08', 'Los Angeles', false),
('Kim', 'Kardashian', 'kim.k@skims.com', 'h4sh68', '+18185550068', 'img68.jpg', 'Female', '1980-10-21', 'Calabasas', false),
('Dwayne', 'Johnson', 'therock.real@wwe.com', 'h4sh69', '+13055550069', 'img69.jpg', 'Male', '1972-05-02', 'Miami', false),
('Taylor', 'Swift', 'taylor.s13@music.com', 'h4sh70', '+16155550070', 'img70.jpg', 'Female', '1989-12-13', 'Nashville', false),
('Justin', 'Bieber', 'jb.baby@canada.com', 'h4sh71', '+14165550071', 'img71.jpg', 'Male', '1994-03-01', 'Toronto', false),
('Selena', 'Gomez', 'selena.g@disney.com', 'h4sh72', '+12135550072', 'img72.jpg', 'Female', '1992-07-22', 'Texas', false),
('Will', 'Smith', 'fresh.prince.real@philly.com', 'h4sh73', '+12155550073', 'img73.jpg', 'Male', '1968-09-25', 'Philadelphia', false),
('Angelina', 'Jolie', 'angie.jolie@un.org', 'h4sh74', '+12025550074', 'img74.jpg', 'Female', '1975-06-04', 'New York', false),
('Brad', 'Pitt', 'brad.pitt.official@gmail.com', 'h4sh75', '+13105550075', 'img75.jpg', 'Male', '1963-12-18', 'Los Angeles', false),
('Scarlett', 'Johansson', 'black.widow.real@marvel.com', 'h4sh76', '+12125550076', 'img76.jpg', 'Female', '1984-11-22', 'New York', false),
('Tom', 'Cruise', 'tom.cruise.topgun@movie.com', 'h4sh77', '+13235550077', 'img77.jpg', 'Male', '1962-07-03', 'Los Angeles', false),
('Adele', 'Adkins', 'adele.hello@music.com', 'h4sh78', '+447800120078', 'img78.jpg', 'Female', '1988-05-05', 'London', false),
('Ed', 'Sheeran', 'ed.sheeran@ginger.com', 'h4sh79', '+447900650079', 'img79.jpg', 'Male', '1991-02-17', 'Suffolk', false),
('Billie', 'Eilish', 'billie.e@badguy.com', 'h4sh80', '+13235550080', 'img80.jpg', 'Female', '2001-12-18', 'Los Angeles', false),
('Drake', 'Graham', 'drake.champagne@ovo.com', 'h4sh81', '+14165550081', 'img81.jpg', 'Male', '1986-10-24', 'Toronto', false),
('Ariana', 'Grande', 'ari.grande@positions.com', 'h4sh82', '+15615550082', 'img82.jpg', 'Female', '1993-06-26', 'Florida', false),
('Eminem', 'Mathers', 'slim.shady.real@detroit.com', 'h4sh83', '+13135550083', 'img83.jpg', 'Male', '1972-10-17', 'Detroit', false),
('Miley', 'Cyrus', 'miley.c@wreckingball.com', 'h4sh84', '+16155550084', 'img84.jpg', 'Female', '1992-11-23', 'Nashville', false),
('Bruno', 'Mars', 'bruno.mars@silk.com', 'h4sh85', '+18085550085', 'img85.jpg', 'Male', '1985-10-08', 'Honolulu', false),
('Katy', 'Perry', 'katy.perry@firework.com', 'h4sh86', '+18055550086', 'img86.jpg', 'Female', '1984-10-25', 'Santa Barbara', false),
('Jay', 'Z', 'jay.z@roc.com', 'h4sh87', '+12125550087', 'img87.jpg', 'Male', '1969-12-04', 'New York', false),
('Lady', 'Gaga', 'lady.gaga@chromatica.com', 'h4sh88', '+12125550088', 'img88.jpg', 'Female', '1986-03-28', 'New York', false),
('The', 'Weeknd', 'weeknd.abel@xo.com', 'h4sh89', '+14165550089', 'img89.jpg', 'Male', '1990-02-16', 'Toronto', false),
('Dua', 'Lipa', 'dua.lipa@levitating.com', 'h4sh90', '+447555010090', 'img90.jpg', 'Female', '1995-08-22', 'London', false),
('Harry', 'Styles', 'harry.styles@watermelon.com', 'h4sh91', '+447444010091', 'img91.jpg', 'Male', '1994-02-01', 'Redditch', false),
('Zendaya', 'Coleman', 'zen.daya@euphoria.com', 'h4sh92', '+15105550092', 'img92.jpg', 'Female', '1996-09-01', 'Oakland', false),
('Tom', 'Holland', 'tom.holland@spidey.com', 'h4sh93', '+447333010093', 'img93.jpg', 'Male', '1996-06-01', 'London', false),
('Gal', 'Gadot', 'gal.gadot@wonder.com', 'h4sh94', '+972501230094', 'img94.jpg', 'Female', '1985-04-30', 'Tel Aviv', false),
('Chris', 'Hemsworth', 'chris.h@thor.com', 'h4sh95', '+61400120095', 'img95.jpg', 'Male', '1983-08-11', 'Melbourne', false),
('Margot', 'Robbie', 'margot.r@barbie.com', 'h4sh96', '+61400120096', 'img96.jpg', 'Female', '1990-07-02', 'Dalby', false),
('Ryan', 'Reynolds', 'ryan.r@deadpool.com', 'h4sh97', '+16045550097', 'img97.jpg', 'Male', '1976-10-23', 'Vancouver', false),
('Blake', 'Lively', 'blake.l@gossip.com', 'h4sh98', '+13105550098', 'img98.jpg', 'Female', '1987-08-25', 'Los Angeles', false),
('Keanu', 'Reeves', 'keanu.r@matrix.com', 'h4sh99', '+13235550099', 'img99.jpg', 'Male', '1964-09-02', 'Beirut', false),
('Sandra', 'Bullock', 'sandra.b@gravity.com', 'h4sh100', '+17035550100', 'img100.jpg', 'Female', '1964-07-26', 'Arlington', false);

INSERT INTO PaymentCards (user_ID, providerToken, last_4_digits, card_brand, is_default) VALUES
(1, 'tok_visa_user1_x8d7', '4242', 'Visa', true),
(2, 'tok_mc_user2_b2k1', '5599', 'Mastercard', true),
(3, 'tok_visa_user3_m912', '1234', 'Visa', true),
(4, 'tok_mc_user4_p002', '8841', 'Mastercard', true),
(5, 'tok_visa_user5_q331', '9012', 'Visa', true),
(6, 'tok_visa_user6_w112', '3456', 'Visa', true),
(7, 'tok_mc_user7_x991', '7812', 'Mastercard', true),
(8, 'tok_visa_user8_h221', '1111', 'Visa', true),
(9, 'tok_amex_user9_u881', '3005', 'American Express', true),
(10, 'tok_visa_user10_j112', '4000', 'Visa', true),
(11, 'tok_visa_user11_k223', '9988', 'Visa', true),
(12, 'tok_mc_user12_l334', '2233', 'Mastercard', true),
(13, 'tok_visa_user13_m445', '7766', 'Visa', true),
(14, 'tok_visa_user14_n556', '5544', 'Visa', true),
(15, 'tok_visa_user15_o667', '4488', 'Visa', true),
(16, 'tok_mc_user16_p778', '9009', 'Mastercard', true),
(17, 'tok_visa_user17_q889', '1212', 'Visa', true),
(18, 'tok_visa_user18_r990', '3434', 'Visa', true),
(19, 'tok_union_user19_s001', '6211', 'UnionPay', true),
(20, 'tok_visa_user20_t112', '9876', 'Visa', true),
(21, 'tok_visa_user21_u223', '4321', 'Visa', true),
(22, 'tok_mc_user22_v334', '5678', 'Mastercard', true),
(23, 'tok_visa_user23_w445', '8765', 'Visa', true),
(24, 'tok_visa_user24_x556', '1357', 'Visa', true),
(25, 'tok_mc_user25_y667', '2468', 'Mastercard', true),
(26, 'tok_visa_user26_z778', '1010', 'Visa', true),
(27, 'tok_visa_user27_a889', '2020', 'Visa', true),
(28, 'tok_mc_user28_b990', '3030', 'Mastercard', true),
(29, 'tok_visa_user29_c001', '4040', 'Visa', true),
(30, 'tok_visa_user30_d112', '5050', 'Visa', true),
(31, 'tok_visa_user31_e223', '6060', 'Visa', true),
(32, 'tok_mc_user32_f334', '7070', 'Mastercard', true),
(33, 'tok_visa_user33_g445', '8080', 'Visa', true),
(34, 'tok_amex_user34_h556', '1001', 'American Express', true),
(35, 'tok_visa_user35_i667', '9999', 'Visa', true),
(36, 'tok_visa_user36_j778', '1122', 'Visa', true),
(37, 'tok_mc_user37_k889', '3344', 'Mastercard', true),
(38, 'tok_visa_user38_l990', '5566', 'Visa', true),
(39, 'tok_visa_user39_m001', '7788', 'Visa', true),
(40, 'tok_mc_user40_n112', '9900', 'Mastercard', true),
(41, 'tok_visa_user41_o223', '0011', 'Visa', true),
(42, 'tok_visa_user42_p334', '2244', 'Visa', true),
(43, 'tok_mc_user43_q445', '4466', 'Mastercard', true),
(44, 'tok_visa_user44_r556', '6688', 'Visa', true),
(45, 'tok_visa_user45_s667', '8800', 'Visa', true),
(46, 'tok_visa_user46_t778', '1230', 'Visa', true),
(47, 'tok_mc_user47_u889', '0321', 'Mastercard', true),
(48, 'tok_visa_user48_v990', '4560', 'Visa', true),
(49, 'tok_visa_user49_w001', '7890', 'Visa', true),
(50, 'tok_mc_user50_x112', '0123', 'Mastercard', true),
(51, 'tok_visa_user51_y223', '5670', 'Visa', true),
(52, 'tok_visa_user52_z334', '8901', 'Visa', true),
(53, 'tok_mc_user53_a445', '2345', 'Mastercard', true),
(54, 'tok_visa_user54_b556', '6789', 'Visa', true),
(55, 'tok_visa_user55_c667', '1112', 'Visa', true),
(56, 'tok_mc_user56_d778', '1314', 'Mastercard', true),
(57, 'tok_visa_user57_e889', '1516', 'Visa', true),
(58, 'tok_visa_user58_f990', '1718', 'Visa', true),
(59, 'tok_union_user59_g001', '6200', 'UnionPay', true),
(60, 'tok_visa_user60_h112', '1920', 'Visa', true),
(61, 'tok_visa_user61_i223', '2122', 'Visa', true),
(62, 'tok_mc_user62_j334', '2324', 'Mastercard', true),
(63, 'tok_visa_user63_k445', '2526', 'Visa', true),
(64, 'tok_visa_user64_l556', '2728', 'Visa', true),
(65, 'tok_mc_user65_m667', '2930', 'Mastercard', true),
(66, 'tok_visa_user66_n778', '3132', 'Visa', true),
(67, 'tok_visa_user67_o889', '3334', 'Visa', true),
(68, 'tok_mc_user68_p990', '3536', 'Mastercard', true),
(69, 'tok_visa_user69_q001', '3738', 'Visa', true),
(70, 'tok_visa_user70_r112', '3940', 'Visa', true),
(71, 'tok_visa_user71_s223', '4142', 'Visa', true),
(72, 'tok_mc_user72_t334', '4344', 'Mastercard', true),
(73, 'tok_visa_user73_u445', '4546', 'Visa', true),
(74, 'tok_amex_user74_v556', '4748', 'American Express', true),
(75, 'tok_visa_user75_w667', '4950', 'Visa', true),
(76, 'tok_visa_user76_x778', '5152', 'Visa', true),
(77, 'tok_mc_user77_y889', '5354', 'Mastercard', true),
(78, 'tok_visa_user78_z990', '5556', 'Visa', true),
(79, 'tok_visa_user79_a001', '5758', 'Visa', true),
(80, 'tok_mc_user80_b112', '5960', 'Mastercard', true),
(81, 'tok_visa_user81_c223', '6162', 'Visa', true),
(82, 'tok_visa_user82_d334', '6364', 'Visa', true),
(83, 'tok_mc_user83_e445', '6566', 'Mastercard', true),
(84, 'tok_visa_user84_f556', '6768', 'Visa', true),
(85, 'tok_visa_user85_g667', '6970', 'Visa', true),
(86, 'tok_visa_user86_h778', '7172', 'Visa', true),
(87, 'tok_mc_user87_i889', '7374', 'Mastercard', true),
(88, 'tok_visa_user88_j990', '7576', 'Visa', true),
(89, 'tok_visa_user89_k001', '7778', 'Visa', true),
(90, 'tok_union_user90_l112', '7980', 'UnionPay', true),
(91, 'tok_visa_user91_m223', '8182', 'Visa', true),
(92, 'tok_visa_user92_n334', '8384', 'Visa', true),
(93, 'tok_mc_user93_o445', '8586', 'Mastercard', true),
(94, 'tok_visa_user94_p556', '8788', 'Visa', true),
(95, 'tok_visa_user95_q667', '8990', 'Visa', true),
(96, 'tok_mc_user96_r778', '9192', 'Mastercard', true),
(97, 'tok_visa_user97_s889', '9394', 'Visa', true),
(98, 'tok_visa_user98_t990', '9596', 'Visa', true),
(99, 'tok_visa_user99_u001', '9798', 'Visa', true),
(100, 'tok_visa_user100_v112', '9900', 'Visa', true);

insert into SubscriptionPlans (subscription_name, subscription_price, subscription_duration_days) values
('Student', 590.00, 30),            -- ID 1
('Premium Individual', 1690.00, 30), -- ID 2
('Premium Family', 2690.00, 30);     -- ID 3

INSERT INTO Subscriptions (status, start_date, end_date, auto_renew, subscription_plan_ID, user_ID) VALUES
-- Студенческие подписки (ID плана: 1)
('Active', '2025-12-01', '2025-12-31', true, 1, 1),
('Active', '2025-12-02', '2026-01-01', true, 1, 2),
('Active', '2025-12-03', '2026-01-02', true, 1, 3),
('Active', '2025-12-04', '2026-01-03', true, 1, 4),
('Active', '2025-12-05', '2026-01-04', true, 1, 5),
('Active', '2025-12-06', '2026-01-05', true, 1, 6),
('Active', '2025-12-07', '2026-01-06', true, 1, 7),
('Active', '2025-12-08', '2026-01-07', true, 1, 8),
('Active', '2025-12-09', '2026-01-08', true, 1, 9),
('Active', '2025-12-10', '2026-01-09', true, 1, 10),
('Active', '2025-12-11', '2026-01-10', true, 1, 11),
('Active', '2025-12-12', '2026-01-11', true, 1, 12),
('Active', '2025-12-13', '2026-01-12', true, 1, 13),
('Active', '2025-12-14', '2026-01-13', true, 1, 14),
('Active', '2025-12-15', '2026-01-14', true, 1, 15),
('Active', '2025-12-16', '2026-01-15', true, 1, 16),
('Active', '2025-12-17', '2026-01-16', true, 1, 17),
('Active', '2025-12-18', '2026-01-17', true, 1, 18),
('Active', '2025-12-19', '2026-01-18', true, 1, 19),
('Active', '2025-12-20', '2026-01-19', true, 1, 20),

-- Индивидуальные подписки (ID плана: 2) - Основная масса
('Active', '2025-11-25', '2025-12-25', true, 2, 21),
('Active', '2025-11-26', '2025-12-26', true, 2, 22),
('Active', '2025-11-27', '2025-12-27', true, 2, 23),
('Active', '2025-11-28', '2025-12-28', true, 2, 24),
('Active', '2025-11-29', '2025-12-29', true, 2, 25),
('Active', '2025-11-30', '2025-12-30', true, 2, 26),
('Active', '2025-12-01', '2025-12-31', true, 2, 27),
('Active', '2025-12-01', '2025-12-31', true, 2, 28),
('Active', '2025-12-02', '2026-01-01', true, 2, 29),
('Active', '2025-12-02', '2026-01-01', true, 2, 30),
('Active', '2025-12-03', '2026-01-02', true, 2, 31),
('Active', '2025-12-03', '2026-01-02', true, 2, 32),
('Active', '2025-12-04', '2026-01-03', true, 2, 33),
('Active', '2025-12-04', '2026-01-03', true, 2, 34),
('Active', '2025-12-05', '2026-01-04', true, 2, 35),
('Active', '2025-12-05', '2026-01-04', true, 2, 36),
('Active', '2025-12-06', '2026-01-05', true, 2, 37),
('Active', '2025-12-06', '2026-01-05', true, 2, 38),
('Active', '2025-12-07', '2026-01-06', true, 2, 39),
('Active', '2025-12-07', '2026-01-06', true, 2, 40),
('Active', '2025-12-08', '2026-01-07', true, 2, 41),
('Active', '2025-12-08', '2026-01-07', true, 2, 42),
('Active', '2025-12-09', '2026-01-08', true, 2, 43),
('Active', '2025-12-09', '2026-01-08', true, 2, 44),
('Active', '2025-12-10', '2026-01-09', true, 2, 45),
('Active', '2025-12-10', '2026-01-09', true, 2, 46),
('Active', '2025-12-11', '2026-01-10', true, 2, 47),
('Active', '2025-12-11', '2026-01-10', true, 2, 48),
('Active', '2025-12-12', '2026-01-11', true, 2, 49),
('Active', '2025-12-12', '2026-01-11', true, 2, 50),
('Active', '2025-12-13', '2026-01-12', true, 2, 51),
('Active', '2025-12-13', '2026-01-12', true, 2, 52),
('Active', '2025-12-14', '2026-01-13', true, 2, 53),
('Active', '2025-12-14', '2026-01-13', true, 2, 54),
('Active', '2025-12-15', '2026-01-14', true, 2, 55),
('Active', '2025-12-15', '2026-01-14', true, 2, 56),
('Active', '2025-12-16', '2026-01-15', true, 2, 57),
('Active', '2025-12-16', '2026-01-15', true, 2, 58),
('Active', '2025-12-17', '2026-01-16', true, 2, 59),
('Active', '2025-12-17', '2026-01-16', true, 2, 60),
('Active', '2025-12-18', '2026-01-17', true, 2, 61),
('Active', '2025-12-18', '2026-01-17', true, 2, 62),
('Active', '2025-12-19', '2026-01-18', true, 2, 63),
('Active', '2025-12-19', '2026-01-18', true, 2, 64),
('Active', '2025-12-20', '2026-01-19', true, 2, 65),
('Active', '2025-12-20', '2026-01-19', true, 2, 66),
('Active', '2025-12-21', '2026-01-20', true, 2, 67),
('Active', '2025-12-21', '2026-01-20', true, 2, 68),
('Active', '2025-12-22', '2026-01-21', true, 2, 69),
('Active', '2025-12-22', '2026-01-21', true, 2, 70),
('Active', '2025-12-23', '2026-01-22', true, 2, 71),
('Active', '2025-12-23', '2026-01-22', true, 2, 72),
('Active', '2025-12-24', '2026-01-23', true, 2, 73),
('Active', '2025-12-24', '2026-01-23', true, 2, 74),
('Active', '2025-12-25', '2026-01-24', true, 2, 75),
('Active', '2025-12-25', '2026-01-24', true, 2, 76),
('Active', '2025-12-25', '2026-01-24', true, 2, 77),
('Active', '2025-12-25', '2026-01-24', true, 2, 78),
('Active', '2025-12-25', '2026-01-24', true, 2, 79),
('Active', '2025-12-25', '2026-01-24', true, 2, 80),

-- Семейные подписки (ID плана: 3)
('Active', '2025-12-05', '2026-01-04', true, 3, 81),
('Active', '2025-12-06', '2026-01-05', true, 3, 82),
('Active', '2025-12-07', '2026-01-06', true, 3, 83),
('Active', '2025-12-08', '2026-01-07', true, 3, 84),
('Active', '2025-12-09', '2026-01-08', true, 3, 85),
('Active', '2025-12-10', '2026-01-09', true, 3, 86),
('Active', '2025-12-11', '2026-01-10', true, 3, 87),
('Active', '2025-12-12', '2026-01-11', true, 3, 88),
('Active', '2025-12-13', '2026-01-12', true, 3, 89),
('Active', '2025-12-14', '2026-01-13', true, 3, 90),
('Active', '2025-12-15', '2026-01-14', true, 3, 91),
('Active', '2025-12-16', '2026-01-15', true, 3, 92),
('Active', '2025-12-17', '2026-01-16', true, 3, 93),
('Active', '2025-12-18', '2026-01-17', true, 3, 94),
('Active', '2025-12-19', '2026-01-18', true, 3, 95),
('Active', '2025-12-20', '2026-01-19', true, 3, 96),
('Active', '2025-12-21', '2026-01-20', true, 3, 97),
('Active', '2025-12-22', '2026-01-21', true, 3, 98),
('Active', '2025-12-23', '2026-01-22', true, 3, 99),
('Active', '2025-12-24', '2026-01-23', true, 3, 100);

INSERT INTO Authors (author_name, author_surname, count_of_auditions, author_is_deleted) VALUES
-- Мировые поп-звезды
('The', 'Weeknd', 150000000, false),
('Taylor', 'Swift', 200000000, false),
('Ariana', 'Grande', 120000000, false),
('Justin', 'Bieber', 115000000, false),
('Ed', 'Sheeran', 130000000, false),
('Dua', 'Lipa', 95000000, false),
('Bruno', 'Mars', 88000000, false),
('Billie', 'Eilish', 105000000, false),
('Lady', 'Gaga', 90000000, false),
('Adele', 'Adkins', 98000000, false),
('Harry', 'Styles', 85000000, false),
('Miley', 'Cyrus', 75000000, false),
('Rihanna', 'Fenty', 140000000, false),
('Beyonce', 'Knowles', 145000000, false),
('Shawn', 'Mendes', 60000000, false),
('Sam', 'Smith', 65000000, false),
('Katy', 'Perry', 80000000, false),
('Lana', 'Del Rey', 70000000, false),
('Post', 'Malone', 92000000, false),
('Sia', 'Furler', 55000000, false),

-- Хип-хоп и Рэп (Запад)
('Marshall', 'Mathers', 180000000, false), -- Eminem
('Kanye', 'West', 160000000, false),
('Drake', 'Graham', 190000000, false),
('Travis', 'Scott', 110000000, false),
('Kendrick', 'Lamar', 95000000, false),
('Jay', 'Z', 80000000, false),
('50', 'Cent', 70000000, false),
('Snoop', 'Dogg', 85000000, false),
('Cardi', 'B', 65000000, false),
('Nicki', 'Minaj', 75000000, false),

-- Рок и Группы (Разбиты на Имя/Фамилия для схемы)
('Imagine', 'Dragons', 135000000, false),
('Linkin', 'Park', 155000000, false),
('Cold', 'Play', 125000000, false),
('Arctic', 'Monkeys', 60000000, false),
('Queen', 'Band', 195000000, false),
('Twenty One', 'Pilots', 55000000, false),
('Red Hot', 'Chili Peppers', 70000000, false),
('Nirvana', 'Band', 90000000, false),
('Metallica', 'Band', 95000000, false),
('AC', 'DC', 100000000, false),

-- Казахстан и СНГ (Локальный топ)
('Dimash', 'Kudaibergen', 50000000, false),
('Adil', 'Zhalelov', 70000000, false), -- Scriptonite
('Kairat', 'Nurtas', 40000000, false),
('Jah', 'Khalib', 45000000, false),
('Ninety', 'One', 30000000, false),
('Batyrkhan', 'Shukenov', 35000000, false),
('Nazima', 'Janibekova', 15000000, false),
('Aikyn', 'Tolepbergen', 12000000, false),
('Motta', 'BlackStar', 25000000, false),
('Egor', 'Creed', 30000000, false);

INSERT INTO Albums (album_name, album_poster, album_release_date, author_ID) VALUES
-- 1. The Weeknd
('After Hours', 'https://music.cover/after_hours.jpg', '2020-03-20', 1),
('Starboy', 'https://music.cover/starboy.jpg', '2016-11-25', 1),

-- 2. Taylor Swift
('1989', 'https://music.cover/1989.jpg', '2014-10-27', 2),
('Midnights', 'https://music.cover/midnights.jpg', '2022-10-21', 2),

-- 3. Ariana Grande
('Thank U, Next', 'https://music.cover/thank_u_next.jpg', '2019-02-08', 3),

-- 4. Justin Bieber
('Justice', 'https://music.cover/justice.jpg', '2021-03-19', 4),

-- 5. Ed Sheeran
('Divide', 'https://music.cover/divide.jpg', '2017-03-03', 5),

-- 6. Dua Lipa
('Future Nostalgia', 'https://music.cover/future_nostalgia.jpg', '2020-03-27', 6),

-- 7. Bruno Mars
('24K Magic', 'https://music.cover/24k_magic.jpg', '2016-11-18', 7),

-- 8. Billie Eilish
('Happier Than Ever', 'https://music.cover/happier.jpg', '2021-07-30', 8),

-- 9. Lady Gaga
('Chromatica', 'https://music.cover/chromatica.jpg', '2020-05-29', 9),

-- 10. Adele
('25', 'https://music.cover/adele25.jpg', '2015-11-20', 10),

-- 11. Harry Styles
('Harrys House', 'https://music.cover/harrys_house.jpg', '2022-05-20', 11),

-- 12. Miley Cyrus
('Plastic Hearts', 'https://music.cover/plastic_hearts.jpg', '2020-11-27', 12),

-- 13. Rihanna
('Anti', 'https://music.cover/anti.jpg', '2016-01-28', 13),

-- 14. Beyonce
('Lemonade', 'https://music.cover/lemonade.jpg', '2016-04-23', 14),

-- 15. Shawn Mendes
('Wonder', 'https://music.cover/wonder.jpg', '2020-12-04', 15),

-- 16. Sam Smith
('In the Lonely Hour', 'https://music.cover/lonely_hour.jpg', '2014-05-26', 16),

-- 17. Katy Perry
('Teenage Dream', 'https://music.cover/teenage_dream.jpg', '2010-08-24', 17),

-- 18. Lana Del Rey
('Born to Die', 'https://music.cover/born_to_die.jpg', '2012-01-27', 18),

-- 19. Post Malone
('Hollywoods Bleeding', 'https://music.cover/hollywood.jpg', '2019-09-06', 19),

-- 20. Sia
('This Is Acting', 'https://music.cover/sia_acting.jpg', '2016-01-29', 20),

-- 21. Eminem
('The Eminem Show', 'https://music.cover/eminem_show.jpg', '2002-05-26', 21),
('Recovery', 'https://music.cover/recovery.jpg', '2010-06-18', 21),

-- 22. Kanye West
('My Beautiful Dark Twisted Fantasy', 'https://music.cover/mbdtf.jpg', '2010-11-22', 22),

-- 23. Drake
('Scorpion', 'https://music.cover/scorpion.jpg', '2018-06-29', 23),

-- 24. Travis Scott
('Astroworld', 'https://music.cover/astroworld.jpg', '2018-08-03', 24),

-- 25. Kendrick Lamar
('DAMN.', 'https://music.cover/damn.jpg', '2017-04-14', 25),

-- 26. Jay Z
('The Blueprint', 'https://music.cover/blueprint.jpg', '2001-09-11', 26),

-- 27. 50 Cent
('Get Rich or Die Tryin', 'https://music.cover/grodt.jpg', '2003-02-06', 27),

-- 28. Snoop Dogg
('Doggystyle', 'https://music.cover/doggystyle.jpg', '1993-11-23', 28),

-- 29. Cardi B
('Invasion of Privacy', 'https://music.cover/invasion.jpg', '2018-04-06', 29),

-- 30. Nicki Minaj
('Pink Friday', 'https://music.cover/pink_friday.jpg', '2010-11-22', 30),

-- 31. Imagine Dragons
('Night Visions', 'https://music.cover/night_visions.jpg', '2012-09-04', 31),
('Evolve', 'https://music.cover/evolve.jpg', '2017-06-23', 31),

-- 32. Linkin Park
('Hybrid Theory', 'https://music.cover/hybrid_theory.jpg', '2000-10-24', 32),
('Meteora', 'https://music.cover/meteora.jpg', '2003-03-25', 32),

-- 33. Coldplay
('A Head Full of Dreams', 'https://music.cover/coldplay_head.jpg', '2015-12-04', 33),

-- 34. Arctic Monkeys
('AM', 'https://music.cover/am_arctic.jpg', '2013-09-09', 34),

-- 35. Queen
('A Night at the Opera', 'https://music.cover/queen_opera.jpg', '1975-11-21', 35),

-- 36. Twenty One Pilots
('Blurryface', 'https://music.cover/blurryface.jpg', '2015-05-17', 36),

-- 37. Red Hot Chili Peppers
('Californication', 'https://music.cover/rhcp_cali.jpg', '1999-06-08', 37),

-- 38. Nirvana
('Nevermind', 'https://music.cover/nevermind.jpg', '1991-09-24', 38),

-- 39. Metallica
('Master of Puppets', 'https://music.cover/metallica_master.jpg', '1986-03-03', 39),

-- 40. AC/DC
('Back in Black', 'https://music.cover/acdc_back.jpg', '1980-07-25', 40),

-- 41. Dimash Kudaibergen
('ID', 'https://music.cover/dimash_id.jpg', '2019-06-14', 41),

-- 42. Scriptonite (Скриптонит)
('House with Normal Activity', 'https://music.cover/dom_s_normalnymi.jpg', '2015-11-24', 42), -- Дом с нормальными явлениями
('Uroboros: Street 36', 'https://music.cover/uroboros.jpg', '2017-12-16', 42),

-- 43. Kairat Nurtas
('Men Gashykpyn', 'https://music.cover/kairat_men.jpg', '2018-05-20', 43),

-- 44. Jah Khalib
('E.G.O.', 'https://music.cover/jah_ego.jpg', '2018-03-29', 44),

-- 45. Ninety One
('Qarangy Zharyq', 'https://music.cover/91_qarangy.jpg', '2017-06-02', 45),

-- 46. Batyrkhan Shukenov
('Otan Ana', 'https://music.cover/batyr_otan.jpg', '2002-10-10', 46),

-- 47. Nazima
('Secrets', 'https://music.cover/nazima_secrets.jpg', '2019-10-15', 47),

-- 48. Aikyn Tolepbergen
('Aikyn', 'https://music.cover/aikyn_album.jpg', '2015-09-01', 48),

-- 49. Mot
('Dobraia Muzyka', 'https://music.cover/mot_music.jpg', '2017-11-15', 49),

-- 50. Egor Creed
('Bachelor', 'https://music.cover/creed_holostyak.jpg', '2015-04-02', 50);

INSERT INTO Musics (music_name, music_poster, music_file, author_ID, album_ID, count_of_auditions, music_duration, release_date, lyrics) VALUES

-- 1. THE WEEKND (Album 1: After Hours, Album 2: Starboy)
('Blinding Lights', 'cover_bl.jpg', 'blinding_lights.mp3', 1, 1, 350000000, 200, '2019-11-29', '{"text": "I said, ooh, Im blinded by the lights..."}'),
('Save Your Tears', 'cover_syt.jpg', 'save_your_tears.mp3', 1, 1, 280000000, 215, '2020-03-20', '{"text": "I saw you dancing in a crowded room..."}'),
('In Your Eyes', 'cover_iye.jpg', 'in_your_eyes.mp3', 1, 1, 150000000, 237, '2020-03-20', '{"text": "I just pretend that Im in the dark..."}'),
('Heartless', 'cover_hrt.jpg', 'heartless.mp3', 1, 1, 120000000, 198, '2019-11-27', '{"text": "Never need a bitch, Im what a bitch need..."}'),
('Starboy', 'cover_sb.jpg', 'starboy.mp3', 1, 2, 400000000, 230, '2016-09-21', '{"text": "Im a-a-a starboy..."}'),
('I Feel It Coming', 'cover_ific.jpg', 'i_feel_it_coming.mp3', 1, 2, 290000000, 269, '2016-11-17', '{"text": "Tell me what you really like..."}'),
('Die For You', 'cover_dfy.jpg', 'die_for_you.mp3', 1, 2, 310000000, 260, '2016-11-25', '{"text": "Im findin ways to articulate..."}'),
('Party Monster', 'cover_pm.jpg', 'party_monster.mp3', 1, 2, 90000000, 249, '2016-11-18', '{"text": "Im good, Im good, Im great..."}'),

-- 2. TAYLOR SWIFT (Album 3: 1989, Album 4: Midnights)
('Shake It Off', 'cover_sio.jpg', 'shake_it_off.mp3', 2, 3, 320000000, 219, '2014-08-18', '{"text": "I stay out too late..."}'),
('Blank Space', 'cover_bs.jpg', 'blank_space.mp3', 2, 3, 290000000, 231, '2014-11-10', '{"text": "Nice to meet you, where you been?..."}'),
('Style', 'cover_style.jpg', 'style.mp3', 2, 3, 180000000, 231, '2015-02-09', '{"text": "Midnight, you come and pick me up..."}'),
('Bad Blood', 'cover_bb.jpg', 'bad_blood.mp3', 2, 3, 210000000, 211, '2015-05-17', '{"text": "Cause baby, now we got bad blood..."}'),
('Anti-Hero', 'cover_ah.jpg', 'anti_hero.mp3', 2, 4, 250000000, 200, '2022-10-21', '{"text": "Its me, hi, Im the problem..."}'),
('Lavender Haze', 'cover_lh.jpg', 'lavender_haze.mp3', 2, 4, 190000000, 202, '2022-10-21', '{"text": "Meet me at midnight..."}'),
('Karma', 'cover_karma.jpg', 'karma.mp3', 2, 4, 170000000, 204, '2022-10-21', '{"text": "Karma is my boyfriend..."}'),
('Midnight Rain', 'cover_mr.jpg', 'midnight_rain.mp3', 2, 4, 160000000, 174, '2022-10-21', '{"text": "Rain, he wanted it comfortable..."}'),

-- 3. ARIANA GRANDE (Album 5: Thank U, Next)
('thank u, next', 'cover_tun.jpg', 'thank_u_next.mp3', 3, 5, 280000000, 207, '2018-11-03', '{"text": "Thought Id end up with Sean..."}'),
('7 rings', 'cover_7r.jpg', '7_rings.mp3', 3, 5, 300000000, 178, '2019-01-18', '{"text": "I see it, I like it, I want it..."}'),
('break up with your girlfriend', 'cover_bu.jpg', 'break_up.mp3', 3, 5, 220000000, 190, '2019-02-08', '{"text": "You got me some type of way..."}'),
('NASA', 'cover_nasa.jpg', 'nasa.mp3', 3, 5, 110000000, 182, '2019-02-08', '{"text": "Baby, you know time apart is beneficial..."}'),

-- 4. JUSTIN BIEBER (Album 6: Justice)
('Peaches', 'cover_peaches.jpg', 'peaches.mp3', 4, 6, 260000000, 198, '2021-03-19', '{"text": "I got my peaches out in Georgia..."}'),
('Ghost', 'cover_ghost.jpg', 'ghost.mp3', 4, 6, 210000000, 153, '2021-09-10', '{"text": "Youngblood thinks there is always tomorrow..."}'),
('Hold On', 'cover_holdon.jpg', 'hold_on.mp3', 4, 6, 140000000, 170, '2021-03-05', '{"text": "You need to take my hand..."}'),
('Holy', 'cover_holy.jpg', 'holy.mp3', 4, 6, 180000000, 212, '2020-09-18', '{"text": "I hear a lot about sinners..."}'),

-- 5. ED SHEERAN (Album 7: Divide)
('Shape of You', 'cover_soy.jpg', 'shape_of_you.mp3', 5, 7, 500000000, 233, '2017-01-06', '{"text": "The club isnt the best place to find a lover..."}'),
('Perfect', 'cover_perfect.jpg', 'perfect.mp3', 5, 7, 450000000, 263, '2017-09-26', '{"text": "I found a love for me..."}'),
('Castle on the Hill', 'cover_coth.jpg', 'castle.mp3', 5, 7, 300000000, 261, '2017-01-06', '{"text": "When I was six years old..."}'),
('Galway Girl', 'cover_gg.jpg', 'galway_girl.mp3', 5, 7, 250000000, 170, '2017-03-17', '{"text": "She played the fiddle in an Irish band..."}'),

-- 6. DUA LIPA (Album 8: Future Nostalgia)
('Don`t Start Now', 'cover_dsn.jpg', 'dont_start_now.mp3', 6, 8, 310000000, 183, '2019-11-01', '{"text": "If you dont wanna see me dancing..."}'),
('Levitating', 'cover_lev.jpg', 'levitating.mp3', 6, 8, 340000000, 203, '2020-10-01', '{"text": "If you wanna run away with me..."}'),
('Physical', 'cover_phy.jpg', 'physical.mp3', 6, 8, 200000000, 193, '2020-01-31', '{"text": "Common love isnt for us..."}'),
('Break My Heart', 'cover_bmh.jpg', 'break_my_heart.mp3', 6, 8, 220000000, 221, '2020-03-25', '{"text": "I should have stayed at home..."}'),

-- 7. BRUNO MARS (Album 9: 24K Magic)
('24K Magic', 'cover_24k.jpg', '24k_magic.mp3', 7, 9, 290000000, 226, '2016-10-07', '{"text": "Tonight, I just want to take you higher..."}'),
('That`s What I Like', 'cover_twil.jpg', 'thats_what_i_like.mp3', 7, 9, 310000000, 206, '2017-01-30', '{"text": "I got a condo in Manhattan..."}'),
('Versace on the Floor', 'cover_versace.jpg', 'versace.mp3', 7, 9, 180000000, 261, '2017-06-12', '{"text": "Lets take our time tonight, girl..."}'),
('Finesse', 'cover_finesse.jpg', 'finesse.mp3', 7, 9, 220000000, 190, '2018-01-04', '{"text": "Ooh, dont we look good together?..."}'),

-- 8. BILLIE EILISH (Album 10: Happier Than Ever)
('Happier Than Ever', 'cover_hte.jpg', 'happier_than_ever.mp3', 8, 10, 250000000, 298, '2021-07-30', '{"text": "When Im away from you..."}'),
('Therefore I Am', 'cover_tia.jpg', 'therefore_i_am.mp3', 8, 10, 190000000, 174, '2020-11-12', '{"text": "Im not your friend..."}'),
('Oxytocin', 'cover_oxy.jpg', 'oxytocin.mp3', 8, 10, 120000000, 210, '2021-07-30', '{"text": "Can not take it back once it has been set in motion..."}'),
('NDA', 'cover_nda.jpg', 'nda.mp3', 8, 10, 110000000, 195, '2021-07-09', '{"text": "Did you think Id show up in a limousine?..."}'),

-- 9. LADY GAGA (Album 11: Chromatica)
('Rain On Me', 'cover_rom.jpg', 'rain_on_me.mp3', 9, 11, 280000000, 182, '2020-05-22', '{"text": "Id rather be dry, but at least Im alive..."}'),
('Stupid Love', 'cover_sl.jpg', 'stupid_love.mp3', 9, 11, 150000000, 193, '2020-02-28', '{"text": "You are the one that I have been waiting for..."}'),
('911', 'cover_911.jpg', '911.mp3', 9, 11, 110000000, 172, '2020-09-18', '{"text": "Turnin up emotional faders..."}'),
('Sour Candy', 'cover_sc.jpg', 'sour_candy.mp3', 9, 11, 160000000, 157, '2020-05-28', '{"text": "Im sour candy, so sweet then I get a little angry..."}'),

-- 10. ADELE (Album 12: 25)
('Hello', 'cover_hello.jpg', 'hello.mp3', 10, 12, 480000000, 295, '2015-10-23', '{"text": "Hello, its me..."}'),
('Send My Love', 'cover_sml.jpg', 'send_my_love.mp3', 10, 12, 210000000, 223, '2016-05-16', '{"text": "This was all you, none of it me..."}'),
('When We Were Young', 'cover_wwwy.jpg', 'when_we_were_young.mp3', 10, 12, 230000000, 290, '2016-01-22', '{"text": "Everybody loves the things you do..."}'),
('Water Under the Bridge', 'cover_wutb.jpg', 'water_under.mp3', 10, 12, 180000000, 240, '2016-11-04', '{"text": "If you are not the one for me..."}'),

-- 11. HARRY STYLES (Album 13: Harry's House)
('As It Was', 'cover_aiw.jpg', 'as_it_was.mp3', 11, 13, 380000000, 167, '2022-04-01', '{"text": "Holdin me back, gravitys holdin me back..."}'),
('Late Night Talking', 'cover_lnt.jpg', 'late_night.mp3', 11, 13, 220000000, 177, '2022-06-21', '{"text": "Things havent been quite the same..."}'),
('Music for a Sushi Restaurant', 'cover_mfasr.jpg', 'sushi.mp3', 11, 13, 190000000, 193, '2022-10-03', '{"text": "Green eyes, fried rice..."}'),

-- 12. MILEY CYRUS (Album 14: Plastic Hearts)
('Midnight Sky', 'cover_ms.jpg', 'midnight_sky.mp3', 12, 14, 210000000, 223, '2020-08-14', '{"text": "It has been a long night..."}'),
('Prisoner', 'cover_prisoner.jpg', 'prisoner.mp3', 12, 14, 190000000, 169, '2020-11-19', '{"text": "Prisoner, prisoner, locked up..."}'),
('Angels Like You', 'cover_aly.jpg', 'angels.mp3', 12, 14, 150000000, 196, '2021-03-12', '{"text": "Flowers in hand, waiting for me..."}'),

-- 13. RIHANNA (Album 15: Anti)
('Work', 'cover_work.jpg', 'work.mp3', 13, 15, 360000000, 219, '2016-01-27', '{"text": "Work, work, work, work, work..."}'),
('Needed Me', 'cover_nm.jpg', 'needed_me.mp3', 13, 15, 240000000, 191, '2016-03-30', '{"text": "I was good on my own..."}'),
('Love on the Brain', 'cover_lotb.jpg', 'love_brain.mp3', 13, 15, 270000000, 224, '2016-09-27', '{"text": "And you got me like oh..."}'),

-- 14. BEYONCE (Album 16: Lemonade)
('Formation', 'cover_formation.jpg', 'formation.mp3', 14, 16, 210000000, 206, '2016-02-06', '{"text": "Okay, ladies, now lets get in formation..."}'),
('Sorry', 'cover_sorry.jpg', 'sorry.mp3', 14, 16, 180000000, 212, '2016-05-03', '{"text": "Sorry, I aint sorry..."}'),
('Hold Up', 'cover_holdup.jpg', 'hold_up.mp3', 14, 16, 160000000, 221, '2016-08-16', '{"text": "Hold up, they dont love you like I love you..."}'),

-- 15. SHAWN MENDES (Album 17: Wonder)
('Wonder', 'cover_wonder.jpg', 'wonder.mp3', 15, 17, 150000000, 172, '2020-10-02', '{"text": "I wonder if Im being real..."}'),
('Monster', 'cover_monster.jpg', 'monster.mp3', 15, 17, 140000000, 178, '2020-11-20', '{"text": "You put me on a pedestal..."}'),

-- 16. SAM SMITH (Album 18: In the Lonely Hour)
('Stay With Me', 'cover_swm.jpg', 'stay_with_me.mp3', 16, 18, 410000000, 172, '2014-04-14', '{"text": "Guess its true, Im not good at a one-night stand..."}'),
('Im Not the Only One', 'cover_intoo.jpg', 'only_one.mp3', 16, 18, 380000000, 239, '2014-08-31', '{"text": "You and me, we made a vow..."}'),

-- 17. KATY PERRY (Album 19: Teenage Dream)
('Firework', 'cover_firework.jpg', 'firework.mp3', 17, 19, 450000000, 227, '2010-10-26', '{"text": "Do you ever feel like a plastic bag..."}'),
('California Gurls', 'cover_cali.jpg', 'cali_gurls.mp3', 17, 19, 400000000, 236, '2010-05-07', '{"text": "I know a place where the grass is really greener..."}'),
('Teenage Dream', 'cover_td.jpg', 'teenage_dream.mp3', 17, 19, 390000000, 227, '2010-07-23', '{"text": "You think Im pretty without any makeup..."}'),

-- 18. LANA DEL REY (Album 20: Born to Die)
('Video Games', 'cover_vg.jpg', 'video_games.mp3', 18, 20, 280000000, 282, '2011-10-07', '{"text": "Swinging in the backyard..."}'),
('Born to Die', 'cover_btd.jpg', 'born_to_die.mp3', 18, 20, 310000000, 286, '2011-12-30', '{"text": "Feet dont fail me now..."}'),
('Summertime Sadness', 'cover_ss.jpg', 'summertime.mp3', 18, 20, 420000000, 265, '2012-06-22', '{"text": "Kiss me hard before you go..."}'),

-- 19. POST MALONE (Album 21: Hollywoods Bleeding)
('Circles', 'cover_circles.jpg', 'circles.mp3', 19, 21, 460000000, 215, '2019-08-30', '{"text": "We couldnt turn around..."}'),
('Sunflower', 'cover_sunflower.jpg', 'sunflower.mp3', 19, 21, 550000000, 158, '2018-10-19', '{"text": "Needless to say, I keep her in check..."}'),
('Goodbyes', 'cover_goodbyes.jpg', 'goodbyes.mp3', 19, 21, 230000000, 174, '2019-07-05', '{"text": "Me and Kurt feel the same..."}'),

-- 20. SIA (Album 22: This Is Acting)
('Cheap Thrills', 'cover_ct.jpg', 'cheap_thrills.mp3', 20, 22, 510000000, 211, '2016-02-11', '{"text": "Come on, come on, turn the radio on..."}'),
('The Greatest', 'cover_greatest.jpg', 'greatest.mp3', 20, 22, 300000000, 210, '2016-09-06', '{"text": "Uh-oh, running out of breath..."}'),

-- 21. EMINEM (Album 23: The Eminem Show, Album 24: Recovery)
('Without Me', 'cover_without.jpg', 'without_me.mp3', 21, 23, 480000000, 290, '2002-05-14', '{"text": "Two trailer park girls go round the outside..."}'),
('Sing for the Moment', 'cover_sftm.jpg', 'sing_moment.mp3', 21, 23, 200000000, 339, '2003-02-25', '{"text": "These ideas are nightmares..."}'),
('Till I Collapse', 'cover_tic.jpg', 'collapse.mp3', 21, 23, 350000000, 297, '2002-05-26', '{"text": "Cause sometimes you just feel tired..."}'),
('Love the Way You Lie', 'cover_ltwyl.jpg', 'love_way_lie.mp3', 21, 24, 520000000, 263, '2010-08-09', '{"text": "Just gonna stand there and watch me burn..."}'),
('Not Afraid', 'cover_na.jpg', 'not_afraid.mp3', 21, 24, 460000000, 248, '2010-04-29', '{"text": "Im not afraid to take a stand..."}'),

-- 22. KANYE WEST (Album 25: MBDTF)
('Power', 'cover_power.jpg', 'power.mp3', 22, 25, 300000000, 292, '2010-05-28', '{"text": "Im living in that 21st century..."}'),
('All of the Lights', 'cover_aotl.jpg', 'all_lights.mp3', 22, 25, 250000000, 299, '2011-01-18', '{"text": "Turn up the lights in here, baby..."}'),
('Runaway', 'cover_runaway.jpg', 'runaway.mp3', 22, 25, 220000000, 547, '2010-10-04', '{"text": "And I always find, yeah, I always find..."}'),

-- 23. DRAKE (Album 26: Scorpion)
('Gods Plan', 'cover_gp.jpg', 'gods_plan.mp3', 23, 26, 600000000, 198, '2018-01-19', '{"text": "They wishin, they wishin on me..."}'),
('Nice For What', 'cover_nfw.jpg', 'nice_for_what.mp3', 23, 26, 280000000, 210, '2018-04-06', '{"text": "Everybody get your roll on..."}'),
('In My Feelings', 'cover_imf.jpg', 'feelings.mp3', 23, 26, 450000000, 217, '2018-07-10', '{"text": "Kiki, do you love me?..."}'),
('Nonstop', 'cover_nonstop.jpg', 'nonstop.mp3', 23, 26, 210000000, 238, '2018-06-29', '{"text": "Look, I just flipped the switch..."}'),

-- 24. TRAVIS SCOTT (Album 27: Astroworld)
('Sicko Mode', 'cover_sicko.jpg', 'sicko_mode.mp3', 24, 27, 580000000, 312, '2018-08-21', '{"text": "Sun is down, freezin cold..."}'),
('Butterfly Effect', 'cover_butterfly.jpg', 'butterfly.mp3', 24, 27, 300000000, 213, '2017-05-15', '{"text": "For this life, I can not change..."}'),
('Stargazing', 'cover_stargazing.jpg', 'stargazing.mp3', 24, 27, 250000000, 271, '2018-08-03', '{"text": "Rollin, rollin, rollin, got me stargazin..."}'),

-- 25. KENDRICK LAMAR (Album 28: DAMN.)
('HUMBLE.', 'cover_humble.jpg', 'humble.mp3', 25, 28, 490000000, 177, '2017-03-30', '{"text": "Nobody pray for me..."}'),
('DNA.', 'cover_dna.jpg', 'dna.mp3', 25, 28, 310000000, 185, '2017-04-14', '{"text": "I got, I got, I got, I got..."}'),
('LOVE.', 'cover_love.jpg', 'love.mp3', 25, 28, 280000000, 213, '2017-10-02', '{"text": "If I didnt ride blade on curb..."}'),

-- 26. JAY Z (Album 29: The Blueprint)
('Izzo (H.O.V.A.)', 'cover_izzo.jpg', 'izzo.mp3', 26, 29, 150000000, 240, '2001-08-21', '{"text": "H to the Izzo, V to the IzzA..."}'),
('Renegade', 'cover_renegade.jpg', 'renegade.mp3', 26, 29, 120000000, 337, '2001-09-11', '{"text": "Motherfuckers say that Im foolish..."}'),

-- 27. 50 CENT (Album 30: Get Rich or Die Tryin)
('In Da Club', 'cover_indaclub.jpg', 'in_da_club.mp3', 27, 30, 550000000, 193, '2003-01-07', '{"text": "Go, go, go, go, go, go..."}'),
('P.I.M.P.', 'cover_pimp.jpg', 'pimp.mp3', 27, 30, 300000000, 249, '2003-08-12', '{"text": "I dont know what you heard about me..."}'),
('21 Questions', 'cover_21q.jpg', '21_questions.mp3', 27, 30, 280000000, 224, '2003-04-29', '{"text": "New York City! You are now rocking..."}'),

-- 28. SNOOP DOGG (Album 31: Doggystyle)
('Gin and Juice', 'cover_gin.jpg', 'gin_juice.mp3', 28, 31, 320000000, 211, '1994-01-15', '{"text": "With so much drama in the L-B-C..."}'),
('Who Am I? (What s My Name?)', 'cover_whoami.jpg', 'who_am_i.mp3', 28, 31, 290000000, 246, '1993-10-30', '{"text": "Snoop Doggy Dogg..."}'),

-- 29. CARDI B (Album 32: Invasion of Privacy)
('Bodak Yellow', 'cover_bodak.jpg', 'bodak_yellow.mp3', 29, 32, 350000000, 223, '2017-06-16', '{"text": "Said little bitch, you cant fuck with me..."}'),
('I Like It', 'cover_ilikeit.jpg', 'i_like_it.mp3', 29, 32, 480000000, 253, '2018-05-25', '{"text": "Now I like dollars, I like diamonds..."}'),

-- 30. NICKI MINAJ (Album 33: Pink Friday)
('Super Bass', 'cover_superbass.jpg', 'super_bass.mp3', 30, 33, 410000000, 200, '2011-04-05', '{"text": "This one is for the boys..."}'),
('Moment 4 Life', 'cover_m4l.jpg', 'moment.mp3', 30, 33, 190000000, 279, '2010-12-07', '{"text": "I fly with the stars in the skies..."}'),

-- 31. IMAGINE DRAGONS (Album 34: Night Visions, Album 35: Evolve)
('Radioactive', 'cover_radio.jpg', 'radioactive.mp3', 31, 34, 600000000, 186, '2012-10-29', '{"text": "Im waking up to ash and dust..."}'),
('Demons', 'cover_demons.jpg', 'demons.mp3', 31, 34, 550000000, 177, '2013-10-22', '{"text": "When the days are cold..."}'),
('Believer', 'cover_believer.jpg', 'believer.mp3', 31, 35, 700000000, 204, '2017-02-01', '{"text": "First things first..."}'),
('Thunder', 'cover_thunder.jpg', 'thunder.mp3', 31, 35, 580000000, 187, '2017-04-27', '{"text": "Just a young gun with a quick fuse..."}'),
('Whatever It Takes', 'cover_wit.jpg', 'whatever.mp3', 31, 35, 340000000, 201, '2017-10-06', '{"text": "Falling too fast to prepare for this..."}'),

-- 32. LINKIN PARK (Album 36: Hybrid Theory, Album 37: Meteora)
('In the End', 'cover_ite.jpg', 'in_the_end.mp3', 32, 36, 650000000, 216, '2001-10-09', '{"text": "It starts with one..."}'),
('Crawling', 'cover_crawling.jpg', 'crawling.mp3', 32, 36, 250000000, 209, '2001-03-01', '{"text": "Crawling in my skin..."}'),
('Papercut', 'cover_papercut.jpg', 'papercut.mp3', 32, 36, 180000000, 184, '2001-09-25', '{"text": "Why does it feel like night today?..."}'),
('Numb', 'cover_numb.jpg', 'numb.mp3', 32, 37, 700000000, 187, '2003-09-08', '{"text": "Im tired of being what you want me to be..."}'),
('Faint', 'cover_faint.jpg', 'faint.mp3', 32, 37, 220000000, 162, '2003-06-09', '{"text": "I am a little bit of loneliness..."}'),
('Breaking the Habit', 'cover_habit.jpg', 'breaking.mp3', 32, 37, 210000000, 196, '2004-06-14', '{"text": "Memories consume..."}'),

-- 33. COLDPLAY (Album 38: A Head Full of Dreams)
('Hymn for the Weekend', 'cover_hymn.jpg', 'hymn.mp3', 33, 38, 450000000, 258, '2016-01-25', '{"text": "Oh, angel sent from up above..."}'),
('Adventure of a Lifetime', 'cover_adventure.jpg', 'adventure.mp3', 33, 38, 320000000, 263, '2015-11-06', '{"text": "Turn your magic on..."}'),

-- 34. ARCTIC MONKEYS (Album 39: AM)
('Do I Wanna Know?', 'cover_diwk.jpg', 'wanna_know.mp3', 34, 39, 500000000, 272, '2013-06-19', '{"text": "Have you got colour in your cheeks?..."}'),
('R U Mine?', 'cover_rumine.jpg', 'ru_mine.mp3', 34, 39, 280000000, 201, '2012-02-27', '{"text": "Im a puppet on a string..."}'),
('Why d You Only Call Me When You re High?', 'cover_high.jpg', 'high.mp3', 34, 39, 310000000, 161, '2013-08-11', '{"text": "The mirror s image tells me..."}'),

-- 35. QUEEN (Album 40: A Night at the Opera)
('Bohemian Rhapsody', 'cover_bohemian.jpg', 'bohemian.mp3', 35, 40, 900000000, 354, '1975-10-31', '{"text": "Is this the real life?..."}'),
('You re My Best Friend', 'cover_bestfriend.jpg', 'best_friend.mp3', 35, 40, 200000000, 172, '1976-05-18', '{"text": "Ooh, you make me live..."}'),
('Love of My Life', 'cover_loml.jpg', 'love_life.mp3', 35, 40, 250000000, 219, '1975-11-21', '{"text": "Love of my life, you hurt me..."}'),

-- 36. TWENTY ONE PILOTS (Album 41: Blurryface)
('Stressed Out', 'cover_stressed.jpg', 'stressed.mp3', 36, 41, 650000000, 202, '2015-04-28', '{"text": "I wish I found some better sounds..."}'),
('Ride', 'cover_ride.jpg', 'ride.mp3', 36, 41, 480000000, 214, '2015-05-11', '{"text": "I just wanna stay in the sun..."}'),
('Heavydirtysoul', 'cover_hds.jpg', 'heavy.mp3', 36, 41, 150000000, 234, '2015-05-17', '{"text": "Theres an infestation in my minds imagination..."}'),

-- 37. RED HOT CHILI PEPPERS (Album 42: Californication)
('Californication', 'cover_californication.jpg', 'cali.mp3', 37, 42, 520000000, 321, '2000-06-20', '{"text": "Psychic spies from China try to steal... "}'),
('Otherside', 'cover_otherside.jpg', 'otherside.mp3', 37, 42, 410000000, 255, '2000-01-11', '{"text": "How long, how long will I slide?..."}'),
('Scar Tissue', 'cover_scar.jpg', 'scar_tissue.mp3', 37, 42, 380000000, 217, '1999-05-25', '{"text": "Scar tissue that I wish you saw..."}'),

-- 38. NIRVANA (Album 43: Nevermind)
('Smells Like Teen Spirit', 'cover_teen.jpg', 'teen_spirit.mp3', 38, 43, 850000000, 301, '1991-09-10', '{"text": "Load up on guns, bring your friends..."}'),
('Come As You Are', 'cover_come.jpg', 'come_as_you_are.mp3', 38, 43, 400000000, 219, '1992-03-02', '{"text": "Come as you are, as you were..."}'),
('Lithium', 'cover_lithium.jpg', 'lithium.mp3', 38, 43, 250000000, 257, '1992-07-13', '{"text": "Im so happy because today..."}'),

-- 39. METALLICA (Album 44: Master of Puppets)
('Master of Puppets', 'cover_master.jpg', 'master.mp3', 39, 44, 300000000, 515, '1986-07-02', '{"text": "End of passion play, crumbling away..."}'),
('Battery', 'cover_battery.jpg', 'battery.mp3', 39, 44, 150000000, 312, '1986-03-03', '{"text": "Lashing out the action..."}'),

-- 40. AC/DC (Album 45: Back in Black)
('Back in Black', 'cover_bib.jpg', 'back_in_black.mp3', 40, 45, 600000000, 255, '1980-12-21', '{"text": "Back in black, I hit the sack..."}'),
('Hells Bells', 'cover_hb.jpg', 'hells_bells.mp3', 40, 45, 250000000, 312, '1980-10-31', '{"text": "Im a rolling thunder..."}'),
('You Shook Me All Night Long', 'cover_shook.jpg', 'shook_me.mp3', 40, 45, 350000000, 210, '1980-08-19', '{"text": "She was a fast machine..."}'),

-- 41. DIMASH KUDAIBERGEN (Album 46: ID)
('S.O.S', 'cover_sos.jpg', 'sos.mp3', 41, 46, 120000000, 230, '2019-06-14', '{"text": "Pourquoi je vis, pourquoi je meurs..."}'),
('Screaming', 'cover_screaming.jpg', 'screaming.mp3', 41, 46, 50000000, 245, '2019-05-24', '{"text": "I feel you, I breathe you..."}'),
('Lay Down', 'cover_laydown.jpg', 'lay_down.mp3', 41, 46, 45000000, 215, '2019-06-14', '{"text": "Lay down, lay down..."}'),
('If I Never Breathe Again', 'cover_breathe.jpg', 'breathe.mp3', 41, 46, 30000000, 260, '2019-06-14', '{"text": "If I never breathe again..."}'),
('Olimpico', 'cover_olimpico.jpg', 'olimpico.mp3', 41, 46, 80000000, 270, '2019-06-14', '{"text": "Ognuno e libero..."}'),

-- 42. SCRIPTONITE (Album 47: House with Normal Activity, Album 48: Uroboros)
('Priton', 'cover_priton.jpg', 'priton.mp3', 42, 47, 110000000, 245, '2015-11-24', '{"text": "Vse moi bra, vse moi bra..."}'),
('Tantsuy sama', 'cover_tantsuy.jpg', 'tantsuy.mp3', 42, 47, 130000000, 275, '2015-11-24', '{"text": "Zdes net nikogo, krome nas..."}'),
('Vecherinka', 'cover_vecherinka.jpg', 'vecherinka.mp3', 42, 47, 150000000, 310, '2015-11-24', '{"text": "Ya ne khochu ukhodit..."}'),
('Vitamin', 'cover_vitamin.jpg', 'vitamin.mp3', 42, 48, 90000000, 185, '2017-12-16', '{"text": "Eto ne tyazhelyi metal..."}'),
('Multbrend', 'cover_mult.jpg', 'multbrend.mp3', 42, 48, 85000000, 250, '2017-12-16', '{"text": "Snova prazdnik, snova tsel..."}'),

-- 43. KAIRAT NURTAS (Album 49: Men Gashykpyn)
('Almaty Tuni', 'cover_almaty.jpg', 'almaty_tuni.mp3', 43, 49, 95000000, 220, '2018-05-20', '{"text": "Almaty tuni..."}'),
('Men Gashykpyn', 'cover_gashykpyn.jpg', 'men_gashykpyn.mp3', 43, 49, 80000000, 215, '2018-05-20', '{"text": "Zhuregim menin..."}'),
('Bayka', 'cover_bayka.jpg', 'bayka.mp3', 43, 49, 75000000, 210, '2018-05-20', '{"text": "Bayka, bayka..."}'),

-- 44. JAH KHALIB (Album 50: E.G.O.)
('Medina', 'cover_medina.jpg', 'medina.mp3', 44, 50, 160000000, 225, '2018-03-29', '{"text": "Medina, Medina..."}'),
('Leila', 'cover_leila.jpg', 'leila.mp3', 44, 50, 140000000, 235, '2016-10-14', '{"text": "Leila, Leila..."}'),
('Sozvezdie angela', 'cover_sozvezdie.jpg', 'sozvezdie.mp3', 44, 50, 110000000, 240, '2018-03-29', '{"text": "Ty moya..."}'),

-- 45. NINETY ONE (Album 51: Qarangy Zharyq)
('Mooz', 'cover_mooz.jpg', 'mooz.mp3', 45, 51, 60000000, 215, '2017-08-01', '{"text": "Muzga batyp bara zhatyrmyn..."}'),
('AhYahMah', 'cover_ahyahmah.jpg', 'ahyahmah.mp3', 45, 51, 55000000, 205, '2017-12-30', '{"text": "Ayama meni..."}'),
('Bayau', 'cover_bayau.jpg', 'bayau.mp3', 45, 51, 40000000, 230, '2017-06-02', '{"text": "Uaqyt toqtap qalganday..."}'),

-- 46. BATYRKHAN SHUKENOV (Album 52: Otan Ana)
('Otan Ana', 'cover_otan.jpg', 'otan_ana.mp3', 46, 52, 100000000, 260, '2002-10-10', '{"text": "Otan ana..."}'),
('Dzhulya', 'cover_dzhulya.jpg', 'dzhulya.mp3', 46, 52, 90000000, 245, '2002-10-10', '{"text": "Dzhulya, Dzhulya..."}'),
('Tvoyi Shagi', 'cover_shagi.jpg', 'shagi.mp3', 46, 52, 70000000, 250, '2006-05-15', '{"text": "Ya uznayu tvoyi shagi..."}'),

-- 47. NAZIMA (Album 53: Secrets)
('Begis', 'cover_begis.jpg', 'begis.mp3', 47, 53, 30000000, 190, '2018-06-02', '{"text": "Begis, begis..."}'),
('Real One', 'cover_real.jpg', 'real_one.mp3', 47, 53, 25000000, 185, '2019-10-15', '{"text": "Im the real one..."}'),
('Ty ne budesh odin', 'cover_odin.jpg', 'odin.mp3', 47, 53, 20000000, 200, '2019-10-15', '{"text": "Ty ne budesh odin..."}'),

-- 48. AIKYN TOLEPBERGEN (Album 54: Aikyn)
('Altynym', 'cover_altynym.jpg', 'altynym.mp3', 48, 54, 40000000, 220, '2015-09-01', '{"text": "Altynym menin..."}'),
('Pakh-Pakh', 'cover_pakh.jpg', 'pakh.mp3', 48, 54, 35000000, 210, '2015-09-01', '{"text": "Pakh pakh..."}'),
('Umit tola', 'cover_umit.jpg', 'umit.mp3', 48, 54, 30000000, 230, '2015-09-01', '{"text": "Umit tola kozderinde..."}'),

-- 49. MOT (Album 55: Dobraia Muzyka)
('Kapkan', 'cover_kapkan.jpg', 'kapkan.mp3', 49, 55, 120000000, 215, '2016-02-23', '{"text": "Eto lovushka, eto kapkan..."}'),
('Soparano', 'cover_soprano.jpg', 'soprano.mp3', 49, 55, 150000000, 220, '2017-03-01', '{"text": "Ty moya Soprano..."}'),
('Avgust', 'cover_avgust.jpg', 'avgust.mp3', 49, 55, 60000000, 205, '2021-08-27', '{"text": "Eto byl nash avgust..."}'),

-- 50. EGOR CREED (Album 56: Bachelor - Note: ID might be 56 in your sequence, or 50 if generated via random, but strictly following our insert list it is the last album inserted)
('Samaya Samaya', 'cover_samaya.jpg', 'samaya.mp3', 50, 56, 180000000, 210, '2014-10-09', '{"text": "O bozhe mama..."}'),
('Budilnik', 'cover_budilnik.jpg', 'budilnik.mp3', 50, 56, 140000000, 205, '2015-12-07', '{"text": "Mne nravitsya..."}'),
('Nevesta', 'cover_nevesta.jpg', 'nevesta.mp3', 50, 56, 130000000, 195, '2015-04-02', '{"text": "Ty budesh moey nevestoy..."}'),
('Potrachu', 'cover_potrachu.jpg', 'potrachu.mp3', 50, 56, 90000000, 184, '2017-05-26', '{"text": "Ya potrachu na tebya..."}'),

-- Дополнительные треки для объема (Pop Hits filler)
('Love Me Like You Do', 'cover_lmlyd.jpg', 'love_me.mp3', 10, 12, 300000000, 240, '2015-01-07', '{"text": "You are the light..."}'),
('Rolling in the Deep', 'cover_rolling.jpg', 'rolling.mp3', 10, 12, 550000000, 228, '2010-11-29', '{"text": "Theres a fire starting in my heart..."}'),
('Set Fire to the Rain', 'cover_setfire.jpg', 'set_fire.mp3', 10, 12, 400000000, 242, '2011-07-04', '{"text": "I let it fall..."}'),
('Can t Stop the Feeling', 'cover_feeling.jpg', 'feeling.mp3', 4, 6, 380000000, 236, '2016-05-06', '{"text": "I got this feeling..."}'),
('What Do You Mean', 'cover_wdym.jpg', 'wdym.mp3', 4, 6, 350000000, 205, '2015-08-28', '{"text": "What do you mean?..."}'),
('Love Yourself', 'cover_loveyourself.jpg', 'loveyourself.mp3', 4, 6, 420000000, 233, '2015-11-09', '{"text": "For all the times that you rained on my parade..."}'),
('Umbrella', 'cover_umbrella.jpg', 'umbrella.mp3', 13, 15, 600000000, 275, '2007-03-29', '{"text": "Under my umbrella..."}'),
('Diamonds', 'cover_diamonds.jpg', 'diamonds.mp3', 13, 15, 500000000, 225, '2012-09-27', '{"text": "Shine bright like a diamond..."}'),
('We Found Love', 'cover_wfl.jpg', 'we_found_love.mp3', 13, 15, 480000000, 215, '2011-09-22', '{"text": "Yellow diamonds in the light..."}'),
('Single Ladies', 'cover_single.jpg', 'single_ladies.mp3', 14, 16, 450000000, 193, '2008-10-13', '{"text": "All the single ladies..."}'),
('Halo', 'cover_halo.jpg', 'halo.mp3', 14, 16, 520000000, 261, '2009-01-20', '{"text": "Remember those walls I built..."}'),
('Crazy in Love', 'cover_crazy.jpg', 'crazy_love.mp3', 14, 16, 580000000, 236, '2003-05-14', '{"text": "Got me looking so crazy right now..."}'),
('Poker Face', 'cover_poker.jpg', 'poker.mp3', 9, 11, 490000000, 237, '2008-09-26', '{"text": "Mum mum mum mah..."}'),
('Bad Romance', 'cover_romance.jpg', 'romance.mp3', 9, 11, 560000000, 294, '2009-10-26', '{"text": "Rah rah ah-ah-ah!..."}'),
('Shallow', 'cover_shallow.jpg', 'shallow.mp3', 9, 11, 600000000, 215, '2018-09-27', '{"text": "Tell me somethin, girl..."}'),
('Lose Yourself', 'cover_lose.jpg', 'lose_yourself.mp3', 21, 23, 950000000, 326, '2002-10-28', '{"text": "Look, if you had one shot..."}'),
('The Real Slim Shady', 'cover_shady.jpg', 'slim_shady.mp3', 21, 23, 700000000, 284, '2000-04-18', '{"text": "May I have your attention, please?..."}'),
('Mockingbird', 'cover_mocking.jpg', 'mockingbird.mp3', 21, 24, 600000000, 250, '2005-04-25', '{"text": "Yeah, I know sometimes..."}'),
('Stronger', 'cover_stronger.jpg', 'stronger.mp3', 22, 25, 400000000, 311, '2007-07-31', '{"text": "Work it, make it, do it..."}'),
('Heartless', 'cover_heartless_kanye.jpg', 'heartless_k.mp3', 22, 25, 350000000, 211, '2008-11-04', '{"text": "In the night, I hear em talk..."}'),
('Gold Digger', 'cover_gold.jpg', 'gold_digger.mp3', 22, 25, 380000000, 207, '2005-07-05', '{"text": "She take my money..."}'),
('Hotline Bling', 'cover_hotline.jpg', 'hotline.mp3', 23, 26, 500000000, 267, '2015-07-31', '{"text": "You used to call me on my cell phone..."}'),
('One Dance', 'cover_onedance.jpg', 'one_dance.mp3', 23, 26, 650000000, 173, '2016-04-05', '{"text": "Baby, I like your style..."}'),
('Started From the Bottom', 'cover_started.jpg', 'started.mp3', 23, 26, 300000000, 173, '2013-02-06', '{"text": "Started from the bottom, now we re here..."}'),
('Goosebumps', 'cover_goose.jpg', 'goosebumps.mp3', 24, 27, 450000000, 243, '2016-09-02', '{"text": "I get those goosebumps every time..."}'),
('Highest in the Room', 'cover_highest.jpg', 'highest.mp3', 24, 27, 400000000, 175, '2019-10-04', '{"text": "I got room in my fumes..."}'),
('Antidote', 'cover_antidote.jpg', 'antidote.mp3', 24, 27, 320000000, 262, '2015-07-29', '{"text": "Dont you open up that window..."}');

INSERT INTO Tags (tag_name, tag_type) VALUES
-- Жанры (Genres) IDs 1-15
('Pop', 'Genre'),            -- 1
('R&B', 'Genre'),            -- 2
('Hip-Hop', 'Genre'),        -- 3
('Rap', 'Genre'),            -- 4
('Rock', 'Genre'),           -- 5
('Alternative', 'Genre'),    -- 6
('Metal', 'Genre'),          -- 7
('Electronic', 'Genre'),     -- 8
('Jazz', 'Genre'),           -- 9
('Country', 'Genre'),        -- 10
('K-Pop', 'Genre'),          -- 11
('Q-Pop', 'Genre'),          -- 12 (Kazakh Pop)
('Indie', 'Genre'),          -- 13
('Soul', 'Genre'),           -- 14
('Reggae', 'Genre'),         -- 15

-- Настроение (Mood) IDs 16-20
('Happy', 'Mood'),           -- 16
('Sad', 'Mood'),             -- 17
('Chill', 'Mood'),           -- 18
('Energetic', 'Mood'),       -- 19
('Romantic', 'Mood'),        -- 20

-- Активность (Activity) IDs 21-25
('Workout', 'Activity'),     -- 21
('Party', 'Activity'),       -- 22
('Focus', 'Activity'),       -- 23
('Sleep', 'Activity'),       -- 24
('Road Trip', 'Activity'),   -- 25

-- Эпоха (Era) IDs 26-28
('90s', 'Era'),              -- 26
('2000s', 'Era'),            -- 27
('Classics', 'Era');         -- 28

INSERT INTO Playlists (playlist_name, playlist_poster, quantity_of_auditions, is_public, user_ID)
SELECT 
    CASE (floor(random() * 10) + 1)::int
        WHEN 1 THEN 'My Favorites'
        WHEN 2 THEN 'Gym & Workout'
        WHEN 3 THEN 'Late Night Vibes'
        WHEN 4 THEN 'Road Trip Essentials'
        WHEN 5 THEN 'Party Mix 2025'
        WHEN 6 THEN 'Sad Songs'
        WHEN 7 THEN 'Chill & Relax'
        WHEN 8 THEN 'Focus Mode'
        WHEN 9 THEN 'Throwback Classics'
        ELSE 'Best of the Best'
    END,
    'https://cover.img/playlist_' || i || '.jpg',
    (random() * 500)::int, -- Количество прослушиваний плейлиста
    CASE WHEN random() > 0.3 THEN true ELSE false END, -- 70% плейлистов публичные
    i -- ID пользователя (от 1 до 100)
FROM generate_series(1, 100) AS i;

-- Добавим еще 20 специфичных жанровых плейлистов для активных юзеров (ID 1-20)
INSERT INTO Playlists (playlist_name, playlist_poster, quantity_of_auditions, is_public, user_ID) VALUES
('Hip-Hop Legends', 'cover_hh.jpg', 1500, true, 1),      -- ID 101
('Rock Anthems', 'cover_rock.jpg', 1200, true, 2),       -- ID 102
('Q-Pop Hits', 'cover_qpop.jpg', 3000, true, 3),         -- ID 103
('Pop Divas', 'cover_pop.jpg', 800, true, 4),            -- ID 104
('Metal Hardcore', 'cover_metal.jpg', 666, true, 5),     -- ID 105
('Kazakh Soul', 'cover_kz.jpg', 2000, true, 6),          -- ID 106
('Rap Caviar', 'cover_rap.jpg', 5000, true, 7),          -- ID 107
('80s & 90s', 'cover_retro.jpg', 900, true, 8),          -- ID 108
('Electronic Dance', 'cover_edm.jpg', 1100, true, 9),    -- ID 109
('Sunday Morning', 'cover_sun.jpg', 400, false, 10),     -- ID 110
('Running Mix', 'cover_run.jpg', 750, true, 11),         -- ID 111
('Sleep Timer', 'cover_sleep.jpg', 200, false, 12),      -- ID 112
('Date Night', 'cover_date.jpg', 150, false, 13),        -- ID 113
('Coding Flow', 'cover_code.jpg', 10000, true, 14),      -- ID 114
('Summer 2024', 'cover_summer.jpg', 2200, true, 15),     -- ID 115
('Winter Cozy', 'cover_winter.jpg', 1300, true, 16),     -- ID 116
('Gaming Music', 'cover_game.jpg', 4500, true, 17),      -- ID 117
('TikTok Viral', 'cover_tiktok.jpg', 8000, true, 18),    -- ID 118
('Car Music', 'cover_car.jpg', 3200, true, 19),          -- ID 119
('Sad Boi Hours', 'cover_sad.jpg', 600, true, 20);       -- ID 120

-- 1. НАПОЛНЕНИЕ ОБЫЧНЫХ ПЛЕЙЛИСТОВ (ID 1-100)
-- В каждый из 100 плейлистов добавляем по 15 случайных треков
INSERT INTO Tracks (playlist_ID, music_ID, addition_date)
SELECT 
    p.playlist_ID,
    (floor(random() * 198) + 1)::int, -- Случайный трек от 1 до 198
    NOW() - (random() * 30 || ' days')::interval
FROM Playlists p
CROSS JOIN generate_series(1, 15) -- Повторить 15 раз для каждого плейлиста
WHERE p.playlist_ID <= 100
ON CONFLICT DO NOTHING; -- Если рандом выдаст дубликат трека в плейлисте, просто пропустить

-- 2. НАПОЛНЕНИЕ ЖАНРОВЫХ ПЛЕЙЛИСТОВ (Точечно)

-- Playlist 101: Hip-Hop Legends (Треки Eminem, Kanye, Drake, Travis) - ID диапазон ~76-104 + ~188-198
INSERT INTO Tracks (playlist_ID, music_ID)
SELECT 101, music_ID FROM Musics WHERE music_ID BETWEEN 76 AND 104;

-- Playlist 102: Rock Anthems (Linkin Park, Queen, Nirvana, RHCP) - ID диапазон ~105-137
INSERT INTO Tracks (playlist_ID, music_ID)
SELECT 102, music_ID FROM Musics WHERE music_ID BETWEEN 105 AND 137;

-- Playlist 103: Q-Pop Hits (Ninety One, Nazima, Aikyn) - ID диапазон ~154-170
INSERT INTO Tracks (playlist_ID, music_ID)
SELECT 103, music_ID FROM Musics WHERE music_ID BETWEEN 154 AND 170;

-- Playlist 104: Pop Divas (Taylor, Ariana, Dua Lipa, Beyonce) - ID диапазон ~9-32 + 58-60
INSERT INTO Tracks (playlist_ID, music_ID)
SELECT 104, music_ID FROM Musics WHERE music_ID BETWEEN 9 AND 32;

-- Playlist 105: Metal Hardcore (Metallica, AC/DC + Linkin Park heavy)
INSERT INTO Tracks (playlist_ID, music_ID)
SELECT 105, music_ID FROM Musics WHERE music_ID IN (111, 133, 134, 135, 136, 137, 105);

-- Playlist 106: Kazakh Soul (Batyr, Kairat Nurtas, Dimash)
INSERT INTO Tracks (playlist_ID, music_ID)
SELECT 106, music_ID FROM Musics WHERE music_ID BETWEEN 138 AND 158;

-- Playlist 107: Rap Caviar (Fresh Rap - Travis Scott, Cardi B, Post Malone)
INSERT INTO Tracks (playlist_ID, music_ID)
SELECT 107, music_ID FROM Musics WHERE music_ID IN (88, 89, 90, 101, 102, 71, 72, 73, 197, 198);

-- Playlist 108: 80s & 90s (Queen, Nirvana, Snoop Dogg)
INSERT INTO Tracks (playlist_ID, music_ID)
SELECT 108, music_ID FROM Musics WHERE music_ID IN (121, 122, 130, 131, 99, 100, 135);

-- Playlist 114: Coding Flow (Instrumentals, Hans Zimmer vibes, Chill Weeknd)
INSERT INTO Tracks (playlist_ID, music_ID)
SELECT 114, music_ID FROM Musics WHERE music_ID IN (1, 5, 8, 30, 106, 116, 118);

-- Playlist 117: Gaming Music (Imagine Dragons, Linkin Park, Skrillex vibes)
INSERT INTO Tracks (playlist_ID, music_ID)
SELECT 117, music_ID FROM Musics WHERE music_ID BETWEEN 105 AND 115;

-- Playlist 120: Sad Boi Hours (Joji vibe, Sad Weeknd, Adele)
INSERT INTO Tracks (playlist_ID, music_ID)
SELECT 120, music_ID FROM Musics WHERE music_ID IN (2, 13, 17, 37, 45, 63, 68, 73);

-- 3. Добавим немного хаотичности (Разные даты добавления для реалистичности сортировки)
UPDATE Tracks 
SET addition_date = NOW() - (random() * 365 || ' days')::interval;

-- 1. ЛЮБИТЕЛИ МЕЙНСТРИМА (Почти все подписаны на мировых звезд)
-- Пользователи 1-100 подписываются на The Weeknd (1), Taylor Swift (2), Drake (23) с вероятностью 50%
INSERT INTO UserFollowsAuthors (user_ID, author_ID)
SELECT u.user_ID, a.author_ID
FROM Users u
CROSS JOIN Authors a
WHERE a.author_ID IN (1, 2, 23) AND random() > 0.5
ON CONFLICT DO NOTHING;

-- 2. "KZ PATRIOTS" (Пользователи 1-40 - Алматы/Астана - подписываются на своих)
-- Подписки на Scriptonite (42), Dimash (41), Kairat Nurtas (43), Ninety One (45)
INSERT INTO UserFollowsAuthors (user_ID, author_ID)
SELECT u.user_ID, a.author_ID
FROM Users u
CROSS JOIN Authors a
WHERE u.user_ID BETWEEN 1 AND 40 
  AND a.author_ID IN (41, 42, 43, 44, 45, 46, 47)
ON CONFLICT DO NOTHING;

-- 3. "OLD SCHOOL ROCKERS" (Пользователи 50-70 любят рок)
-- Подписки на Queen (35), Metallica (39), AC/DC (40), Linkin Park (32)
INSERT INTO UserFollowsAuthors (user_ID, author_ID)
SELECT u.user_ID, a.author_ID
FROM Users u
CROSS JOIN Authors a
WHERE u.user_ID BETWEEN 50 AND 70 
  AND a.author_ID IN (32, 35, 39, 40, 37, 38)
ON CONFLICT DO NOTHING;

-- 4. "RAP HEADS" (Пользователи 80-100 любят хип-хоп)
-- Подписки на Eminem (21), Kanye (22), Travis Scott (24), 50 Cent (27)
INSERT INTO UserFollowsAuthors (user_ID, author_ID)
SELECT u.user_ID, a.author_ID
FROM Users u
CROSS JOIN Authors a
WHERE u.user_ID BETWEEN 80 AND 100 
  AND a.author_ID IN (21, 22, 24, 27, 26, 28)
ON CONFLICT DO NOTHING;

-- Если пользователь подписан на Автора, он сохраняет его случайный альбом
INSERT INTO UserSavedAlbums (user_ID, album_ID)
SELECT 
    ufa.user_ID, 
    a.album_ID
FROM UserFollowsAuthors ufa
JOIN Albums a ON ufa.author_ID = a.author_ID
WHERE random() > 0.3 -- Сохраняют не все альбомы, а примерно 70%
ON CONFLICT DO NOTHING;

-- СЕССИЯ 1: Фанаты The Weeknd (Вчера и сегодня)
-- Пользователи 1-5 слушали альбом After Hours (Tracks 1-4)
INSERT INTO ListeningStory (music_ID, user_ID, date_of_playing, duration_of_playing)
SELECT 
    m.music_ID,
    u.user_ID,
    NOW() - (random() * interval '2 days'), -- Последние 48 часов
    m.music_duration - (floor(random() * 10)) -- Слушали почти до конца (минус 0-10 сек)
FROM Musics m
CROSS JOIN generate_series(1, 5) AS u(user_ID)
WHERE m.music_ID BETWEEN 1 AND 4;

-- СЕССИЯ 2: Казахстанский вайб (Поездка на работу)
-- Пользователи 10-20 слушали Скриптонита и 91 (Tracks 143-146, 154-156)
INSERT INTO ListeningStory (music_ID, user_ID, date_of_playing, duration_of_playing)
SELECT 
    m.music_ID,
    u.user_ID,
    NOW() - (interval '5 hours' + (random() * interval '1 hour')), -- Сегодня утром
    m.music_duration
FROM Musics m
CROSS JOIN generate_series(10, 20) AS u(user_ID)
WHERE m.music_ID IN (143, 144, 145, 154, 155, 156);

-- СЕССИЯ 3: Рок-ностальгия
-- Пользователи 55-60 слушали Queen и Metallica неделю назад
INSERT INTO ListeningStory (music_ID, user_ID, date_of_playing, duration_of_playing)
SELECT 
    m.music_ID,
    u.user_ID,
    NOW() - (interval '7 days' + (random() * interval '3 hours')),
    m.music_duration
FROM Musics m
CROSS JOIN generate_series(55, 60) AS u(user_ID)
WHERE m.music_ID IN (121, 122, 133, 134);

-- СЕССИЯ 4: Тренbровка в зале (Workout Playlist)
-- Пользователи 25-35 слушали Eminem и Travis Scott (Tracks 78, 81, 88)
INSERT INTO ListeningStory (music_ID, user_ID, date_of_playing, duration_of_playing)
SELECT 
    m.music_ID,
    u.user_ID,
    NOW() - (interval '1 day' + (random() * interval '2 hours')),
    m.music_duration
FROM Musics m
CROSS JOIN generate_series(25, 35) AS u(user_ID)
WHERE m.music_ID IN (78, 81, 88, 107);

-- СЕССИЯ 5: Грустный вечер (Sad Songs)
-- Случайные пользователи слушали Adele и Joji (Sad tags)
INSERT INTO ListeningStory (music_ID, user_ID, date_of_playing, duration_of_playing)
SELECT 
    m.music_ID,
    (floor(random() * 100) + 1)::int,
    NOW() - (random() * interval '5 days'),
    m.music_duration
FROM Musics m
JOIN MusicTag mt ON m.music_ID = mt.music_ID
JOIN Tags t ON mt.tag_ID = t.tag_ID
WHERE t.tag_name = 'Sad'
LIMIT 100; -- 100 грустных прослушиваний

-- СЕССИЯ 6: Скипы (Пропущенные треки)
-- Люди включили песню, послушали 10 секунд и переключили.
INSERT INTO ListeningStory (music_ID, user_ID, date_of_playing, duration_of_playing)
SELECT 
    (floor(random() * 200) + 1)::int,
    (floor(random() * 100) + 1)::int,
    NOW() - (random() * interval '3 days'),
    (floor(random() * 30) + 5)::int -- Слушали от 5 до 35 секунд
FROM generate_series(1, 50);


---------------------------------------------------------------------------------------------

select * from ListeningStory;

select Users.user_ID, Users.user_name, Users.user_surname, string_agg(Musics.music_name, ', ') as listened_songs from Users
join ListeningStory on Users.user_ID = ListeningStory.user_ID
join Musics on ListeningStory.music_ID = Musics.music_ID
group by Users.user_ID, Users.user_name, Users.user_surname
order by Users.user_ID asc;
