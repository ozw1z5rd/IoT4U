CREATE TABLE `telemetry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `topic` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `uptime` varchar(20) DEFAULT NULL,
  `uptimesec` bigint(20) DEFAULT NULL,
  `vcc` float DEFAULT NULL,
  `heap` int(11) DEFAULT NULL,
  `sleepMode` varchar(20) DEFAULT NULL,
  `sleep` int(11) DEFAULT NULL,
  `loadAvg` int(11) DEFAULT NULL,
  `MqttCount` bigint(20) DEFAULT NULL,
  `Power` varchar(20) DEFAULT NULL,
  `wifiAp` int(11) DEFAULT NULL,
  `wifiSSId` varchar(64) DEFAULT NULL,
  `wifiBSSId` char(20) DEFAULT NULL,
  `wifiChannel` int(11) DEFAULT NULL,
  `wifiRSSI` varchar(64) DEFAULT NULL,
  `wifiSignal` int(11) DEFAULT NULL,
  `wifiLinkCount` int(11) DEFAULT NULL,
  `wifiDowntime` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;


CREATE TABLE `event` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `topic` varchar(255) DEFAULT NULL,
  `payload` varchar(1024) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;


