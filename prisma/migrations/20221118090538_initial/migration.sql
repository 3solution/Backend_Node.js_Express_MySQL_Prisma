-- CreateTable
CREATE TABLE `activity` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `username` VARCHAR(80) NULL,
    `ip` VARBINARY(16) NULL,
    `failed` BOOLEAN NOT NULL DEFAULT false,
    `failed_last` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `type` VARCHAR(20) NULL,
    `message` VARCHAR(150) NULL,
    `importance` BOOLEAN NOT NULL DEFAULT false,
    `created` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `banlist` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `item` VARCHAR(50) NOT NULL,
    `type` ENUM('IP', 'Email') NOT NULL DEFAULT 'IP',
    `comment` VARCHAR(150) NOT NULL,

    INDEX `ban_ip`(`item`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `cart` (
    `uid` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `mid` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `cid` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `tax` DECIMAL(13, 2) NOT NULL DEFAULT 0.00,
    `totaltax` DECIMAL(13, 2) NOT NULL DEFAULT 0.00,
    `coupon` DECIMAL(13, 2) NOT NULL DEFAULT 0.00,
    `total` DECIMAL(13, 2) NOT NULL DEFAULT 0.00,
    `originalprice` DECIMAL(13, 2) NOT NULL DEFAULT 0.00,
    `totalprice` DECIMAL(13, 2) NOT NULL DEFAULT 0.00,
    `cart_id` VARCHAR(100) NULL,
    `order_id` VARCHAR(100) NULL,
    `created` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `idx_membership`(`mid`),
    INDEX `idx_user`(`uid`),
    PRIMARY KEY (`uid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `countries` (
    `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `abbr` VARCHAR(2) NOT NULL,
    `name` VARCHAR(70) NOT NULL,
    `active` BOOLEAN NOT NULL DEFAULT true,
    `home` BOOLEAN NOT NULL DEFAULT false,
    `vat` DECIMAL(13, 2) NOT NULL DEFAULT 0.00,
    `sorting` SMALLINT UNSIGNED NOT NULL DEFAULT 0,

    UNIQUE INDEX `abbrv`(`abbr`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `coupons` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(100) NOT NULL,
    `code` VARCHAR(30) NOT NULL,
    `discount` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    `type` ENUM('p', 'a') NOT NULL DEFAULT 'p',
    `membership_id` VARCHAR(50) NOT NULL DEFAULT '0',
    `ctype` VARCHAR(30) NULL,
    `created` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `active` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `cronjobs` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `membership_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `stripe_customer` VARCHAR(60) NOT NULL,
    `stripe_pm` VARCHAR(80) NOT NULL,
    `amount` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    `created` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `renewal` DATETIME(0) NOT NULL,

    INDEX `idx_membership_id`(`membership_id`),
    INDEX `idx_user_id`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `custom_fields` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `title_en` VARCHAR(60) NOT NULL,
    `title_de` VARCHAR(60) NOT NULL,
    `title_nl` VARCHAR(60) NOT NULL,
    `title_fr` VARCHAR(60) NOT NULL,
    `tooltip_en` VARCHAR(100) NULL,
    `tooltip_de` VARCHAR(100) NULL,
    `tooltip_nl` VARCHAR(100) NULL,
    `tooltip_fr` VARCHAR(100) NULL,
    `name` VARCHAR(20) NOT NULL,
    `required` BOOLEAN NOT NULL DEFAULT false,
    `section` VARCHAR(30) NULL,
    `sorting` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `active` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `custom_fields_data` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `field_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `digishop_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `portfolio_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `shop_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `field_name` VARCHAR(40) NULL,
    `field_value` VARCHAR(100) NULL,
    `section` VARCHAR(30) NULL,

    INDEX `idx_digishop`(`digishop_id`),
    INDEX `idx_field`(`field_id`),
    INDEX `idx_portfolio`(`portfolio_id`),
    INDEX `idx_shop`(`shop_id`),
    INDEX `idx_user`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `email_templates` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name_en` VARCHAR(100) NOT NULL,
    `name_de` VARCHAR(100) NOT NULL,
    `name_nl` VARCHAR(100) NOT NULL,
    `name_fr` VARCHAR(100) NOT NULL,
    `subject_en` VARCHAR(150) NOT NULL,
    `subject_de` VARCHAR(150) NOT NULL,
    `subject_nl` VARCHAR(150) NOT NULL,
    `subject_fr` VARCHAR(150) NOT NULL,
    `help_en` TINYTEXT NULL,
    `help_de` TINYTEXT NULL,
    `help_nl` TINYTEXT NULL,
    `help_fr` TINYTEXT NULL,
    `body_en` TEXT NOT NULL,
    `body_de` TEXT NOT NULL,
    `body_nl` TEXT NOT NULL,
    `body_fr` TEXT NOT NULL,
    `type` ENUM('news', 'mailer') NULL DEFAULT 'mailer',
    `typeid` VARCHAR(30) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `gateways` (
    `id` BOOLEAN NOT NULL,
    `name` VARCHAR(25) NOT NULL,
    `displayname` VARCHAR(50) NOT NULL,
    `dir` VARCHAR(25) NOT NULL,
    `live` BOOLEAN NOT NULL DEFAULT true,
    `extra_txt` VARCHAR(100) NULL,
    `extra_txt2` VARCHAR(100) NULL,
    `extra_txt3` VARCHAR(100) NULL,
    `extra` VARCHAR(100) NULL,
    `extra2` VARCHAR(100) NULL,
    `extra3` TEXT NULL,
    `is_recurring` BOOLEAN NOT NULL DEFAULT false,
    `active` BOOLEAN NOT NULL DEFAULT true,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `language` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NULL,
    `abbr` VARCHAR(2) NULL,
    `langdir` ENUM('ltr', 'rtl') NULL DEFAULT 'ltr',
    `color` VARCHAR(7) NULL,
    `author` VARCHAR(200) NULL,
    `home` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `layout` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `plug_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `page_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `mod_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `modalias` VARCHAR(30) NULL,
    `page_slug_en` VARCHAR(150) NULL,
    `page_slug_de` VARCHAR(150) NULL,
    `page_slug_nl` VARCHAR(150) NULL,
    `page_slug_fr` VARCHAR(150) NULL,
    `is_content` BOOLEAN NOT NULL DEFAULT false,
    `plug_name` VARCHAR(60) NULL,
    `place` VARCHAR(20) NULL,
    `space` TINYINT UNSIGNED NOT NULL DEFAULT 10,
    `type` VARCHAR(8) NULL,
    `sorting` INTEGER UNSIGNED NOT NULL DEFAULT 0,

    INDEX `idx_mod_id`(`mod_id`),
    INDEX `idx_page_id`(`page_id`),
    INDEX `idx_plug_id`(`plug_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `memberships` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `title_en` VARCHAR(80) NOT NULL DEFAULT '',
    `title_de` VARCHAR(80) NOT NULL,
    `title_nl` VARCHAR(80) NOT NULL,
    `title_fr` VARCHAR(80) NOT NULL,
    `description_en` VARCHAR(150) NULL,
    `description_de` VARCHAR(150) NULL,
    `description_nl` VARCHAR(150) NULL,
    `description_fr` VARCHAR(150) NULL,
    `thumb` VARCHAR(40) NULL,
    `price` FLOAT NOT NULL DEFAULT 0.00,
    `days` SMALLINT UNSIGNED NOT NULL DEFAULT 1,
    `period` VARCHAR(1) NOT NULL DEFAULT 'D',
    `trial` BOOLEAN NOT NULL DEFAULT false,
    `recurring` BOOLEAN NOT NULL DEFAULT false,
    `private` BOOLEAN NOT NULL DEFAULT false,
    `active` BOOLEAN NOT NULL DEFAULT true,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `menus` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `parent_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `page_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `page_slug_en` VARCHAR(100) NULL,
    `page_slug_de` VARCHAR(100) NULL,
    `page_slug_nl` VARCHAR(100) NULL,
    `page_slug_fr` VARCHAR(100) NULL,
    `name_en` VARCHAR(100) NOT NULL,
    `name_de` VARCHAR(100) NOT NULL,
    `name_nl` VARCHAR(100) NOT NULL,
    `name_fr` VARCHAR(100) NOT NULL,
    `mod_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `mod_slug` VARCHAR(100) NULL,
    `caption_en` VARCHAR(100) NULL,
    `caption_de` VARCHAR(100) NULL,
    `caption_nl` VARCHAR(100) NULL,
    `caption_fr` VARCHAR(100) NULL,
    `content_type` VARCHAR(20) NOT NULL DEFAULT 'page',
    `link` VARCHAR(200) NULL,
    `target` VARCHAR(15) NOT NULL DEFAULT '_blank',
    `icon` VARCHAR(50) NULL,
    `cols` BOOLEAN NOT NULL DEFAULT true,
    `position` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `home_page` BOOLEAN NOT NULL DEFAULT false,
    `active` BOOLEAN NOT NULL DEFAULT false,

    INDEX `idx_mod_id`(`mod_id`),
    INDEX `idx_page_id`(`page_id`),
    INDEX `idx_parent_id`(`parent_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mod_adblock` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `title_en` VARCHAR(100) NOT NULL,
    `title_de` VARCHAR(100) NOT NULL,
    `title_nl` VARCHAR(100) NOT NULL,
    `title_fr` VARCHAR(100) NOT NULL,
    `plugin_id` VARCHAR(30) NOT NULL,
    `start_date` DATE NULL,
    `end_date` DATE NULL,
    `total_views_allowed` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `total_clicks_allowed` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `minimum_ctr` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    `image` VARCHAR(50) NULL,
    `image_link` VARCHAR(100) NULL,
    `image_alt` VARCHAR(100) NULL,
    `html` TEXT NULL,
    `total_views` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `total_clicks` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `created` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mod_comments` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `comment_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `user_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `parent_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `username` VARCHAR(50) NULL,
    `section` VARCHAR(20) NOT NULL,
    `vote_up` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `vote_down` INTEGER NOT NULL DEFAULT 0,
    `body` TEXT NULL,
    `created` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `active` BOOLEAN NOT NULL DEFAULT false,

    INDEX `idx_comment_id`(`comment_id`),
    INDEX `idx_parent`(`parent_id`),
    INDEX `idx_user_id`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mod_digishop` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `category_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `title_en` VARCHAR(100) NOT NULL,
    `title_fr` VARCHAR(100) NOT NULL,
    `title_nl` VARCHAR(100) NOT NULL,
    `title_de` VARCHAR(100) NOT NULL,
    `slug_en` VARCHAR(100) NOT NULL,
    `slug_fr` VARCHAR(100) NOT NULL,
    `slug_nl` VARCHAR(100) NOT NULL,
    `slug_de` VARCHAR(100) NOT NULL,
    `price` DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    `downloads` INTEGER NOT NULL DEFAULT -1,
    `categories` VARCHAR(60) NULL DEFAULT '0',
    `membership_id` VARCHAR(20) NULL DEFAULT '0',
    `body_en` TEXT NULL,
    `body_fr` TEXT NULL,
    `body_nl` TEXT NULL,
    `body_de` TEXT NULL,
    `keywords_en` VARCHAR(200) NULL,
    `keywords_fr` VARCHAR(200) NULL,
    `keywords_nl` VARCHAR(200) NULL,
    `keywords_de` VARCHAR(200) NULL,
    `description_en` TEXT NULL,
    `description_fr` TEXT NULL,
    `description_nl` TEXT NULL,
    `description_de` TEXT NULL,
    `likes` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `thumb` VARCHAR(40) NULL,
    `poster` VARCHAR(40) NULL,
    `images` BLOB NULL,
    `file` VARCHAR(40) NULL,
    `token` VARCHAR(60) NULL,
    `created` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `active` BOOLEAN NOT NULL DEFAULT true,

    INDEX `idx_cat_id`(`category_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mod_digishop_cart` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` VARCHAR(64) NOT NULL DEFAULT '0',
    `pid` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `tax` DECIMAL(13, 2) NOT NULL DEFAULT 0.00,
    `totaltax` DECIMAL(13, 2) NOT NULL DEFAULT 0.00,
    `coupon` DECIMAL(13, 2) NOT NULL DEFAULT 0.00,
    `total` DECIMAL(13, 2) NOT NULL DEFAULT 0.00,
    `originalprice` DECIMAL(13, 2) NOT NULL DEFAULT 0.00,
    `totalprice` DECIMAL(13, 2) NOT NULL DEFAULT 0.00,
    `cart_id` VARCHAR(100) NULL,
    `order_id` VARCHAR(100) NULL,
    `created` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `idx_product`(`pid`),
    INDEX `idx_user`(`uid`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mod_digishop_categories` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `parent_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `name_en` VARCHAR(100) NOT NULL,
    `name_fr` VARCHAR(100) NOT NULL,
    `slug_en` VARCHAR(60) NOT NULL,
    `slug_fr` VARCHAR(100) NOT NULL,
    `keywords_en` VARCHAR(120) NULL,
    `keywords_fr` VARCHAR(200) NULL,
    `description_en` TEXT NULL,
    `description_fr` TEXT NULL,
    `sorting` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `active` BOOLEAN NOT NULL DEFAULT true,

    INDEX `idx_parent_id`(`parent_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mod_digishop_gallery` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `parent_id` INTEGER NOT NULL DEFAULT 0,
    `name` VARCHAR(60) NULL,
    `sorting` INTEGER UNSIGNED NOT NULL DEFAULT 0,

    INDEX `idx_parent_id`(`parent_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mod_digishop_payments` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `item_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `downloads` INTEGER NOT NULL DEFAULT -1,
    `txn_id` VARCHAR(80) NULL,
    `coupon` DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    `tax` DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    `amount` DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    `total` DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    `token` VARCHAR(80) NULL,
    `pp` VARCHAR(50) NULL,
    `currency` VARCHAR(6) NULL,
    `ip` VARBINARY(16) NULL,
    `status` BOOLEAN NOT NULL DEFAULT false,
    `created` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `idx_item_id`(`item_id`),
    INDEX `idx_user_id`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mod_digishop_related_categories` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `item_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `category_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,

    INDEX `idx_cat_id`(`category_id`),
    INDEX `idx_item_id`(`item_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mod_events` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `title_en` VARCHAR(100) NOT NULL,
    `title_de` VARCHAR(100) NOT NULL,
    `title_nl` VARCHAR(100) NOT NULL,
    `title_fr` VARCHAR(100) NOT NULL,
    `venue_en` VARCHAR(100) NULL,
    `venue_de` VARCHAR(100) NULL,
    `venue_nl` VARCHAR(100) NULL,
    `venue_fr` VARCHAR(100) NULL,
    `date_start` DATE NULL,
    `date_end` DATE NULL,
    `time_start` TIME(0) NULL,
    `time_end` TIME(0) NULL,
    `body_en` TEXT NULL,
    `body_de` TEXT NULL,
    `body_nl` TEXT NULL,
    `body_fr` TEXT NULL,
    `contact_person` VARCHAR(100) NULL,
    `contact_email` VARCHAR(80) NULL,
    `contact_phone` VARCHAR(24) NULL,
    `color` VARCHAR(7) NULL,
    `active` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mod_faq` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `category_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `question_en` VARCHAR(150) NULL,
    `question_de` VARCHAR(100) NOT NULL,
    `question_nl` VARCHAR(100) NOT NULL,
    `question_fr` VARCHAR(100) NOT NULL,
    `answer_en` TEXT NULL,
    `answer_de` TEXT NULL,
    `answer_nl` TEXT NULL,
    `answer_fr` TEXT NULL,
    `sorting` INTEGER UNSIGNED NOT NULL DEFAULT 0,

    INDEX `ixd_category`(`category_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mod_faq_categories` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name_en` VARCHAR(50) NOT NULL,
    `name_de` VARCHAR(50) NOT NULL,
    `name_nl` VARCHAR(50) NOT NULL,
    `name_fr` VARCHAR(50) NOT NULL,
    `sorting` INTEGER UNSIGNED NOT NULL DEFAULT 0,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mod_gallery` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `title_en` VARCHAR(60) NOT NULL,
    `title_de` VARCHAR(60) NOT NULL,
    `title_nl` VARCHAR(60) NOT NULL,
    `title_fr` VARCHAR(60) NOT NULL,
    `slug_en` VARCHAR(100) NULL,
    `slug_de` VARCHAR(100) NOT NULL,
    `slug_nl` VARCHAR(100) NOT NULL,
    `slug_fr` VARCHAR(100) NOT NULL,
    `description_en` VARCHAR(100) NULL,
    `description_de` VARCHAR(100) NULL,
    `description_nl` VARCHAR(100) NULL,
    `description_fr` VARCHAR(100) NULL,
    `thumb_w` SMALLINT UNSIGNED NULL DEFAULT 500,
    `thumb_h` SMALLINT UNSIGNED NOT NULL DEFAULT 500,
    `poster` VARCHAR(60) NULL,
    `cols` SMALLINT UNSIGNED NOT NULL DEFAULT 300,
    `dir` VARCHAR(40) NOT NULL,
    `resize` VARCHAR(30) NULL,
    `watermark` BOOLEAN NOT NULL DEFAULT false,
    `likes` BOOLEAN NOT NULL DEFAULT false,
    `sorting` INTEGER UNSIGNED NOT NULL DEFAULT 0,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mod_gallery_data` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `parent_id` INTEGER NOT NULL DEFAULT 0,
    `title_en` VARCHAR(80) NOT NULL,
    `title_de` VARCHAR(80) NOT NULL,
    `title_nl` VARCHAR(80) NOT NULL,
    `title_fr` VARCHAR(80) NOT NULL,
    `description_en` VARCHAR(200) NULL,
    `description_de` VARCHAR(200) NULL,
    `description_nl` VARCHAR(200) NULL,
    `description_fr` VARCHAR(200) NULL,
    `thumb` VARCHAR(80) NULL,
    `likes` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `sorting` INTEGER UNSIGNED NOT NULL DEFAULT 0,

    INDEX `idx_parent_id`(`parent_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mod_gmaps` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(60) NOT NULL,
    `plugin_id` VARCHAR(40) NULL,
    `lat` DECIMAL(10, 6) NOT NULL DEFAULT 0.000000,
    `lng` DECIMAL(10, 6) NOT NULL DEFAULT 0.000000,
    `body` TINYTEXT NULL,
    `zoom` TINYINT UNSIGNED NOT NULL DEFAULT 12,
    `minmaxzoom` VARCHAR(5) NULL,
    `layout` VARCHAR(50) NULL,
    `type` VARCHAR(10) NULL,
    `type_control` BOOLEAN NOT NULL DEFAULT false,
    `streetview` BOOLEAN NOT NULL DEFAULT true,
    `style` BLOB NULL,
    `pin` VARCHAR(30) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mod_timeline` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NULL,
    `plugin_id` VARCHAR(25) NULL,
    `type` VARCHAR(20) NULL,
    `limiter` TINYINT UNSIGNED NOT NULL DEFAULT 10,
    `showmore` BOOLEAN NOT NULL DEFAULT false,
    `maxitems` BOOLEAN NOT NULL DEFAULT false,
    `colmode` VARCHAR(20) NULL DEFAULT 'dual',
    `readmore` VARCHAR(150) NULL,
    `rssurl` VARCHAR(200) NULL,
    `fbid` VARCHAR(150) NULL,
    `fbpage` VARCHAR(150) NULL,
    `fbtoken` VARCHAR(150) NULL,
    `created` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mod_timeline_data` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `tid` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `type` VARCHAR(30) NULL,
    `title_en` VARCHAR(100) NULL,
    `title_de` VARCHAR(100) NOT NULL,
    `title_nl` VARCHAR(100) NOT NULL,
    `title_fr` VARCHAR(100) NOT NULL,
    `body_en` TEXT NULL,
    `body_de` TEXT NULL,
    `body_nl` TEXT NULL,
    `body_fr` TEXT NULL,
    `images` BLOB NULL,
    `dataurl` VARCHAR(250) NULL,
    `height` SMALLINT UNSIGNED NOT NULL DEFAULT 300,
    `readmore` VARCHAR(200) NULL,
    `created` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `tid`(`tid`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `modules` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `title_en` VARCHAR(120) NOT NULL,
    `title_de` VARCHAR(120) NOT NULL,
    `title_nl` VARCHAR(120) NOT NULL,
    `title_fr` VARCHAR(120) NOT NULL,
    `info_en` VARCHAR(200) NULL,
    `info_de` VARCHAR(200) NULL,
    `info_nl` VARCHAR(200) NULL,
    `info_fr` VARCHAR(200) NULL,
    `modalias` VARCHAR(60) NOT NULL,
    `hasconfig` BOOLEAN NOT NULL DEFAULT false,
    `hascoupon` BOOLEAN NOT NULL DEFAULT false,
    `hasfields` BOOLEAN NOT NULL DEFAULT false,
    `system` BOOLEAN NOT NULL DEFAULT false,
    `content` BOOLEAN NOT NULL DEFAULT false,
    `parent_id` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    `is_menu` BOOLEAN NOT NULL DEFAULT false,
    `is_builder` BOOLEAN NOT NULL DEFAULT false,
    `keywords_en` VARCHAR(200) NULL,
    `keywords_de` VARCHAR(200) NULL,
    `keywords_nl` VARCHAR(200) NULL,
    `keywords_fr` VARCHAR(200) NULL,
    `description_en` TEXT NULL,
    `description_de` TEXT NULL,
    `description_nl` TEXT NULL,
    `description_fr` TEXT NULL,
    `icon` VARCHAR(50) NULL,
    `ver` DECIMAL(4, 2) NOT NULL DEFAULT 1.00,
    `created` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `active` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pages` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `title_en` VARCHAR(200) NOT NULL,
    `title_de` VARCHAR(200) NOT NULL,
    `title_nl` VARCHAR(200) NOT NULL,
    `title_fr` VARCHAR(200) NOT NULL,
    `slug_en` VARCHAR(150) NULL,
    `slug_de` VARCHAR(200) NULL,
    `slug_nl` VARCHAR(200) NULL,
    `slug_fr` VARCHAR(200) NULL,
    `caption_en` VARCHAR(150) NULL,
    `caption_de` VARCHAR(150) NULL,
    `caption_nl` VARCHAR(150) NULL,
    `caption_fr` VARCHAR(150) NULL,
    `is_admin` BOOLEAN NOT NULL DEFAULT true,
    `page_type` ENUM('normal', 'home', 'contact', 'login', 'activate', 'account', 'register', 'search', 'sitemap', 'profile', 'policy') NOT NULL DEFAULT 'normal',
    `membership_id` VARCHAR(20) NOT NULL DEFAULT '0',
    `is_comments` BOOLEAN NOT NULL DEFAULT false,
    `custom_bg_en` VARCHAR(100) NULL,
    `custom_bg_de` VARCHAR(100) NULL,
    `custom_bg_nl` VARCHAR(100) NULL,
    `custom_bg_fr` VARCHAR(100) NULL,
    `show_header` BOOLEAN NOT NULL DEFAULT true,
    `theme` VARCHAR(60) NULL,
    `access` ENUM('Public', 'Registered', 'Membership') NOT NULL DEFAULT 'Public',
    `body_en` TEXT NULL,
    `body_de` TEXT NULL,
    `body_nl` TEXT NULL,
    `body_fr` TEXT NULL,
    `jscode` TEXT NULL,
    `keywords_en` VARCHAR(200) NULL,
    `keywords_de` VARCHAR(200) NULL,
    `keywords_nl` VARCHAR(200) NULL,
    `keywords_fr` VARCHAR(200) NULL,
    `description_en` TEXT NULL,
    `description_de` TEXT NULL,
    `description_nl` TEXT NULL,
    `description_fr` TEXT NULL,
    `created` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `created_by` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `created_by_name` VARCHAR(80) NULL,
    `is_system` BOOLEAN NOT NULL DEFAULT false,
    `active` BOOLEAN NOT NULL DEFAULT true,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `payments` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `txn_id` VARCHAR(50) NULL,
    `membership_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `user_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `rate_amount` DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    `tax` DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    `coupon` DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    `total` DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    `currency` VARCHAR(4) NULL,
    `pp` VARCHAR(20) NOT NULL DEFAULT 'Stripe',
    `ip` VARBINARY(16) NULL,
    `created` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `status` BOOLEAN NOT NULL DEFAULT false,

    INDEX `idx_membership`(`membership_id`),
    INDEX `idx_user`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plug_carousel` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `title_en` VARCHAR(100) NOT NULL,
    `title_de` VARCHAR(100) NOT NULL,
    `title_nl` VARCHAR(100) NOT NULL,
    `title_fr` VARCHAR(100) NOT NULL,
    `body_en` TEXT NULL,
    `body_de` TEXT NULL,
    `body_nl` TEXT NULL,
    `body_fr` TEXT NULL,
    `dots` BOOLEAN NOT NULL DEFAULT false,
    `nav` BOOLEAN NOT NULL DEFAULT false,
    `autoplay` BOOLEAN NOT NULL DEFAULT false,
    `margin` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    `loop` BOOLEAN NOT NULL DEFAULT false,
    `settings` BLOB NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plug_donation` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(80) NULL,
    `target_amount` DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    `pp_email` VARCHAR(80) NOT NULL,
    `redirect_page` INTEGER UNSIGNED NOT NULL DEFAULT 0,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plug_donation_data` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `parent_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `amount` DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    `name` VARCHAR(80) NULL,
    `email` VARCHAR(60) NULL,
    `pp` VARCHAR(50) NULL,
    `created` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `idx_parent_id`(`parent_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plug_newsletter` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(100) NULL,
    `created` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plug_poll_options` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `question_id` INTEGER UNSIGNED NOT NULL,
    `value` VARCHAR(150) NOT NULL,
    `position` TINYINT UNSIGNED NOT NULL DEFAULT 0,

    INDEX `idx_question`(`question_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plug_poll_questions` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `question` VARCHAR(150) NOT NULL,
    `created` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `status` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plug_poll_votes` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `option_id` INTEGER UNSIGNED NOT NULL,
    `voted_on` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `ip` VARBINARY(16) NULL,

    INDEX `idx_option`(`option_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plug_rss` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(50) NOT NULL,
    `url` VARCHAR(120) NOT NULL,
    `items` BOOLEAN NOT NULL DEFAULT true,
    `show_date` BOOLEAN NOT NULL DEFAULT true,
    `show_desc` BOOLEAN NOT NULL DEFAULT true,
    `max_words` SMALLINT UNSIGNED NOT NULL DEFAULT 100,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plug_slider` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(80) NOT NULL,
    `type` VARCHAR(15) NULL,
    `layout` VARCHAR(25) NULL,
    `autoplay` BOOLEAN NOT NULL DEFAULT false,
    `autoplaySpeed` SMALLINT UNSIGNED NOT NULL DEFAULT 1000,
    `autoplayHoverPause` BOOLEAN NOT NULL DEFAULT true,
    `autoloop` BOOLEAN NOT NULL DEFAULT true,
    `height` SMALLINT UNSIGNED NOT NULL DEFAULT 100,
    `fullscreen` BOOLEAN NOT NULL DEFAULT false,
    `settings` BLOB NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plug_slider_data` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `parent_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `title` VARCHAR(50) NOT NULL,
    `html_raw` TEXT NULL,
    `html` TEXT NULL,
    `image` VARCHAR(60) NULL,
    `color` VARCHAR(30) NULL,
    `attrib` VARCHAR(60) NULL,
    `mode` VARCHAR(2) NOT NULL DEFAULT 'bg',
    `sorting` INTEGER UNSIGNED NOT NULL DEFAULT 0,

    INDEX `idx_parent`(`parent_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plug_yplayer` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(50) NULL,
    `layout` VARCHAR(10) NULL,
    `config` BLOB NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plugins` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `title_en` VARCHAR(120) NOT NULL,
    `title_de` VARCHAR(120) NOT NULL,
    `title_nl` VARCHAR(120) NOT NULL,
    `title_fr` VARCHAR(120) NOT NULL,
    `body_en` TEXT NULL,
    `body_de` TEXT NULL,
    `body_nl` TEXT NULL,
    `body_fr` TEXT NULL,
    `jscode` TEXT NULL,
    `show_title` BOOLEAN NOT NULL DEFAULT false,
    `alt_class` VARCHAR(30) NULL,
    `system` BOOLEAN NOT NULL DEFAULT true,
    `cplugin` BOOLEAN NOT NULL DEFAULT false,
    `info_en` VARCHAR(150) NULL,
    `info_de` VARCHAR(150) NULL,
    `info_nl` VARCHAR(150) NULL,
    `info_fr` VARCHAR(150) NULL,
    `plugalias` VARCHAR(50) NULL,
    `hasconfig` BOOLEAN NOT NULL DEFAULT false,
    `multi` BOOLEAN NOT NULL DEFAULT false,
    `parent_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `plugin_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `groups` VARCHAR(20) NULL,
    `created` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `icon` VARCHAR(60) NULL,
    `ver` DECIMAL(4, 2) NOT NULL DEFAULT 1.00,
    `active` BOOLEAN NOT NULL DEFAULT false,

    INDEX `idx_plugin_id`(`plugin_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `privileges` (
    `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(20) NOT NULL,
    `name` VARCHAR(30) NOT NULL,
    `description` VARCHAR(60) NULL,
    `mode` VARCHAR(8) NOT NULL,
    `type` VARCHAR(40) NULL,

    UNIQUE INDEX `name`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `role_privileges` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `rid` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `pid` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `active` BOOLEAN NOT NULL DEFAULT true,

    INDEX `idx`(`rid`, `pid`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `roles` (
    `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(10) NOT NULL,
    `icon` VARCHAR(20) NULL,
    `name` VARCHAR(30) NOT NULL,
    `description` VARCHAR(200) NOT NULL,

    UNIQUE INDEX `name`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `settings` (
    `id` BOOLEAN NOT NULL,
    `site_name` VARCHAR(100) NOT NULL,
    `company` VARCHAR(100) NOT NULL,
    `site_dir` VARCHAR(50) NULL,
    `site_email` VARCHAR(50) NOT NULL,
    `theme` VARCHAR(32) NOT NULL,
    `perpage` TINYINT UNSIGNED NOT NULL,
    `backup` VARCHAR(64) NOT NULL,
    `thumb_w` TINYINT UNSIGNED NOT NULL,
    `thumb_h` TINYINT UNSIGNED NOT NULL,
    `img_w` SMALLINT UNSIGNED NOT NULL,
    `img_h` SMALLINT UNSIGNED NOT NULL,
    `avatar_w` TINYINT UNSIGNED NOT NULL,
    `avatar_h` TINYINT UNSIGNED NOT NULL,
    `short_date` VARCHAR(20) NOT NULL,
    `long_date` VARCHAR(30) NOT NULL,
    `time_format` VARCHAR(10) NULL,
    `calendar_date` VARCHAR(30) NULL,
    `dtz` VARCHAR(120) NULL,
    `locale` VARCHAR(200) NULL,
    `weekstart` BOOLEAN NOT NULL DEFAULT true,
    `lang` VARCHAR(2) NOT NULL DEFAULT 'en',
    `lang_list` BLOB NOT NULL,
    `ploader` BOOLEAN NOT NULL DEFAULT true,
    `eucookie` BOOLEAN NOT NULL DEFAULT false,
    `offline` BOOLEAN NOT NULL DEFAULT false,
    `offline_msg` TEXT NULL,
    `offline_d` DATE NULL,
    `offline_t` TIME(0) NULL,
    `offline_info` TEXT NULL,
    `logo` VARCHAR(50) NULL,
    `plogo` VARCHAR(50) NULL,
    `showlang` BOOLEAN NOT NULL DEFAULT false,
    `showlogin` BOOLEAN NOT NULL DEFAULT true,
    `showsearch` BOOLEAN NOT NULL DEFAULT true,
    `showcrumbs` BOOLEAN NOT NULL DEFAULT true,
    `currency` VARCHAR(4) NULL,
    `enable_tax` BOOLEAN NOT NULL DEFAULT true,
    `file_size` INTEGER UNSIGNED NOT NULL DEFAULT 20971520,
    `file_ext` VARCHAR(150) NOT NULL DEFAULT 'png,jpg,jpeg,bmp',
    `reg_verify` BOOLEAN NOT NULL DEFAULT true,
    `auto_verify` BOOLEAN NOT NULL DEFAULT true,
    `notify_admin` BOOLEAN NOT NULL DEFAULT false,
    `flood` INTEGER UNSIGNED NOT NULL DEFAULT 3600,
    `attempt` BOOLEAN NOT NULL DEFAULT false,
    `logging` BOOLEAN NOT NULL DEFAULT false,
    `analytics` VARCHAR(100) NULL,
    `mailer` VARCHAR(8) NOT NULL DEFAULT 'SMTP',
    `sendmail` VARCHAR(60) NULL,
    `smtp_host` VARCHAR(150) NULL,
    `smtp_user` VARCHAR(50) NULL,
    `smtp_pass` VARCHAR(50) NULL,
    `smtp_port` VARCHAR(3) NULL,
    `is_ssl` BOOLEAN NOT NULL DEFAULT false,
    `inv_info` TEXT NULL,
    `inv_note` TEXT NULL,
    `system_slugs` BLOB NULL,
    `url_slugs` BLOB NULL,
    `social_media` BLOB NULL,
    `ytapi` VARCHAR(120) NULL,
    `mapapi` VARCHAR(120) NULL,
    `wojon` DECIMAL(4, 2) NOT NULL DEFAULT 0.00,
    `wojov` DECIMAL(4, 2) NOT NULL DEFAULT 0.00,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `stats` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `day` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `pageviews` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `uniquevisitors` INTEGER UNSIGNED NOT NULL DEFAULT 0,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `trash` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `parent` VARCHAR(15) NULL,
    `parent_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `type` VARCHAR(15) NULL,
    `dataset` BLOB NULL,
    `created` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_memberships` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `tid` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `uid` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `mid` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `activated` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `expire` TIMESTAMP(0) NULL,
    `recurring` BOOLEAN NOT NULL DEFAULT false,
    `active` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(50) NOT NULL,
    `fname` VARCHAR(32) NOT NULL,
    `lname` VARCHAR(32) NOT NULL,
    `email` VARCHAR(60) NOT NULL,
    `membership_id` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `mem_expire` DATETIME(0) NULL,
    `trial_used` BOOLEAN NOT NULL DEFAULT false,
    `memused` BOOLEAN NOT NULL DEFAULT false,
    `salt` VARCHAR(25) NOT NULL,
    `hash` VARCHAR(70) NOT NULL,
    `password` VARCHAR(50) NOT NULL,
    `token` VARCHAR(40) NOT NULL DEFAULT '0',
    `userlevel` BOOLEAN NOT NULL DEFAULT true,
    `type` VARCHAR(10) NOT NULL DEFAULT 'member',
    `created` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `lastlogin` DATETIME(0) NULL,
    `lastip` VARBINARY(16) NULL,
    `avatar` VARCHAR(50) NULL,
    `address` VARCHAR(100) NULL,
    `city` VARCHAR(50) NULL,
    `state` VARCHAR(50) NULL,
    `zip` VARCHAR(10) NULL,
    `country` VARCHAR(4) NULL,
    `notify` BOOLEAN NOT NULL DEFAULT false,
    `access` TEXT NULL,
    `notes` TINYTEXT NULL,
    `info` TINYTEXT NULL,
    `fb_link` VARCHAR(100) NULL,
    `tw_link` VARCHAR(100) NULL,
    `gp_link` VARCHAR(100) NULL,
    `newsletter` BOOLEAN NOT NULL DEFAULT true,
    `stripe_cus` VARCHAR(100) NULL,
    `modaccess` VARCHAR(150) NULL,
    `plugaccess` VARCHAR(150) NULL,
    `active` ENUM('y', 'n', 't', 'b') NOT NULL DEFAULT 'n',

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `app_scene_info` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` INTEGER UNSIGNED NOT NULL,
    `name` VARCHAR(200) NOT NULL,
    `character` TEXT NOT NULL,
    `character_transform` TEXT NOT NULL,
    `character_material` TEXT NOT NULL,
    `object` TEXT NOT NULL,
    `object_transform` TEXT NOT NULL,
    `field` TEXT NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
