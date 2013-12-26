module: cassandra-test-suite
synopsis: Test suite for the Cassandra data-types.

define suite data-type-test-suite ()
  test cassandra-string-test;
  test cassandra-long-string-test;
end suite;

define test cassandra-string-test ()
end test;

define test cassandra-long-string-test ()
end test;
