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
