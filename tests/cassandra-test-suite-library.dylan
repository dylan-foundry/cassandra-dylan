module: dylan-user

define library cassandra-test-suite
  use common-dylan;
  use binary-data;
  use cassandra-protocol;
  use testworks;

  export cassandra-test-suite;
end library;

define module cassandra-test-suite
  use common-dylan, exclude: { format-to-string };
  use binary-data;
  use cassandra-protocol;
  use testworks;

  export cassandra-test-suite;
end module;
