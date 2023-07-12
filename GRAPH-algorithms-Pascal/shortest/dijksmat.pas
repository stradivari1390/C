{ Кратчайшие пути из одного истока в сетях с неотрицательными весами ребер }
{ Алгоритм Дейкстры }
{ Матрица смежности }

const
  maxn = 100;                           { максимальное кол-во вершин }
  oo   = maxint div 2;                  { бесконечность }

var
  a: array [1..maxn, 1..maxn] of integer; { матрица смежности }
  d: array [1..maxn] of longint;        { кратчайшие пути }
  p: array [1..maxn] of integer;        { дерево кратчайших путей (SPT) }
  v: array [1..maxn] of boolean;        { использована ли вершина }
  n: longint;                           { кол-во вершин }

{ init: инициализация и чтение данных }
procedure init;
var
  i, j, x, y, nn, z: longint;
begin
  for i := 1 to maxn do                 { граф без ребер }
    for j := 1 to maxn do
      a[i, j] := oo;

  fillchar(d, sizeof(d), 0);
  fillchar(p, sizeof(p), 0);
  fillchar(v, sizeof(v), false);        { вершины не использованы }

  { чтение данных }
  assign(input, 'dijkstra.in');
{  assign(input, 'randw.in');}
  reset(input);

  read(n);
  read(nn);

  for i := 1 to nn do
  begin
    read(x, y, z);
    a[x, y] := z;
{    a[y, x] := z;}                       { если неориентированный граф }
  end;
end;

{ print: печать матрицы межности }
procedure print;
var
  i, j: integer;
begin
  writeln;
  writeln('Количество вершин: ', n);
  writeln('Матрица смежности');
  for i := 1 to n do
  begin
    for j := 1 to n do
      if a[i, j] = oo then
        write('oo':3)
      else
        write(a[i, j]:3);
    writeln;
  end;
end;

{ dijkstra: алгоритм Дейкстры }
procedure dijkstra(s: integer);
var
  i, j, min, m: integer;
begin
  for i := 1 to n do                    { для всех вершин }
  begin
    d[i] := a[s, i];                    { расстояние от истока }
    p[i] := s;                          { предок исток }
  end;

  d[s] := 0;                            { расстояние до истока }
  p[s] := 0;                            { у истока нет предков в (SPT) }
  v[s] := true;                         { источник использован }

  for i := 2 to n do                    { для всех вершин кроме истока }
  begin
    min := oo;                          { Найдем вершину m с минимальным }
    for j := 1 to n do                  { расстоянием до истока }
      if not v[j] and (d[j] < min) then
      begin
        min := d[j];
        m := j;
      end;

    v[m] := true;                       { вершина m использована }

    for j := 1 to n do                  { для всех вершин }
      if not v[j] and                   { Если вершина не использована и }
         (d[j] > d[m]+a[m, j]) then     { через m можно дойти до j быстрее }
      begin
        d[j] := d[m] + a[m, j];         { уменьшаем расстояние от истока }
        p[j] := m;                      { изменяем предка j }
      end;
  end;
end;

{write_path: пишет кратчайший путь из s в x }
procedure write_path(s, x: integer);
begin
  if x <> s then
    write_path(s, p[x]);

  write(x, ' ');
end;

begin
  init;
  writeln;
  writeln('Кратчайшие пути из одного истока в сетях с неотрицательными весами ребер');
  writeln('Алгоритм Дейкстры');

  dijkstra(1);
  print;
  write('Кратчайший путь из 1-ой вершины в 4-ую вершину: ');
  write_path(1, 4);
end.