{ ���� ���ᨬ��쭮�� ��⮪� }
{ ��⮤�� ��⠫������� �ॢ��室�饣� ��⮪� }

const
  maxn = 100;

var
  n, m: integer;                                { ���-�� ���設 � �� }
  s, t: integer;                                { ��⮪ � �⮪ }
  i, w, nl, head, oldh, res: integer;
  f: array [1..maxn, 1..maxn] of integer;       { ��⮪ }
  c: array [1..maxn, 1..maxn] of integer;       { �ய�᪭� ᯮᮡ���� �� }
  ss: array [1..maxn, 1..maxn] of integer;      {}
  e: array [1..maxn] of integer;                { ����⮪ }
  ne, cur, next, prev, l, h: array [1..maxn] of integer;


{min: ������ �� ���� 楫�� �ᥫ}
function min(a, b: integer): integer;
begin
  if a > b then min := b else min := a;
end;

{ push: ��⠫������ ��⮪ �� ���設� u � ���譨� v }
procedure push(u, v: integer);
var
  d: integer;
begin
  d := min(e[u], c[u, v] - f[u, v]);    { d - ������ �� ����⪠ �          }
                                        { ����筮� �ய�᪭�� ᯮᮡ���� }
  e[u] := e[u] - d;                     { 㬥��蠥� ����⮪ ���設� u }
  e[v] := e[v] + d;                     { 㢥��稢��� ����⮪ ���設� v }

  f[u,v] :=  f[u,v] + d;                { 㢥��稢��� ��⮪ �� �㣥 u->v }
  f[v,u] := -f[u,v];                    { ��⠥� ��⮪ �� ���⭮� �㣥 }
end;

{ lift: ���� ���設� u �㤥� ࠢ�� ���� ᠬ�� ������ ���設� + 1}
procedure lift(u: integer);
var
  v: integer;
begin
  h[u] := 2 * n;

  for v := 1 to n do                { ��ॡ�ࠥ� �� ���設� ����筮� �� }
    if (c[u,v] - f[u,v] > 0) and    { ॡ� u->v ����������� }
       (h[v] < h[u]) then           { � ���� v ����� ����� u }
      h[u]:=h[v];

  inc(h[u]);
end;

{ discharge: ࠧ��㧪� ���設� }
procedure discharge(u:integer);
var
  v: integer;
begin
  while e[u] > 0 do
  begin
    v := ss[u, cur[u]];
    if v = 0 then
    begin
      lift(u);
      cur[u]:=1;
    end
    else if (c[u, v] - f[u, v] > 0) and (h[u] = h[v]+1) then
      push(u, v)
    else
      inc(cur[u]);
  end;
end;

{ init: ���樠������ � �⥭�� ������ }
procedure init;
var
  x, y, z, i: integer;
begin
  assign(input, 'flow.in');
  reset(input);

  read(n, m);
  s := 1;
  t := n;

  for i := 1 to m do
  begin
    read(x, y, z);

    inc(ne[x]);
    ss[x, ne[x]] := y;
    inc(ne[y]);
    ss[y, ne[y]] := x;
    c[x, y] := z;
  end;
end;

procedure init_preflow;
var
  i: integer;
begin
  h[s] := n;

  for i := 1 to n do
  begin
    if c[s, i] > 0 then
    begin
      f[s, i] :=  c[s, i];
      f[i, s] := -c[s, i];
      e[i] := e[i] + c[s, i];
    end;

    if (i <> s) and (i <> t) then
    begin
      cur[i] := 1;
      inc(nl);
      l[nl] := i;
    end;
  end;
end;

{ solve: �襭�� ����� }
procedure solve;
var
  u: integer;
begin
  init_preflow;

  for i := 1 to nl do
  begin
    prev[i] := i - 1;
    next[i] := i + 1;
  end;

  if nl <> 0 then
  begin
    next[nl] := 0;
    head := 1;
    i := head;
  end
  else
    i := 0;

  while i > 0 do
  begin
    u := L[i];
    oldh:=h[u];
    Discharge(u);
    if (h[u]<>oldh)and(i<>head) then begin
      if next[i]<>0 then prev[next[i]]:=prev[i];
      next[prev[i]]:=next[i];
      next[i]:=head;
      prev[i]:=0; prev[head]:=i;
      head:=i;
    end;
    i:=next[i];
  end;


end;

{ done: ������ १���� � ��� �뢮� }
procedure done;
var
  i: integer;
begin
  res := 0;
  for i := 1 to n do
    res := res + f[s, i];

  writeln(res);
  close(input);
end;

begin
  init;
  solve;
  done;
end.