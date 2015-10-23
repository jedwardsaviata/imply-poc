CREATE KEYSPACE IF NOT EXISTS druid
  WITH replication = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 }
;
---
CREATE TABLE IF NOT EXISTS druid.index_storage
(
  key text,
  chunk text,
  value blob,
  PRIMARY KEY (key, chunk)
)
WITH COMPACT STORAGE
;
---
CREATE TABLE IF NOT EXISTS druid.descriptor_storage
(
  key varchar,
  lastModified timestamp,
  descriptor varchar,
  PRIMARY KEY (key)
)
WITH COMPACT STORAGE
;
