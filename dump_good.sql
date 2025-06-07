# Converted with pg2mysql-1.9
# Converted on Sat, 07 Jun 2025 06:20:19 -0400
# Lightbox Technologies Inc. http://www.lightbox.ca

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone="+00:00";

CREATE TABLE public.alembic_version (
    version_num varchar(32) NOT NULL
) TYPE=MyISAM;

CREATE TABLE public.article (
    id int(11) NOT NULL,
    title varchar(255) NOT NULL,
    content text NOT NULL,
    created_at timestamp,
    category_id int(11),
    media_filename varchar(255),
    user_id int(11),
    author_id int(11)
) TYPE=MyISAM;

CREATE TABLE public.article_tag (
    article_id int(11),
    tag_id int(11)
) TYPE=MyISAM;

CREATE TABLE public.category (
    id int(11) NOT NULL,
    name varchar(255) NOT NULL
) TYPE=MyISAM;

CREATE TABLE public.tag (
    id int(11) NOT NULL,
    name varchar(255) NOT NULL
) TYPE=MyISAM;

CREATE TABLE public.users (
    id int(11) NOT NULL,
    username varchar(80) NOT NULL,
    email text NOT NULL,
    password_hash text,
    articles_count int(11) NOT NULL,
    age int(11) NOT NULL,
    created_at timestamp
) TYPE=MyISAM;

ALTER TABLE public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);
ALTER TABLE public.article
    ADD CONSTRAINT article_pkey PRIMARY KEY (id);
ALTER TABLE public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);
ALTER TABLE public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);
ALTER TABLE public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
