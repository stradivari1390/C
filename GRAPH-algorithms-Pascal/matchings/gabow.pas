{ Сборник алгоритмов по графам (с) Борис Вольфсон }
{ Поиск максимального паросочетания в произвольном графе }
{ Алгоритм Габова }
{ Автор программы Гребнов Илья }

const
  maxn = 100;

var
  edges: array [0..maxn, 0..maxn] of integer;
  endpoints : array[0..maxn+2*maxn*maxn+1] of byte;
  mate : array[0..maxn] of byte;
  vlabel, first : array[0..maxn] of longint;
  queue : array[0..maxn] of byte;
  v, queueup, queuedown : longint;

procedure init;
var
  i, j : byte;
  t : array[1..maxn, 1..maxn] of byte;
  c : longint;
begin
  assign(input, 'mmgg.in');
  reset(input);

  readln(v);
  for i := 1 to v do edges[i, 0] := 0;
  fillchar(t, sizeof(t), 0);
  while not eof(input) do
    begin
      readln(i, j);
      if (i <> j) then
        begin
          t[i, j] := 1;
          t[j, i] := 1;
        end;
    end;
  c := v+2;
  for i := 1 to v-1 do
    for j := i+1 to v do
      if t[i][j] = 1 then
        begin
          inc(edges[i, 0]);
          edges[i, edges[i, 0]] := c;
          inc(edges[j, 0]);
          edges[j, edges[j, 0]] := c;
          endpoints[c-1] := i;
          endpoints[c] := j;
          inc(c, 2);
        end;
  fillchar(mate, sizeof(mate), 0);
  fillchar(first, sizeof(first), 0);

  close(input);
end;

procedure greedy;
var
  i, j, x : longint;
begin
  for i := 1 to v do
    if mate[i] = 0 then
      for j := 1 to edges[i, 0] do
        begin
          if endpoints[edges[i, j]] <> i then
            x := endpoints[edges[i, j]]
          else
            x := endpoints[edges[i, j]-1];
          if mate[x] = 0 then
            begin
              mate[x] := i;
              mate[i] := x;
              break;
            end;
        end;
end;

procedure rematch(a, b : LongInt);
var
  x, y, T : longint;
begin
  t := mate[A];
  mate[a] := B;
  if (Mate[t] <> a) then exit;
  if (vlabel[a] <= v) then
    begin
      mate[t] := vlabel[a];
      rematch(vlabel[a], t);
    end
  else
    begin
      x := endpoints[vlabel[a]-1];
      y := endpoints[vlabel[a]];
      rematch(x, y);
      rematch(y, x);
    end;
end;

function findedge(x, y : longint) : longint;
var
  i : longint;
begin
  for i := 1 to edges[x, 0] do
    if (endpoints[edges[x, i]] = Y) or (endpoints[Edges[x, i]-1] = y) then
      begin
        findedge := edges[x, i];
        exit;
      end;
  findedge := 0;
end;

procedure labelsub(x, edge, join : longint);
begin
  while (x <> join) do
    begin
      vlabel[x] := edge;
      first[x] := join;
      queue[queueup] := x; inc(queueup);
      x := first[vlabel[mate[x]]];
    end;
end;

procedure dolabel(x, y : longint);
var
  r, s, edge, flag, join : longint;
begin
  edge := findedge(x, y);
  flag := -edge;
  r := first[x];
  s := first[y];
  if r = s then exit;
  vlabel[r] := flag;
  vlabel[s] := flag;
  if (s <> 0) then begin join := s; s := r; r := join; end;
  r := first[vlabel[mate[r]]];
  while (vlabel[r] <> flag) do
    begin
      vlabel[r] := flag;
      if (s <> 0) then begin join := s; s := r; r := join; end;
      r := first[vlabel[mate[r]]];
    end;

  join := r;

  labelsub(first[x], edge, join);
  labelsub(first[y], edge, join);

  for s := 0 to queueup-1 do
    if (vlabel[first[queue[s]]] > 0) then
      first[queue[s]] := join;
end;

procedure solve;
var
  i, j, x, y : longint;
begin
  greedy;
  for i := 1 to v do
    if mate[i] = 0 then
      begin
        queueup := 0;
        queuedown := 0;
        fillchar(vlabel, sizeof(vlabel), $ff);
        queue[queueup] := i; inc(queueup);
        vlabel[i] := 0;
        while (queuedown <> queueup) do
          begin
            x := queue[queuedown]; inc(queuedown);
            for j := 1 to edges[x, 0] do
              begin
                if endpoints[edges[x, j]] <> x then
                  y := endpoints[edges[x, j]]
                else
                  y := endpoints[edges[x, j]-1];
                if (mate[y] = 0) and (y <> i) then
                  begin
                    mate[y] := x;
                    rematch(x, y);
                    queuedown := queueup;
                    break;
                  end;
                if vlabel[y] >= 0 then dolabel(x, y)
                else
                  if (vlabel[mate[y]] < 0) then
                    begin
                      vlabel[mate[y]] := x;
                      first[mate[y]] := y;
                      queue[queueup] := mate[y]; inc(queueup);
                    end;
              end;
          end;
      end;
end;

procedure done;
var
  i, count: longint;
begin
  count := 0;
  for i := 1 to v do
    if mate[i] > i then inc(count);
  writeln(count*2);
  for i := 1 to v do
    if mate[i] > i then writeln(i, ' ', mate[i]);
end;

begin
  init;
  solve;
  done;
end.
