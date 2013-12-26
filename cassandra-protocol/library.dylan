module: dylan-user

define library cassandra-protocol
  use dylan;
  use common-dylan;
  use binary-data;

  export cassandra-protocol;
end library;

define module cassandra-protocol
  use common-dylan;
  use binary-data;

  export
    <cassandra-error>,
    <cassandra-startup>,
    <cassandra-ready>,
    <cassandra-authenticate>,
    <cassandra-credentials>,
    <cassandra-options>,
    <cassandra-supported>,
    <cassandra-query>,
    <cassandra-result>,
    <cassandra-prepare>,
    <cassandra-execute>,
    <cassandra-register>,
    <cassandra-event>,
    <cassandra-batch>,
    <cassandra-auth-challenge>,
    <cassandra-auth-response>,
    <cassandra-auth-success>;
end module;
