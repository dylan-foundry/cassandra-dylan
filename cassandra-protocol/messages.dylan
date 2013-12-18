module: cassandra-protocol
synopsis: A client implementation for Cassandra.
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define abstract binary-data cassandra-message (variably-typed-container-frame)
  field version :: <unsigned-byte>;
  field flags :: <unsigned-byte>;
  field stream :: <unsigned-byte>; // XXX: Should be signed
  layering field opcode :: <unsigned-byte>;
  field length :: <big-endian-unsigned-integer-4byte>;
end;

define binary-data cassandra-error (cassandra-message)
  over <cassandra-message> #x00;
end;

define binary-data cassandra-startup (cassandra-message)
  over <cassandra-message> #x01;
end;

define binary-data cassandra-ready (cassandra-message)
  over <cassandra-message> #x02;
end;

define binary-data cassandra-authenticate (cassandra-message)
  over <cassandra-message> #x03;
end;

// This is for version 1 of the binary-data only
define binary-data cassandra-credentials (cassandra-message)
  over <cassandra-message> #x04;
end;

define binary-data cassandra-options (cassandra-message)
  over <cassandra-message> #x05;
end;

define binary-data cassandra-supported (cassandra-message)
  over <cassandra-message> #x06;
end;

define binary-data cassandra-query (cassandra-message)
  over <cassandra-message> #x07;
end;

define binary-data cassandra-result (cassandra-message)
  over <cassandra-message> #x08;
end;

define binary-data cassandra-prepare (cassandra-message)
  over <cassandra-message> #x09;
end;

define binary-data cassandra-execute (cassandra-message)
  over <cassandra-message> #x0A;
end;

define binary-data cassandra-register (cassandra-message)
  over <cassandra-message> #x0B;
end;

define binary-data cassandra-event (cassandra-message)
  over <cassandra-message> #x0C;
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
