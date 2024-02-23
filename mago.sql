-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mago
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mago
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mago` DEFAULT CHARACTER SET utf8 ;
USE `mago` ;

-- -----------------------------------------------------
-- Table `mago`.`municipalities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mago`.`municipalities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mago`.`departaments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mago`.`departaments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `municipalities_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_departament_municipalities1_idx` (`municipalities_id` ASC) VISIBLE,
  CONSTRAINT `fk_departament_municipalities1`
    FOREIGN KEY (`municipalities_id`)
    REFERENCES `mago`.`municipalities` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mago`.`routes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mago`.`routes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `route_name` VARCHAR(45) NOT NULL,
  `departament_id` INT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_routes_departament1_idx` (`departament_id` ASC) VISIBLE,
  CONSTRAINT `fk_routes_departament1`
    FOREIGN KEY (`departament_id`)
    REFERENCES `mago`.`departaments` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mago`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mago`.`customers` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(45) NOT NULL,
  `company_name` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `cell_phone` INT NOT NULL,
  `mail` VARCHAR(60) NULL DEFAULT NULL,
  `routes_id` INT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customers_routes1_idx` (`routes_id` ASC) VISIBLE,
  CONSTRAINT `fk_customers_routes1`
    FOREIGN KEY (`routes_id`)
    REFERENCES `mago`.`routes` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mago`.`suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mago`.`suppliers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nit` VARCHAR(45) NOT NULL,
  `supplier_name` VARCHAR(45) NOT NULL,
  `cell_phone` INT NOT NULL,
  `mail` VARCHAR(45) NULL DEFAULT NULL,
  `address` VARCHAR(45) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mago`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mago`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(45) NOT NULL,
  `brand` VARCHAR(45) NOT NULL,
  `unit_of_measurement` VARCHAR(45) NOT NULL,
  `suppliers_id` INT NOT NULL,
  `created_at` VARCHAR(45) NULL DEFAULT NULL,
  `updated_at` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`product_name` ASC) VISIBLE,
  INDEX `fk_products_suppliers1_idx` (`suppliers_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_suppliers1`
    FOREIGN KEY (`suppliers_id`)
    REFERENCES `mago`.`suppliers` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mago`.`purchases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mago`.`purchases` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `suppliers_id` INT NOT NULL,
  `date` DATE NOT NULL,
  `total_value` VARCHAR(45) NOT NULL,
  `num_bill` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_purchases_suppliers1_idx` (`suppliers_id` ASC) VISIBLE,
  CONSTRAINT `fk_purchases_suppliers1`
    FOREIGN KEY (`suppliers_id`)
    REFERENCES `mago`.`suppliers` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mago`.`details_purchases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mago`.`details_purchases` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `products_id` INT NOT NULL,
  `purchase_lot` VARCHAR(45) NOT NULL,
  `amount` VARCHAR(45) NOT NULL,
  `unit_value` VARCHAR(45) NOT NULL,
  `purchases_id` INT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_details_purchases_products1_idx` (`products_id` ASC) VISIBLE,
  INDEX `fk_details_purchases_purchases1_idx` (`purchases_id` ASC) VISIBLE,
  CONSTRAINT `fk_details_purchases_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `mago`.`products` (`id`),
  CONSTRAINT `fk_details_purchases_purchases1`
    FOREIGN KEY (`purchases_id`)
    REFERENCES `mago`.`purchases` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mago`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mago`.`sales` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `customers_id` INT UNSIGNED NOT NULL,
  `price_total` VARCHAR(45) NOT NULL,
  `payment_method` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sales_customers1_idx` (`customers_id` ASC) VISIBLE,
  CONSTRAINT `fk_sales_customers1`
    FOREIGN KEY (`customers_id`)
    REFERENCES `mago`.`customers` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mago`.`details_sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mago`.`details_sale` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `products_id` INT NOT NULL,
  `price_unit` VARCHAR(45) NOT NULL,
  `amount` INT NOT NULL,
  `discount` VARCHAR(45) NOT NULL,
  `sales_id` INT UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_details_sale_products1_idx` (`products_id` ASC) VISIBLE,
  INDEX `fk_details_sale_sales1_idx` (`sales_id` ASC) VISIBLE,
  CONSTRAINT `fk_details_sale_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `mago`.`products` (`id`),
  CONSTRAINT `fk_details_sale_sales1`
    FOREIGN KEY (`sales_id`)
    REFERENCES `mago`.`sales` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mago`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mago`.`users` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `email_verified_at` TIMESTAMP NULL DEFAULT NULL,
  `password` VARCHAR(255) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `remember_token` VARCHAR(100) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `users_email_unique` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mago`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mago`.`employees` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `users_id` BIGINT UNSIGNED NOT NULL,
  `gender` VARCHAR(45) NOT NULL,
  `civil_status` VARCHAR(45) NOT NULL,
  `routes_id` INT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_employees_routes1_idx` (`routes_id` ASC) VISIBLE,
  INDEX `fk_employees_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_employees_routes1`
    FOREIGN KEY (`routes_id`)
    REFERENCES `mago`.`routes` (`id`),
  CONSTRAINT `fk_employees_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `mago`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mago`.`failed_jobs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mago`.`failed_jobs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(255) NOT NULL,
  `connection` TEXT NOT NULL,
  `queue` TEXT NOT NULL,
  `payload` LONGTEXT NOT NULL,
  `exception` LONGTEXT NOT NULL,
  `failed_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `failed_jobs_uuid_unique` (`uuid` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mago`.`load`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mago`.`load` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `products_id` INT NOT NULL,
  `amount` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_load_products1_idx` (`products_id` ASC) VISIBLE,
  CONSTRAINT `fk_load_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `mago`.`products` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mago`.`migrations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mago`.`migrations` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` VARCHAR(255) NOT NULL,
  `batch` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mago`.`password_reset_tokens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mago`.`password_reset_tokens` (
  `email` VARCHAR(255) NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`email`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mago`.`password_resets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mago`.`password_resets` (
  `email` VARCHAR(255) NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  INDEX `password_resets_email_index` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mago`.`personal_access_tokens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mago`.`personal_access_tokens` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` VARCHAR(255) NOT NULL,
  `tokenable_id` BIGINT UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `token` VARCHAR(64) NOT NULL,
  `abilities` TEXT NULL DEFAULT NULL,
  `last_used_at` TIMESTAMP NULL DEFAULT NULL,
  `expires_at` TIMESTAMP NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `personal_access_tokens_token_unique` (`token` ASC) VISIBLE,
  INDEX `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type` ASC, `tokenable_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mago`.`truck_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mago`.`truck_types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `plate` VARCHAR(10) NOT NULL,
  `ability` VARCHAR(45) NOT NULL,
  `routes_id` INT NOT NULL,
  `load_id` INT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_truck_type_routes1_idx` (`routes_id` ASC) VISIBLE,
  INDEX `fk_truck_type_load1_idx` (`load_id` ASC) VISIBLE,
  CONSTRAINT `fk_truck_type_load1`
    FOREIGN KEY (`load_id`)
    REFERENCES `mago`.`load` (`id`),
  CONSTRAINT `fk_truck_type_routes1`
    FOREIGN KEY (`routes_id`)
    REFERENCES `mago`.`routes` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
