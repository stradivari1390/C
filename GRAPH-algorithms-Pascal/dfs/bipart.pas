{ depth-first search (is bipartite) }

const
  maxn = 250;

var
  a: array [1..maxn, 1..maxn] of boolean;
  c, p: array [1..maxn] of word;
  n: longint;

procedure init;
var
  i, x, y, nn: longint;
begin
  fillchar(a, sizeof(a), false);
  fillchar(p, sizeof(p), 0);
  fillchar(c, sizeof(c), 0);

  assign(input, 'graph.in');
  reset(input);

  read(n);
  read(nn);

  for i := 1 to nn do
  begin
    read(x, y);
    a[x, y] := true;
    a[y, x] := true;                    { если неориентированный граф }
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

function dfs(v: longint; color: byte): boolean;
var
  i: integer;
begin
  if color = 1 then
    c[v] := 2
  else if color = 2 then
    c[v] := 1;

  for i := 1 to n do
    if a[v, i] then
      if c[i] = 0 then
      begin
        p[i] := v;
        dfs := dfs(i, c[v]);
      end
      else if (p[v] <> i) and (c[i] <> color) then            { not parent }
      begin
        dfs := false;
        exit;
      end;

  dfs := true;
end;

function is_bipartite: boolean;
var
  i: longint;
begin
  for i := 1 to n do
    if c[i] = 0 then
    begin
      if not dfs(i, 1) then
      begin
        is_bipartite := false;
        exit;
      end;
    end;

  is_bipartite := true;
end;


var
  i: word;
  b: boolean;

begin
  init;

  writeln('depth-first search (cycle)');

  b := is_bipartite;
  writeln('is bipartite : ', b);
  if b then
  begin
    write('parts : ');
    for i := 1 to n do
      write(c[i], ' ');
  end;

  print;
end.