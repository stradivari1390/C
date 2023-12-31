{ adjacency lists }
{ �।�⠢����� ��� � ���� ᯨ᪮� ᬥ���� ���設 }

const
  maxn = 250;                           { ����. ���-�� ��設 }

type                                    { ⨯� ��� ࠡ��� � ᯨ᪮� }
  pnode = ^tnode;
  tnode = record
    v: word;
    next: pnode;
  end;

var
  a: array [1..maxn] of pnode;          { ᯨ᪨ ᬥ���� ���設 }
  n: longint;                           { ���-�� ॡ�� }

{insert_vertex: ��⠢��� � ��� ॡ� �� v � w }
procedure insert_vertex(v, w: word);
var
  p: pnode;
begin
  new(p);                               { ᮧ���� 㧥� }
  p^.v := w;

  p^.next := a[v];                      { ��⠢�塞 㧥� }
  a[v] := p;
end;

{init: ���樠������ � ���� ������ }
procedure init;
var
  i, x, y, nn: longint;
begin
  for i := 1 to maxn do
    a[i] := nil;

  assign(input, 'graph.in');
  reset(input);

  read(n);
  read(nn);

  for i := 1 to nn do
  begin
    read(x, y);
    insert_vertex(x, y);
    insert_vertex(y, x);                { �᫨ ���ਥ��஢���� ��� }
  end;
end;

{ print: ���⠥� ᯨ᪨ ᬥ���� ���設 }
procedure print;
var
  i: longint;
  p: pnode;
begin
  writeln;
  writeln('number of vertex : ', n);
  writeln('adjacency lists');

  for i := 1 to n do                    { ��ॡ�ࠥ� �� ���設� }
  begin
    write('[', i, '] ');

    p := a[i];                          { ��ॡ�ࠥ� �� ���設�, }
    while p <> nil do                   { ᬥ��� � i-�� ���設�� }
    begin
      write(p^.v, ' ');
      p := p^.next;                     { ��६ ᫥������ ���設� ᯨ᪠ }
    end;
    writeln;
  end;
end;

begin
  init;
  print;
end.
