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
    <cassandra-short>,
    <cassandra-int>,
    <string-vec>,
    <cassandra-string>, cassandra-string,
    <cassandra-long-string>, cassandra-long-string,
    string-length, string-data,
    <cassandra-bytes>, cassandra-bytes,
    <cassandra-short-bytes>, cassandra-short-bytes,
    bytes-length, bytes-data,
    <cassandra-string-list>, cassandra-string-list,
    string-list-count, string-list,
    <cassandra-string-map-item>, cassandra-string-map-item,
    <cassandra-string-map>, cassandra-string-map,
    <cassandra-string-multimap-item>, cassandra-string-multimap-item,
    <cassandra-string-multimap>, cassandra-string-multimap,
    <cassandra-inet-ipv4-address-data>, cassandra-inet-ipv4-address-data,
    <cassandra-inet-ipv6-address-data>, cassandra-inet-ipv6-address-data,
    <cassandra-inet>, cassandra-inet;

  export
    <cassandra-message>,
    <cassandra-error>, cassandra-error,
    <cassandra-startup>, cassandra-startup,
    <cassandra-ready>, cassandra-ready,
    <cassandra-authenticate>, cassandra-authenticate,
    <cassandra-credentials>, cassandra-credentials,
    <cassandra-options>, cassandra-options,
    <cassandra-supported>, cassandra-supported,
    <cassandra-query>, cassandra-query,
    <cassandra-result>, cassandra-result,
    <cassandra-prepare>, cassandra-prepare,
    <cassandra-execute>, cassandra-execute,
    <cassandra-register>, cassandra-register,
    <cassandra-event>, cassandra-event,
    <cassandra-event-topology-change-data>, cassandra-event-topology-change-data,
    <cassandra-event-status-change-data>, cassandra-event-status-change-data,
    <cassandra-event-schema-change-data>, cassandra-event-schema-change-data,
    <cassandra-batch>, cassandra-batch,
    <cassandra-auth-challenge>, cassandra-auth-challenge,
    <cassandra-auth-response>, cassandra-auth-response,
    <cassandra-auth-success>, cassandra-auth-success;
end module;
