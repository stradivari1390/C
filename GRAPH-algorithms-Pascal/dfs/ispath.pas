{ depth-first search (is path) }

const
  maxn = 250;

var
  a: array [1..maxn, 1..maxn] of boolean;
  visited: array [1..maxn] of boolean;
  n: longint;

procedure init;
var
  i, x, y, nn: longint;
begin
  fillchar(a, sizeof(a), false);
  fillchar(visited, sizeof(visited), false);
  assign(input, 'graph.in');
  reset(input);

  read(n);
  read(nn);

  for i := 1 to nn do
  begin
    read(x, y);
    a[x, y] := true;
    a[y, x] := true;                    { �᫨ ���ਥ��஢���� ��� }
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
  visited[v] := true;

  for i := 1 to n do
    if (not visited[i]) and a[v, i] then
      dfs(i);

end;

function is_path(v, w: word): boolean;
begin
  fillchar(visited, sizeof(visited), false);
  dfs(v);
  is_path := visited[w];
end;

var
  i: longint;

begin
  init;

  writeln('depth-first search (is path)');
  writeln('1 - 6 ', is_path(1, 6));
  writeln('1 - 9 ', is_path(1, 9));

  print;
end.