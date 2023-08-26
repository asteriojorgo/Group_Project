-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema reddit_database
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema reddit_database
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `reddit_database` DEFAULT CHARACTER SET utf8 ;
USE `reddit_database` ;

-- -----------------------------------------------------
-- Table `reddit_database`.`subreddits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reddit_database`.`subreddits` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `subreddit_name` VARCHAR(25) NULL,
  `description` VARCHAR(255) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subreddits_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_subreddits_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `reddit_database`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reddit_database`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reddit_database`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(25) NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(256) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `subreddits_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_users_subreddits1_idx` (`subreddits_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_subreddits1`
    FOREIGN KEY (`subreddits_id`)
    REFERENCES `reddit_database`.`subreddits` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reddit_database`.`posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reddit_database`.`posts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NULL,
  `post_body` VARCHAR(8000) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `subreddits_id` INT NOT NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_posts_subreddits1_idx` (`subreddits_id` ASC) VISIBLE,
  INDEX `fk_posts_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_posts_subreddits1`
    FOREIGN KEY (`subreddits_id`)
    REFERENCES `reddit_database`.`subreddits` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_posts_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `reddit_database`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reddit_database`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reddit_database`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comment_body` VARCHAR(8000) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `users_id` INT NOT NULL,
  `posts_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comments_users_idx` (`users_id` ASC) VISIBLE,
  INDEX `fk_comments_posts1_idx` (`posts_id` ASC) VISIBLE,
  CONSTRAINT `fk_comments_users`
    FOREIGN KEY (`users_id`)
    REFERENCES `reddit_database`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_posts1`
    FOREIGN KEY (`posts_id`)
    REFERENCES `reddit_database`.`posts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reddit_database`.`post_votes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reddit_database`.`post_votes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `vote_type` TINYINT NULL,
  `posts_id` INT NOT NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_post_votes_posts1_idx` (`posts_id` ASC) VISIBLE,
  INDEX `fk_post_votes_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_post_votes_posts1`
    FOREIGN KEY (`posts_id`)
    REFERENCES `reddit_database`.`posts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_votes_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `reddit_database`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
