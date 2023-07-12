{ depth-first search (connected copmponents) }

const
  maxn = 250;

var
  a: array [1..maxn, 1..maxn] of boolean;
  cc: array [1..maxn] of word;
  c, n: longint;

procedure init;
var
  i, x, y, nn: longint;
begin
  fillchar(a, sizeof(a), false);
  fillchar(cc, sizeof(cc), 0);
  c := 0;

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

procedure dfs(v: longint);
var
  i: integer;
begin
  cc[v] := c;

  for i := 1 to n do
    if (cc[i]=0) and a[v, i] then
      dfs(i);

end;

var
  i: longint;

begin
  init;

  writeln('depth-first search (connected components)');

  for i := 1 to n do
    if cc[i] = 0 then
    begin
      inc(c);
      dfs(i);
    end;

  write('connected components : ');

  for i := 1 to n do
    write(cc[i], ' ');

  print;
end.