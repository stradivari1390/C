{ max matching in bipartite graphs }

const
  m = 200;
  n = 200;

var
  a: array [1..n, 1..m] of boolean;
  v: array [1..n] of boolean;
  p: array [1..m] of word;
  c, mm, nn: longint;

procedure init;
var
  x, y, k, i: longint;
begin
  fillchar(a, sizeof(a), 0);
  fillchar(v, sizeof(v), 0);
  fillchar(p, sizeof(p), 0);
  c := 0;

  assign(input, 'matching.in');
  reset(input);

  read(nn, mm, k);

  for i := 1 to k do
  begin
    read(x, y);
    a[x, y] := true;
  end;
end;

function find_pair(k: integer): boolean;
var
  i: integer;
begin
  find_pair := false;

  if v[k] then
    exit;

  v[k] := true;

  for i := 1 to mm do
    if a[k, i] and ( (p[i] = 0) or find_pair(p[i]) ) then
    begin
      find_pair := true;
      p[i] := k;
      exit;
    end;
end;

procedure solve;
var
  i: longint;
begin
  for i := 1 to nn do
  begin
    fillchar(v, sizeof(v), false);
    if find_pair(i) then
      inc(c);
  end;
end;

procedure done;
var
  i: longint;
begin
  writeln(c);
  for i := 1 to mm do
    if p[i] <> 0 then
      writeln(i, ' ', p[i]);
end;


begin
  init;
  solve;
  done;
end.