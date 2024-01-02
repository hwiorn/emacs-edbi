require 'elrpc'
require 'dbi'

$dbh = nil
$sth = nil

# https://github.com/kiwanami/ruby-elrpc
# https://metacpan.org/pod/DBI
# https://github.com/Pistos/ruby-dbi

 # start server
server = Elrpc.start_server()

server.def_method "connect", "data_source, username, auth"  do |data_source, username, auth|
# server.def_method "connect"do |args|
  return "hh"
  # auth = nil if auth.empty?
  # if $dbh
  #   $dbh.disconnect
  # end

  # begin
  #   $dbh = DBI.connect(data_source, username, auth)
  # rescue DBI::DatabaseError => e
  #   abort("Could not connect to database:\n - Data Source (#{data_source})\n - User Name: (#{username}):\n - DBI error: (#{e.message})")
  # end

  # return "1.0"
  # #row = $dbh.select_one("SELECT VERSION()")
  # #return row[0]
end

server.def_method "do" do |sql, params|
  return nil unless $dbh
  $dbh.do sql, *params
end

server.def_method "select-all" do |sql, params|
  return nil unless $dbh
  $dbh.select_all sql, *params
end

server.def_method "prepare" do |sql|
  return nil unless $dbh
  if $sth
    $sth.finish
  end
  $sth = $dbh.prepare sql
  'sth'
end

server.def_method "execute" do |params|
  return nil unless $sth
  $sth.execute params
end

# $dbh.columns
server.def_method "fetch-columns" do ||
  return nil unless $sth
  $sth.column_names
end

server.def_method "fetch" do |num|
  return nil unless $sth
  return $sth.fetch_all unless num
  return $sth.fetch_many num
end

server.def_method "auto-commit" do |flag|
  return nil unless $dbh
  ac = flag == "true" ? 1 : 0
  $dbh.do "SET autocommit = #{ac}"
  ac
end

server.def_method "commit" do ||
  return nil unless $dbh
  $dbh.commit
  return 1
end

server.def_method "rollback" do ||
  return nil unless $dbh
  $dbh.rollback
  return 1
end

server.def_method "disconnect" do ||
  return nil unless $dbh
  $dbh.disconnect
  return 1
end

# TODO: implement it
server.def_method "status" do ||
  return nil unless $dbh
  # return [$dbh->err, $dbh->errstr, $dbh->state];
end

# TODO: implement it
server.def_method "type-info-all" do ||
  return nil unless $dbh
  # my $ret = $dbh->type_info_all;
  # print STDERR Dumper $ret;
  # return $dbh->type_info_all;
end

# TODO: implement it
server.def_method "table-info" do |catalog, schema, table, type|
  return nil unless $dbh
  # eval {
  #   $sth->finish() if $sth;
  # };
  # my ($args) = @_;
  # my ($catalog, $schema, $table, $type) = @$args;
  # $sth = $dbh->table_info( $catalog, $schema, $table, $type );
  # return [$sth->{NAME}, $sth->fetchall_arrayref()];
end

# TODO: implement it
server.def_method "column-info" do |catalog, schema, table, column|
  return nil unless $dbh
  # eval {
  #   $sth->finish() if $sth;
  # };
  # my ($args) = @_;
  # my ($catalog, $schema, $table, $column) = @$args;
  # $sth = $dbh->column_info( $catalog, $schema, $table, $column );
  # return [[],[]] unless $sth;
  # return [$sth->{NAME}, $sth->fetchall_arrayref()];
end

# TODO: implement it
server.def_method "primary-key-info" do |catalog, schema, table|
  return nil unless $dbh
  # eval {
  #   $sth->finish() if $sth;
  # };
  # my ($args) = @_;
  # my ($catalog, $schema, $table) = @$args;
  # $sth = $dbh->primary_key_info( $catalog, $schema, $table );
  # return undef unless $sth;
  # return [$sth->{NAME}, $sth->fetchall_arrayref()];
end

# TODO: implement it
server.def_method "foreign-key-info" do |pk_catalog, pk_schema, pk_table, fk_catalog, fk_schema, fk_table|
  return nil unless $dbh
  # eval {
  #   $sth->finish() if $sth;
  # };
  # my ($args) = @_;
  # my ($pkcatalog, $pkschema, $pktable, $fkcatalog, $fkschema, $fktable) = @$args;
  # $sth = $dbh->foreign_key_info( $pkcatalog, $pkschema, $pktable,
  #                                $fkcatalog, $fkschema, $fktable );
  # return undef unless $sth;
  # return [$sth->{NAME}, $sth->fetchall_arrayref()];
end


server.wait
