{ depth-first search (non recursive) }

const
  maxn = 250;

var
  a: array [1..maxn, 1..maxn] of boolean;
  visited: array [1..maxn] of boolean;
  st, p: array [1..maxn] of word;
  c, n: longint;

procedure init;
var
  i, x, y, nn: longint;
begin
  fillchar(a, sizeof(a), false);
  fillchar(p, sizeof(p), 0);
  fillchar(st, sizeof(st), 0);
  fillchar(visited, sizeof(visited), false);
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
  found: boolean;
begin
  visited[v] := true;
  inc(c);
  st[c] := v;

  while c > 0 do
  begin
    v := st[c];
    found := false;

    for i := 1 to n do
      if a[v, i] and not visited[i] then
      begin
        found := true;
        break;
      end;

    if found then
    begin
      visited[i] := true;
      inc(c);
      st[c] := i;
      p[i] := v;
    end
    else
      dec(c);
  end;

end;

var
  i: longint;

begin
  init;

  writeln('depth-first search (non recursive)');
  for i := 1 to n do
    if not visited[i] then
      dfs(i);

  write('dfs forest : ');
  for i := 1 to n do
    write(p[i], ' ');

  print;
end.