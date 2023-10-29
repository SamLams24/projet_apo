-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 29 oct. 2023 à 02:50
-- Version du serveur : 10.4.27-MariaDB
-- Version de PHP : 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `testappli_1`
--

-- --------------------------------------------------------

--
-- Structure de la table `categoriecli`
--

CREATE TABLE `categoriecli` (
  `num_categorieCli` tinyint(3) UNSIGNED NOT NULL,
  `libelle_categorieCli` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `chambre`
--

CREATE TABLE `chambre` (
  `num_chambre` tinyint(4) UNSIGNED NOT NULL,
  `surface_chambre` varchar(15) NOT NULL,
  `type_chambre` varchar(20) NOT NULL,
  `situation_chambre` varchar(80) NOT NULL,
  `caracteristiques_chambre` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE `client` (
  `num_client` tinyint(4) UNSIGNED NOT NULL,
  `nom_client` varchar(30) NOT NULL,
  `prenom_client` varchar(30) NOT NULL,
  `etranger_client` tinyint(1) NOT NULL,
  `carteFidelite_client` tinyint(1) NOT NULL,
  `num_categorieCli` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `concerne`
--

CREATE TABLE `concerne` (
  `num_chambre` tinyint(3) UNSIGNED NOT NULL,
  `num_reservation` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `date`
--

CREATE TABLE `date` (
  `dateReserv` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `facture`
--

CREATE TABLE `facture` (
  `num_facture` tinyint(4) UNSIGNED NOT NULL,
  `modePayem_facture` enum('Espèces','Carte de crédit','Chèque') DEFAULT NULL,
  `dateDepart` date DEFAULT NULL,
  `heureDepart` time DEFAULT NULL,
  `remise_facture` decimal(3,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `inclure`
--

CREATE TABLE `inclure` (
  `num_reservation` tinyint(3) UNSIGNED NOT NULL,
  `num_loisir` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `loisir`
--

CREATE TABLE `loisir` (
  `num_loisir` tinyint(3) UNSIGNED NOT NULL,
  `prixTotal_loisir` decimal(5,3) DEFAULT NULL,
  `dateHeure_loisir` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `accomptePaye_loisir` decimal(5,3) DEFAULT NULL,
  `resteaPaye_loisir` decimal(5,3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

CREATE TABLE `reservation` (
  `num_reservation` tinyint(3) UNSIGNED NOT NULL,
  `heure_reservation` time DEFAULT NULL,
  `dateHeure_arrivee` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `nombrePers_reservation` smallint(5) UNSIGNED DEFAULT NULL,
  `nombreChambr_reservation` smallint(5) UNSIGNED DEFAULT NULL,
  `etat_reservation` enum('Reservée','Confirmée','Annulée') DEFAULT NULL,
  `dureSejour_reservation` tinyint(3) UNSIGNED DEFAULT NULL,
  `num_client` tinyint(3) UNSIGNED NOT NULL,
  `dateReserv` date NOT NULL,
  `num_facture` tinyint(4) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `categoriecli`
--
ALTER TABLE `categoriecli`
  ADD PRIMARY KEY (`num_categorieCli`);

--
-- Index pour la table `chambre`
--
ALTER TABLE `chambre`
  ADD PRIMARY KEY (`num_chambre`);

--
-- Index pour la table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`num_client`),
  ADD KEY `Num_categorieCli` (`num_categorieCli`);

--
-- Index pour la table `concerne`
--
ALTER TABLE `concerne`
  ADD KEY `num_chambre` (`num_chambre`),
  ADD KEY `num_reservation` (`num_reservation`);

--
-- Index pour la table `date`
--
ALTER TABLE `date`
  ADD PRIMARY KEY (`dateReserv`);

--
-- Index pour la table `facture`
--
ALTER TABLE `facture`
  ADD PRIMARY KEY (`num_facture`);

--
-- Index pour la table `inclure`
--
ALTER TABLE `inclure`
  ADD KEY `num_loisir` (`num_loisir`),
  ADD KEY `num_reservation` (`num_reservation`);

--
-- Index pour la table `loisir`
--
ALTER TABLE `loisir`
  ADD PRIMARY KEY (`num_loisir`);

--
-- Index pour la table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`num_reservation`),
  ADD KEY `FK_reservation1` (`dateReserv`),
  ADD KEY `FK_reservation2` (`num_client`),
  ADD KEY `FK_reservation4` (`num_facture`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `chambre`
--
ALTER TABLE `chambre`
  MODIFY `num_chambre` tinyint(4) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `client`
--
ALTER TABLE `client`
  MODIFY `num_client` tinyint(4) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `facture`
--
ALTER TABLE `facture`
  MODIFY `num_facture` tinyint(4) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `loisir`
--
ALTER TABLE `loisir`
  MODIFY `num_loisir` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `num_reservation` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `client_ibfk_1` FOREIGN KEY (`num_categorieCli`) REFERENCES `categoriecli` (`num_categorieCli`);

--
-- Contraintes pour la table `concerne`
--
ALTER TABLE `concerne`
  ADD CONSTRAINT `concerne_ibfk_1` FOREIGN KEY (`num_chambre`) REFERENCES `chambre` (`num_chambre`),
  ADD CONSTRAINT `concerne_ibfk_2` FOREIGN KEY (`num_reservation`) REFERENCES `reservation` (`num_reservation`);

--
-- Contraintes pour la table `inclure`
--
ALTER TABLE `inclure`
  ADD CONSTRAINT `inclure_ibfk_1` FOREIGN KEY (`num_loisir`) REFERENCES `loisir` (`num_loisir`) ON UPDATE CASCADE,
  ADD CONSTRAINT `inclure_ibfk_2` FOREIGN KEY (`num_reservation`) REFERENCES `reservation` (`num_reservation`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `FK_reservation1` FOREIGN KEY (`dateReserv`) REFERENCES `date` (`dateReserv`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_reservation2` FOREIGN KEY (`num_client`) REFERENCES `client` (`num_client`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_reservation4` FOREIGN KEY (`num_facture`) REFERENCES `facture` (`num_facture`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
