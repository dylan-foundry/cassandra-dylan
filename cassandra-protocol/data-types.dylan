module: cassandra-protocol
synopsis: A client implementation for Cassandra.
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define constant <cassandra-short> = <2byte-big-endian-unsigned-integer>;

define constant <cassandra-int> = <big-endian-unsigned-integer-4byte>;

define constant <string-vec> = limited(<vector>, of: <string>);

define binary-data cassandra-string (container-frame)
  field string-length :: <cassandra-short>,
    fixup: byte-offset(frame-size(frame.string-data));
  field string-data :: <externally-delimited-string>
    = $empty-externally-delimited-string,
    length: frame.string-length * 8;
end;

define method as (class == <string>, c :: <cassandra-string>)
 => (res :: <string>)
  as(<string>, c.string-data)
end;

define method as (class == <cassandra-string>, s :: <string>)
 => (res :: <cassandra-string>)
  cassandra-string(string-data: as(<externally-delimited-string>, s))
end;

define binary-data cassandra-long-string (container-frame)
  field %string-length :: <cassandra-int>,
    fixup: float-to-byte-vector-be(as(<double-float>, byte-offset(frame-size(frame.string-data))));
  field string-data :: <externally-delimited-string>
    = $empty-externally-delimited-string,
    length: frame.string-length * 8;
end;

define method string-length (c :: <cassandra-long-string>) => (res :: <integer>)
  c.%string-length.data.byte-vector-to-float-be.round
end;

define method as (class == <string>, c :: <cassandra-long-string>)
 => (res :: <string>)
  as(<string>, c.string-data);
end;

define method as (class == <cassandra-long-string>, s :: <string>)
 => (res :: <cassandra-long-string>)
  cassandra-string(string-data: as(<externally-delimited-string>, s))
end;

define binary-data cassandra-bytes (container-frame)
  field %bytes-length :: <cassandra-int>,
    fixup: float-to-byte-vector-be(as(<double-float>, byte-offset(frame-size(frame.bytes-data))));
  field bytes-data :: <raw-frame>
    = $empty-raw-frame,
    length: frame.bytes-length * 8;
end;

define method bytes-length (f :: <cassandra-bytes>) => (res :: <integer>)
  f.%bytes-length.data.byte-vector-to-float-be.round
end;

define binary-data cassandra-short-bytes (container-frame)
  field bytes-length :: <cassandra-short>,
    fixup: byte-offset(frame-size(frame.bytes-data));
  field bytes-data :: <raw-frame>
    = $empty-raw-frame,
    length: frame.bytes-length * 8;
end;

define binary-data cassandra-string-list (container-frame)
  field string-list-count :: <cassandra-short>,
    fixup: byte-offset(frame-size(frame.string-list));
  repeated field string-list :: <cassandra-string>,
    count: frame.string-list-count;
end;

define method as
 (class == <string-vec>, xs :: <cassandra-string-list>)
 => (res :: <string-vec>)
  as(<string-vec>, map(curry(as, <string>), xs.string-list))
end;

define method as
 (class == <cassandra-string-list>, xs :: <string-vec>)
 => (res :: <cassandra-string-list>)
  cassandra-string-list(string-list: map(curry(as, <cassandra-string>), xs))
end;


define binary-data cassandra-string-map-item (container-frame)
  field string-map-key :: <cassandra-string>;
  field string-map-value :: <cassandra-string>;
end;

define binary-data cassandra-string-map (container-frame)
  field string-map-count :: <cassandra-short>,
    fixup: size(frame.string-map-contents);
  repeated field string-map-contents :: <cassandra-string-map-item>,
    count: frame.string-map-count;
end;

define method as (class == <cassandra-string-map>, xs :: <string-table>)
 => (res :: <cassandra-string-map>)
  let eles = #();
  for (x in key-sequence(xs))
    let item =
      cassandra-string-map-item(string-map-key: as(<cassandra-string>, x),
                                string-map-value: as(<cassandra-string>, xs[x]));
    eles := pair(item, eles)
  end;
  cassandra-string-map(string-map-contents: eles)
end;

define method as (class == <string-table>, cs :: <cassandra-string-map>)
 => (res :: <string-table>)
  let res = make(<string-table>);
  for (x in cs.string-map-contents)
    res[as(<string>, x.string-map-key)] := as(<string>, x.string-map-value);
  end;
  res;
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

define method as (class == <cassandra-string-multimap>, xs :: <string-table>)
 => (res :: <cassandra-string-multimap>)
  let eles = #();
  for (x in key-sequence(xs))
    let item =
      cassandra-string-multimap-item(string-map-key: as(<cassandra-string>, x),
                                     string-map-value: as(<cassandra-string-list>, xs[x]));
    eles := pair(item, eles)
  end;
  cassandra-string-multimap(string-map-contents: eles)
end;

define method as (class == <string-table>, cs :: <cassandra-string-multimap>)
 => (res :: <string-table>)
  let res = make(<string-table>);
  for (x in cs.string-map-contents)
    res[as(<string>, x.string-map-key)] := as(<string-vec>, x.string-map-value);
  end;
  res;
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
  variably-typed field address, type-function:
    if (frame.address-family == #"IPv4")
      <cassandra-inet-ipv4-address-data>
    elseif (frame.address-family == #"IPv6")
      <cassandra-inet-ipv6-address-data>
    end if;
  field inet-port :: <cassandra-int>;
end;
