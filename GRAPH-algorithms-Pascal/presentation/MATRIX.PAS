{ adjacency matrix }
{ �।�⠢����� ��� � ���� ������ ᬥ����� }
{ ��� ���⮩, �� ����蠭�� }

const
  maxn = 250;                           { ����. ���-�� ��設 }

var
  { ����� ᬥ����� }
  { a[i, j] = true => ������� ॡ� i -> j }
  a: array [1..maxn, 1..maxn] of boolean;
  { ���-�� ॡ�� }
  n: longint;

{init: ���樠������ � ���� ������ }
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
    a[y, x] := true;                    { �᫨ ���ਥ��஢���� ��� }
  end;
end;

{print: ����� ������ ᬥ����� }
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