module: cassandra-test-suite
synopsis: Test suite for the Cassandra data-types.

define suite data-type-test-suite ()
  test cassandra-string-test;
  test cassandra-long-string-test;
  test cassandra-bytes-test;
  test cassandra-short-bytes-test;
  test cassandra-string-list-test;
end suite;

define test cassandra-string-test ()
  let cassandra-string = parse-frame(<cassandra-string>, #(0, 2, #x41, #x42));
  assert-equal(cassandra-string.string-length, 2);
  assert-equal(as(<string>, cassandra-string.string-data), "AB");
end test;

define test cassandra-long-string-test ()
  let cassandra-string = parse-frame(<cassandra-long-string>, #(0, 0, 0, 2, #x41, #x42));
  assert-equal(cassandra-string.string-length, 2);
  assert-equal(as(<string>, cassandra-string.string-data), "AB");
end test;

define test cassandra-bytes-test ()
  let cassandra-bytes = parse-frame(<cassandra-bytes>, #(0, 0, 0, 2, #x41, #x42));
  assert-equal(cassandra-bytes.bytes-length, 2);
  assert-equal(as(<string>, cassandra-bytes.bytes-data), "41 42 ");
end test;

define test cassandra-short-bytes-test ()
  let cassandra-bytes = parse-frame(<cassandra-short-bytes>, #(0, 2, #x41, #x42));
  assert-equal(cassandra-bytes.bytes-length, 2);
  assert-equal(as(<string>, cassandra-bytes.bytes-data), "41 42 ");
end test;

define test cassandra-string-list-test ()
  let cassandra-string-list = parse-frame(<cassandra-string-list>, #(0, 2, 0, 2, #x41, #x42, 0, 2, #x43, #x44));
  assert-equal(cassandra-string-list.string-list-count, 2);
  assert-equal(as(<string>, cassandra-string-list.string-list[0].string-data), "AB");
  assert-equal(as(<string>, cassandra-string-list.string-list[1].string-data), "CD");
end test;
