module: cassandra-test-suite
synopsis: Test suite for the Cassandra data-types.

define suite data-type-test-suite ()
  test cassandra-string-test;
  test cassandra-long-string-test;
end suite;

define test cassandra-string-test ()
  let cassandra-string = parse-frame(<cassandra-string>, #(0, 2, 65, 66));
  assert-equal(cassandra-string.string-length, 2);
  assert-equal(as(<string>, cassandra-string.string-data), "AB");
end test;

define test cassandra-long-string-test ()
end test;
