{ поиск максимального потока в сети }
{ метод Форда-Фалкерсона }
{ алгоритм Эдмондса-Карпа }
{ для поиска аугментального пути используется алгоритм Дейкстры }
{ где весами считается неиспользованная пропускная способность }

{- Константы и переменные -}

const
  maxn = 100;                            { макс. кол-во вершин }
  oo   = maxint;                         { бесконечность }

var
  { поток }
  f: array [1..maxn, 1..maxn] of integer;  { f[i, j] = -f[j, i] }
  { пропускные способности }
  c: array [1..maxn, 1..maxn] of integer;
  { количество вешрин}
  n: integer;

{- Алгоритм Дейкстры -}

{ Переменные }

var
  { номер предыдущей вершины}
  p: array [1..maxn] of integer;
  { посещенность }
  v: array [1..maxn] of boolean;
  { кратчайшие расстояния от истока }
  d: array [1..maxn] of longint;

function edge(i, j: integer): integer;
begin
  if c[i, j] - f[i, j] > 0 then
    edge := c[i, j] - f[i, j]
  else
    edge := oo;
end;

function dijkstra(s, t: integer): boolean;
var
  i, j, k: integer;
  min: longint;
begin
  fillchar(v, sizeof(v), false);

  for i := 1 to n do
  begin
    p[i] := s;
    d[i] := edge(s, i);
  end;

  p[s] := 0;
  d[s] := 0;
  v[s] := true;

  for i := 1 to n-1 do
  begin
    min := oo;

    for j := 1 to n do
      if not v[j] and (d[j] < min) then
      begin
        min := d[j];
        k   := j;
      end;

    v[k] := true;

    for j := 1 to n do
      if not v[j] and (d[j] > d[k] + edge(k, j)) then
      begin
        d[j] := d[k] + edge(k, j);
        p[j] := k;
      end;
  end;

  dijkstra := d[t] <> oo;
end;


{- Основные процедуры -}

{ min: минимум из двух вещественных чисел }
function min(a, b: integer): integer;
begin
  if a > b then min := b else min := a;
end;

{ maxflow: значения максимального потока }
{ поток хранится в матрице f, s-исток, t-сток }
function maxflow(s, t: integer): integer;
var
  k: integer;
  d, flow: longint;
begin
  fillchar(f, sizeof(f), 0);            { обнуляем f }
  flow := 0;                            { поток пустой }

  while dijkstra(s, t) do                    { Пока существует путь от истока в }
  begin                                 { в сток в остаточной сети, ищем   }
    d := oo;                            { ребро в этом пути с минимальной  }
    k := t;                             { неиспользованной пропускной      }
    while k <> s do                     { способностью                     }
    begin
      d := min(d, c[p[k], k]-f[p[k], k]);
      k := p[k];                        { берем вершину-предок }
    end;

    k := t;                             { идем по найденому пути от стока  }
    while k <> s do                     { к истоку                         }
    begin
      f[p[k], k] := f[p[k], k] + d;     { увеличиваем по прямым ребрам }
      f[k, p[k]] := f[k, p[k]] - d;     { уменьшаем по обратным ребрам }
      k := p[k];                        { берем вершину-предок }
    end;

    flow := flow + d;                   { увеличиваем поток }
  end;

  maxflow := flow;                      { возвращаем максимальный поток }
end;

{ init: инициализация и ввод данных }
procedure init;
var
  m, i, x, y, z: integer;
begin
  fillchar(c, sizeof(c), 0);

  assign(input, 'flow.in');
  reset(input);

  read(n, m);

  for i := 1 to m do
  begin
    read(x, y, z);
    c[x, y] := z;
  end;

  close(input);
end;

{solve: решение }
procedure solve;
begin
  writeln(maxflow(1, n));
end;

{- Главная программа -}

begin
  init;
  solve;
end.