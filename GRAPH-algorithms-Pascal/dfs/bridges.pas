{ depth-first search (bridges) }

const
  maxn = 250;

var
  a: array [1..maxn, 1..maxn] of boolean;
  pre, low, p: array [1..maxn] of word;
  pre_c, n: longint;

procedure init;
var
  i, x, y, nn: longint;
begin
  fillchar(a, sizeof(a), false);
  fillchar(pre, sizeof(pre), 0);
  fillchar(p, sizeof(p), 0);
  fillchar(low, sizeof(low), 0);
  pre_c  := 1;

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

function min(a, b: longint): longint;
begin
  if a > b then min := b else min := a;
end;

procedure dfs(v: longint);
var
  i: integer;
begin
  pre[v] := pre_c;
  low[v] := pre_c;
  inc(pre_c);

  for i := 1 to n do
    if a[v, i] then
      if pre[i] = 0 then
      begin
        p[i] := v;
        dfs(i);
        low[v] := min(low[v], low[i]);
        if low[i] = pre[i] then
          write(v, '-', i, ' ');
      end
      else if p[v] <> i then
        low[v] := min(low[v], pre[i]);

end;

var
  i: longint;

begin
  init;

  writeln('depth-first search (bridges)');
  write('bridges :');
  for i := 1 to n do
    if pre[i] = 0 then
      dfs(i);

  writeln;

  write('pre order : ');
  for i := 1 to n do
    write(pre[i], ' ');

  writeln;

  write('low : ');
  for i := 1 to n do
    write(low[i], ' ');

  print;
end.