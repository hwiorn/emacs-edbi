require 'jimson'
require 'dbi'

$dbh = nil
$sth = nil

# https://github.com/kiwanami/ruby-elrpc
# https://metacpan.org/pod/DBI
# https://github.com/Pistos/ruby-dbi

class EdbiHandler
  extend Jimson::Handler

  def add(a, b)
    a+b
  end

  def ping(arg)
    "pong: #{arg}"
  end

  def connect(data_source, username, auth)
    auth = nil if auth.empty?
    if $dbh
      $dbh.disconnect
    end

    begin
      $dbh = DBI.connect(data_source, username, auth)
    rescue DBI::DatabaseError => e
      abort("Could not connect to database:\n - Data Source (#{data_source})\n - User Name: (#{username}):\n - DBI error: (#{e.message})")
    end

    row = $dbh.select_one("SELECT VERSION()")
    row[0]
  end

  def do(sql, params)
    return nil unless $dbh
    $dbh.do sql, *params
  end

  def select_all(sql, params)
    return nil unless $dbh
    $dbh.select_all sql, *params
  end


  def prepare(sql)
    return nil unless $dbh
    if $sth
      $sth.finish
    end
    $sth = $dbh.prepare sql
    'sth'
  end

  def execute(params)
    return nil unless $sth
    $sth.execute params
  end

  # $dbh.columns
  def fetch-columns
    return nil unless $sth
    $sth.column_names
  end

  def fetch(num)
    return nil unless $sth
    return $sth.fetch_all unless num
    return $sth.fetch_many num
  end

  def auto-commit(flag)
    return nil unless $dbh
    ac = flag == "true" ? 1 : 0
    $dbh.do "SET autocommit = #{ac}"
    ac
  end

  def commit()
    return nil unless $dbh
    $dbh.commit
    return 1
  end

  def rollback()
    return nil unless $dbh
    $dbh.rollback
    return 1
  end

  def disconnect()
    return nil unless $dbh
    $dbh.disconnect
    return 1
  end


  # TODO: implement it
  def status()
    return nil unless $dbh
    # return [$dbh->err, $dbh->errstr, $dbh->state];
  end

  # TODO: implement it
  def type-info-all()
    return nil unless $dbh
    # my $ret = $dbh->type_info_all;
    # print STDERR Dumper $ret;
    # return $dbh->type_info_all;
  end

  # TODO: implement it
  def table_info(catalog, schema, table, type)
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
  def column_info(catalog, schema, table, column)
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
  def primary_key_info(catalog, schema, table)
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
  def foreign_key_info(pk_catalog, pk_schema, pk_table, fk_catalog, fk_schema, fk_table)
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
end

# FIXME: make as cli option
host = '127.0.0.1'
port = TCPServer.open(host, 0){|s| s.addr[1] }
server = Jimson::Server.new(EdbiHandler.new,
                           :host => host,
                           :port => port)
puts server.port
server.start
