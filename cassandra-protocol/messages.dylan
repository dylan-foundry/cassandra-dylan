module: cassandra-protocol
synopsis: A client implementation for Cassandra.
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.



define abstract binary-data cassandra-message (variably-typed-container-frame)
  length round(byte-vector-to-float-be(frame.message-length.data)) * 8;
  field message-version :: <unsigned-byte>;
  field message-flags :: <unsigned-byte>;
  field message-stream :: <unsigned-byte>; // XXX: Should be signed
  layering field message-opcode :: <unsigned-byte>;
  field message-length :: <big-endian-unsigned-integer-4byte>,
    fixup: float-to-byte-vector-be(as(<double-float>, byte-offset(frame-size(frame))));
end;

ignore(cassandra-message);

define binary-data cassandra-error (cassandra-message)
  over <cassandra-message> #x00;
  field error-code :: <cassandra-int>;
  field error-message :: <cassandra-string>;
end;

define binary-data cassandra-startup (cassandra-message)
  over <cassandra-message> #x01;
  field startup-options :: <cassandra-string-map>;
end;

define binary-data cassandra-ready (cassandra-message)
  over <cassandra-message> #x02;
  // No more fields.
end;

define binary-data cassandra-authenticate (cassandra-message)
  over <cassandra-message> #x03;
end;

// This is for version 1 of the binary-data only
define binary-data cassandra-credentials (cassandra-message)
  over <cassandra-message> #x04;
  field credentials :: <cassandra-string-map>;
end;

define binary-data cassandra-options (cassandra-message)
  over <cassandra-message> #x05;
  // No more fields
end;

define binary-data cassandra-supported (cassandra-message)
  over <cassandra-message> #x06;
  field supported-option-values :: <cassandra-string-multimap>;
end;

define binary-data cassandra-query (cassandra-message)
  over <cassandra-message> #x07;
end;

define binary-data cassandra-result (cassandra-message)
  over <cassandra-message> #x08;
end;

define binary-data cassandra-prepare (cassandra-message)
  over <cassandra-message> #x09;
  field prepare-query :: <cassandra-long-string>;
end;

define binary-data cassandra-execute (cassandra-message)
  over <cassandra-message> #x0A;
end;

define binary-data cassandra-register (cassandra-message)
  over <cassandra-message> #x0B;
  field register-event-list :: <cassandra-string-list>;
end;

define binary-data cassandra-event (cassandra-message)
  over <cassandra-message> #x0C;
  field event-type :: <cassandra-string>;
  variably-typed field event-data, type-function:
    if (frame.event-type == "TOPOLOGY_CHANGE")
      <cassandra-event-topology-change-data>
    elseif (frame.event-type == "STATUS_CHANGE")
      <cassandra-event-status-change-data>
    elseif (frame.event-type == "SCHEMA_CHANGE")
      <cassandra-event-schema-change-data>
    else
      // XXX: What to do?
      // hannes would either error() or return <raw-frame>
      <raw-frame>
    end if;
end;

define binary-data cassandra-event-topology-change-data (container-frame)
  field topology-change-type :: <cassandra-string>;
  field topology-change-address :: <cassandra-inet>;
end;

define binary-data cassandra-event-status-change-data (container-frame)
  field status-change-type :: <cassandra-string>;
  field status-change-address :: <cassandra-inet>;
end;

define binary-data cassandra-event-schema-change-data (container-frame)
  field schema-change-type :: <cassandra-string>;
  field schema-change-keyspace :: <cassandra-string>;
  field schema-change-table :: <cassandra-string>;
end;

define binary-data cassandra-batch (cassandra-message)
  over <cassandra-message> #x0D;
end;

define binary-data cassandra-auth-challenge (cassandra-message)
  over <cassandra-message> #x0E;
end;

define binary-data cassandra-auth-response (cassandra-message)
  over <cassandra-message> #x0F;
end;

define binary-data cassandra-auth-success (cassandra-message)
  over <cassandra-message> #x10;
end;
