{ TODO: не работает }

{ алгоритм Беллмена-Форда}

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
{  assign(input, 'dijkstra.in');}
  assign(input, 'negcycle.in');
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

{
 Function (!) to find shortest pathes from one vertex to all other,
 without asumpation, that all edge weights are nonnegative. This
 function implements Bellman-Ford algo. The return value is FALSE when
 there exists cycle with negative weight. TRUE otherwise.
 Time complexity is O(V*E) ~ O(V^3) for full graph.
}

function bellman_ford(s: integer): boolean;
var
  i, j, k: integer;
begin
  for i := 1 to N do
  begin
    p[i] := -1;
    d[i] := maxlongint;
  end;

  p[s] := 0;
  d[s] := 0;

  for i := 1 to n do                  { цикл по всем вершинам кроме истока }
  begin
    for j := 1 to n do                  { для всех вершин }
      if (d[j] > d[i]+a[i, j]) then     { через m можно дойти до j быстрее }
      begin
        d[j] := d[i] + a[i, j];         { уменьшаем расстояние от истока }
        p[j] := i;                      { изменяем предка j }
      end;
  end;

  for i := 1 to n do
  begin
    for j := 1 to n do
    begin
      if (a[i, j] <> oo) and
        (d[i] > d[j] + a[j, i]) then
      begin
        bellman_ford := false;
        exit;
      end;
    end;
  end;

  bellman_ford := true;
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

  if not bellman_ford(1) then
    write('Найден отрицательный цикл')
  else
    write('Не найден отрицательный цикл');

  print;
  write('Кратчайший путь из 1-ой вершины в 4-ую вершину: ');
  write_path(1, 4);
end.

