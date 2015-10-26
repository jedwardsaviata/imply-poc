name := "imply-sample-data"

version := "1.0.0"

scalaVersion := "2.11.6"

libraryDependencies += "io.druid" % "tranquility-core_2.11" % "0.6.3"
libraryDependencies += "joda-time" % "joda-time" % "2.8.2"

mainClass := Some("DataLoader")

