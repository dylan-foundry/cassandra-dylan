module: cassandra-protocol
synopsis: A client implementation for Cassandra.
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define constant <cassandra-short> = <2byte-big-endian-unsigned-integer>;

define constant <cassandra-int> = <big-endian-unsigned-integer-4byte>;

define binary-data cassandra-string (container-frame)
  field string-length :: <cassandra-short>;
  field string-data :: <externally-delimited-string>
    = $empty-externally-delimited-string,
    length: frame.string-length * 8;
end;

define binary-data cassandra-long-string (container-frame)
  field string-length :: <cassandra-int>;
  field string-data :: <externally-delimited-string>
    = $empty-externally-delimited-string,
    length: frame.string-length * 8;
end;

define binary-data cassandra-bytes (container-frame)
  field bytes-length :: <cassandra-int>;
  field bytes-data :: <raw-frame>
    = $empty-raw-frame,
    length: frame.bytes-length * 8;
end;

define binary-data cassandra-short-bytes (container-frame)
  field bytes-length :: <cassandra-short>;
  field bytes-data :: <raw-frame>
    = $empty-raw-frame,
    length: frame.bytes-length * 8;
end;

define binary-data cassandra-string-list (container-frame)
  field string-list-count :: <cassandra-short>;
  repeated field string-list :: <cassandra-string>,
    count: frame.string-list-count;
end;

define binary-data cassandra-string-map-item (container-frame)
  field string-map-key :: <cassandra-string>;
  field string-map-value :: <cassandra-string>;
end;

define binary-data cassandra-string-map (container-frame)
  field string-map-count :: <cassandra-short>;
  repeated field string-map-contents :: <cassandra-string-map-item>,
    count: frame.string-map-count;
end;

define binary-data cassandra-string-multimap-item (container-frame)
  field string-multimap-key :: <cassandra-string>;
  field string-multimap-value :: <cassandra-string-list>;
end;

define binary-data cassandra-string-multimap (container-frame)
  field string-multimap-count :: <cassandra-short>;
  repeated field string-multimap-contents :: <cassandra-string-multimap-item>,
    count: frame.string-multimap-count;
end;

define binary-data cassandra-inet-ipv4-address-data (container-frame)
  field ipv4-address-data :: <raw-frame>,
    static-length: 4;
end;

define binary-data cassandra-inet-ipv6-address-data (container-frame)
  field ipv6-address-data :: <raw-frame>,
    static-length: 16;
end;

define binary-data cassandra-inet (container-frame)
  enum field address-family :: <unsigned-byte> = 0,
    mappings: {  4 <=> #"IPv4",
                16 <=> #"IPv6" };
  variably-typed-field address, type-function:
    if (frame.address-family == #"IPv4")
      <cassandra-inet-ipv4-address-data>
    elseif (frame.address-family == #"IPv6")
      <cassandra-inet-ipv6-address-data>
    end if;
  field inet-port :: <cassandra-int>;
end;
