{ поиск максимального потока }
{ методом выталкивания превосходящего потока }

const
  maxn = 100;

var
  n, m: integer;                                { кол-во вершин и дуг }
  s, t: integer;                                { исток и сток }
  i, w, nl, head, oldh, res: integer;
  f: array [1..maxn, 1..maxn] of integer;       { поток }
  c: array [1..maxn, 1..maxn] of integer;       { пропускные способности дуг }
  ss: array [1..maxn, 1..maxn] of integer;      {}
  e: array [1..maxn] of integer;                { избыток }
  ne, cur, next, prev, l, h: array [1..maxn] of integer;


{min: минимум из двух целых чисел}
function min(a, b: integer): integer;
begin
  if a > b then min := b else min := a;
end;

{ push: проталкивает поток из вершине u в вершниу v }
procedure push(u, v: integer);
var
  d: integer;
begin
  d := min(e[u], c[u, v] - f[u, v]);    { d - минимум из избытка и          }
                                        { остаточной пропускной способности }
  e[u] := e[u] - d;                     { уменьшаем избыток вершины u }
  e[v] := e[v] + d;                     { увеличиваем избыток вершины v }

  f[u,v] :=  f[u,v] + d;                { увеличиваем поток по дуге u->v }
  f[v,u] := -f[u,v];                    { считаем поток по обратной дуге }
end;

{ lift: высота вершины u будет равна высоте самой низкой вершины + 1}
procedure lift(u: integer);
var
  v: integer;
begin
  h[u] := 2 * n;

  for v := 1 to n do                { перебираем все вершины остаточной сети }
    if (c[u,v] - f[u,v] > 0) and    { ребро u->v незаполнено }
       (h[v] < h[u]) then           { и высота v меньше высоты u }
      h[u]:=h[v];

  inc(h[u]);
end;

{ discharge: разгрузка вершины }
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

{ init: инициализация и чтение данных }
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

{ solve: решение задачи }
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

{ done: подсчет результата и его вывод }
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