DROP TABLE IF EXISTS `Widget`;
CREATE TABLE `Widget` (
  `widgetId` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `widgetTypeId` int(11) NOT NULL,
  `isActive` tinyint(1) NOT NULL,
  PRIMARY KEY  (`widgetId`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `WidgetCategory`;
CREATE TABLE `WidgetCategory` (
  `WidgetCategoryId` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY  (`WidgetCategoryId`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `WidgetType`;
CREATE TABLE `WidgetType` (
  `WidgetTypeId` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY  (`WidgetTypeId`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `Widget_WidgetCategory`;
CREATE TABLE `Widget_WidgetCategory` (
  `WidgetWidgetCategoryId` int(11) NOT NULL auto_increment,
  `WidgetId` int(11) NOT NULL,
  `WidgetCategoryId` int(11) NOT NULL,
  PRIMARY KEY  (`WidgetWidgetCategoryId`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
