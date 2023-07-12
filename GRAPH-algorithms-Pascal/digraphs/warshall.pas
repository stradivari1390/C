{ digraphs (transitive closure) }
{ Warshall algorithm }

const
  maxn = 250;

var
  a: array [1..maxn, 1..maxn] of boolean;
  n: longint;

procedure init;
var
  i, x, y, nn: longint;
begin
  fillchar(a, sizeof(a), false);
{  assign(input, 'digraph.in');}
  assign(input, 'warshall.in');
  reset(input);

  read(n);
  read(nn);

  for i := 1 to nn do
  begin
    read(x, y);
    a[x, y] := true;
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
      write(ord(a[i, j]));
    writeln;
  end;
end;

procedure warshall;
var
  k, i, j: integer;
begin
  for i := 1 to n do                    { if you want self-loops }
    a[i, i] := true;

  for k := 1 to n do
    for i := 1 to n do
      if a[i, k] then
        for j := 1 to n do
          if a[k, j] then
            a[i, j] := true;
end;

{ more simple procedure but slower procedure
procedure warshall;
var
  k, i, j: integer;
begin
  for k := 1 to n do
    for i := 1 to n do
      for j := 1 to n do
        a[i, j] := a[i, j] or (a[i, k] and a[k, j]);
end;
}

begin
  init;

  writeln('digraphs (transitive closure)');
  writeln('Warshall algorithm');
  print;
  writeln('transitive closure');
  warshall;
  print;
end.