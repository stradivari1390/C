{ adjacency matrix }
{ представление графа в виде матрицы смежности }
{ граф простой, не взвешанный }

const
  maxn = 250;                           { макс. кол-во врешин }

var
  { матрица смежности }
  { a[i, j] = true => существует ребро i -> j }
  a: array [1..maxn, 1..maxn] of boolean;
  { кол-во ребер }
  n: longint;

{init: инициализация и ввод данных }
procedure init;
var
  i, x, y, nn: longint;
begin
  fillchar(a, sizeof(a), false);
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

{print: печать матрицы смежности }
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

begin
  init;
  print;
end.