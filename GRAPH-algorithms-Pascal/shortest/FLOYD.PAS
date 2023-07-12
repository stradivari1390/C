{ shortest path from all to all (Floyd's algorithm) }

const
  maxn = 100;
  inf  = maxint div 2;

var
  d, a: array [1..maxn, 1..maxn] of integer;
  p: array [1..maxn, 1..maxn] of integer;
  n: longint;

procedure init;
var
  i, j, x, y, nn, z: longint;
begin
  for i := 1 to maxn do
    for j := 1 to maxn do
      a[i, j] := inf;

  for i := 1 to maxn do
    a[i, i] := 0;

  fillchar(d, sizeof(d), 0);
  fillchar(p, sizeof(p), 0);

  assign(input, 'dijkstra.in');
  reset(input);

  read(n);
  read(nn);

  for i := 1 to nn do
  begin
    read(x, y, z);
    a[x, y] := z;
{    a[y, x] := z;}                       { если неориентированный граф }
  end;
end;

procedure print;
var
  i, j: integer;
begin
  writeln;
  writeln('number of vertex : ', n);
  writeln('adjacency matrix');
  for i := 1 to n do
  begin
    for j := 1 to n do
      write(a[i, j]:6);
    writeln;
  end;
end;

procedure print_d;
var
  i, j: integer;
begin
  writeln;
  writeln('shotest path matrix matrix');
  for i := 1 to n do
  begin
    for j := 1 to n do
      write(d[i, j]:6);
    writeln;
  end;
end;

procedure floyd;
var
  k, i, j: integer;
begin
  for i := 1 to n do
    for j := 1 to n do
    begin
      p[i, j] := i;
      d[i, j] := a[i, j];
    end;

  for k := 1 to n do
    for i := 1 to n do
      for j := 1 to n do
        if d[i, j] > d[i, k] + d[k, j] then
        begin
          d[i, j] := d[i, k] + d[k, j];
          p[i, j] := k;
        end;
end;


begin
  init;
  writeln('shortest path from all to all (Floyd''s algorithm)');
  print;
  floyd;
  print_d;
end.