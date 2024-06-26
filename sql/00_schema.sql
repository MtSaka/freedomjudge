DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `display_name` VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL,
    `passhash` VARCHAR(255) NOT NULL,
    UNIQUE `uniq_user_name` (`name`)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

DROP TABLE IF EXISTS `teams`;
CREATE TABLE `teams` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `display_name` VARCHAR(255) NOT NULL,
    `leader_id` INT NOT NULL,
    `member1_id` INT DEFAULT -1 NOT NULL,
    `member2_id` INT DEFAULT -1 NOT NULL,
    `description` TEXT NOT NULL,
    `invitation_code` VARCHAR(255) NOT NULL,
    UNIQUE `uniq_team_name` (`name`)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `display_name` VARCHAR(255) NOT NULL,
    `statement` TEXT NOT NULL,
    `submission_limit` INT NOT NULL,
    UNIQUE `uniq_task_name` (`name`)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

DROP TABLE IF EXISTS `subtasks`;
CREATE TABLE `subtasks` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `display_name` VARCHAR(255) NOT NULL,
    `task_id` INT NOT NULL,
    `statement` TEXT NOT NULL,
    UNIQUE `uniq_question` (`task_id`, `name`)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE INDEX `sub_idx` ON `subtasks` (`task_id`);

DROP TABLE IF EXISTS `answers`;
CREATE TABLE `answers` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `task_id` INT NOT NULL,
    `subtask_id` INT NOT NULL,
    `answer` VARCHAR(255) NOT NULL,
    `score` INT NOT NULL,
    UNIQUE `uniq_answer` (`task_id`, `answer`)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE INDEX `ans_idx` ON `answers` (`subtask_id`);

DROP TABLE IF EXISTS `submissions`;
CREATE TABLE `submissions` (
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `task_id` INT NOT NULL,
    `user_id` INT NOT NULL,
    `submitted_at` DATETIME NOT NULL,
    `answer` VARCHAR(255) NOT NULL,
    `subtask_id` INT NOT NULL DEFAULT -1,
    `score` INT NOT NULL DEFAULT 0
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

CREATE INDEX `sub_idx` ON `submissions` (`task_id`, `user_id`, `answer`);
CREATE INDEX `sub_idx2` ON `submissions` (`subtask_id`, `user_id`);
CREATE INDEX `sub_idx3` ON `submissions` (`task_id`, `user_id`, `subtask_id`, `score` DESC);
