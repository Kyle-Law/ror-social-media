CREATE TABLE `users` (
  `id` integer,
  `username` string,
  `email` string,
  `password` string,
  `password_confirmation` string,
  `gravatar_url` sring,
  PRIMARY KEY (`id`)
);

CREATE TABLE `posts` (
  `id` integer,
  `user_id` integer,
  `content` text,
  PRIMARY KEY (`id`),
  KEY `FK` (`user_id`)
);

CREATE TABLE `likes` (
  `id` integer,
  `post_id` integer,
  `user_id` integer,
  PRIMARY KEY (`id`),
  KEY `FK` (`post_id`, `user_id`)
);

CREATE TABLE `comments` (
  `id` integer,
  `user_id` integer,
  `post_id` integer,
  `content` text,
  PRIMARY KEY (`id`),
  KEY `FK` (`user_id`, `post_id`)
);

CREATE TABLE `friends` (
  `id` integer,
  `sender_id` integer,
  `receiver_id` integer,
  `status` boolean,
  PRIMARY KEY (`id`),
  KEY `FK` (`sender_id`, `receiver_id`)
);

