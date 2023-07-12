{ minimal spanning tree (Kruskal's algorithm) }

const
  maxn = 100;                         {}
  maxm = 10000;                       {}
  inf  = maxint div 2;                {}

type
  edge = record
    x, y: integer;                    { ���設� ॡ� }
    w: integer;                       { ��� ॡ� }
  end;

var
  a: array [1..maxm] of edge;         { ᯨ᮪ ॡ�� }
  s: array [1..maxn] of integer;      { ࠧ��� ��������� �吝��� }
  r: array [1..maxn] of integer;      { �裡 ���設 � ���������� �吝��� }
  n, m: longint;                      { ���-�� ���設 � ॡ�� }
  mst_weight: longint;                { ��� MST}

{ ���樠������ � �⥭�� ������ }
procedure init;
var
  i, j, x, y, nn, z: longint;
begin
  mst_weight := 0;
  assign(input, 'mst.in');
{  assign(input, 'randw.in');}
  reset(input);

  read(n);
  read(m);

  for i := 1 to m do
  begin
    read(x, y, z);
    a[i].x := x;
    a[i].y := y;
    a[i].w := z;
  end;
end;

{ ����� ���� ॡ�� (��� ���஢��) }
procedure swap(var e1, e2: edge);
var
  e: edge;
begin
  e := e1; e1 := e2; e2 := e;
end;

{ ࠭������஢����� ������ ���஢�� }
procedure qsort(l, r: integer);
var
  i, j, x: integer;
begin
  i := l;                               { i - ����� �࠭�� }
  j := r;                               { j - �ࠢ�� �࠭�� }
  x := a[l+random(r-l+1)].w;            { x - ��砩�� ����� �� ���ࢠ�� }

  repeat
    while x > a[i].w do inc(i);         { �饬 ����� ����訩 ����� }
    while x < a[j].w do dec(j);         { �饬 ����� ����訩 ����� }

    if i <= j then                      { 㪠��⥫� �� ���ᥪ����� }
    begin
      swap(a[i], a[j]);                 { ���塞 ������ }
      inc(i);                           { �த������ ���� 㪠��⥫� }
      dec(j);                           { �த������ �ࠢ� 㪠��⥫� }
    end;
  until i > j;                          { �� ����祭�� 㪠��⥫�� }

  if l < j then qsort(l, j);            { ����㥬 ���� ������ᨢ }
  if i < r then qsort(i, r);            { ����㥬 �ࠢ� ������ᨢ }
end;

{ ����஥��� mst (������ ���᪠��) }
procedure kruskal;
var
  k, i, p, q: integer;
begin
  qsort(1, m);                        { ����㥬 ᯨ᮪ ॡ�� �� ���뢠��� }

  for i := 1 to n do                  { 横� �� ���設�� }
  begin
    r[i] := i;                        { � ���設� ᢮� ��������� �吝��� }
    s[i] := 1;                        { ࠧ��� ���������� �吝��� }
  end;

  k := 0;                             { ����� ��ࢮ�� ॡ� + 1 }

  for i := 1 to n - 1 do              { 横� �� ॡࠬ mst }
  begin
    repeat                            { �饬 ॡ� �� ࠧ��� }
      inc(k);                         { ��������� �吝���  }
      p := a[k].x;
      q := a[k].y;
      while r[p] <> p do              { �饬 ��७� ��� p }
        p := r[p];
      while r[q] <> q do              { �饬 ��७� ��� q }
        q := r[q];
    until p <> q;

    writeln(a[k].x, ' ', a[k].y);     { �뢮� ॡ� }
    inc(mst_weight, a[k].w);

    if s[p] < s[q] then               { ����襭��� ��ꥤ������ }
    begin                             { ���������� �吝���   }
      r[p] := q;
      s[q] := s[q] + s[p];
    end
    else
    begin
      r[q] := p;
      s[p] := s[p] + s[q];
    end;
  end;
end;


begin
  init;
  writeln('minimal spanning tree (Kruskal''s algorithm)');
  kruskal;
  writeln('mst weight = ', mst_weight);
end.