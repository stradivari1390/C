{ minimal spanning tree (Prim's algorithm) }
{ Sedjvik variant }

const
  maxn = 25;
  inf  = $ff;

var
  a: array [1..maxn, 1..maxn] of byte;
{  v: array [1..maxn] of boolean;
  d: array [1..maxn] of longint;
  s: array [1..maxn] of integer;}
  wt, fr, st: array [1..maxn] of longint;

  n: longint;

procedure init;
var
  i, j, x, y, nn, z: longint;
begin
{  fillchar(v, sizeof(v), false);
  fillchar(d, sizeof(d), 0);
  fillchar(s, sizeof(s), 0);}
  fillchar(fr, sizeof(fr), 0);
  fillchar(wt, sizeof(wt), 0);
  fillchar(st, sizeof(st), 0);

  assign(input, 'mst.in');
  reset(input);

  read(n);

  for i := 1 to n do
    for j := 1 to n do
      a[i, j] := inf;


  read(nn);

  for i := 1 to nn do
  begin
    read(x, y, z);
    a[x, y] := z;
    a[y, x] := z;                       { если неориентированный граф }
  end;
end;

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
      write(a[i, j]:3);
    writeln;
  end;
end;
(*
static int fr[maxV];
#define P G->adj[v][w]
void GRAPHmstV(Graph G, int st[], double wt[])
  { int v, w, min;
    for (v = 0; v < G->V; v++)
      { st[v] = -1; fr[v] = v; wt[v] = maxWT; }
    st[0] = 0; wt[G->V] = maxWT;
    for (min = 0; min != G->V; )
      {
        v = min; st[min] = fr[min];
        for (w = 0, min = G->V; w < G->V; w++)
          if (st[w] == -1)
            {
              if (P < wt[w])
                { wt[w] = P; fr[w] = v; }
              if (wt[w] < wt[min]) min = w;
            }
      }
  }
}
*)

procedure prim;
var
  v, w, min: longint;
begin
  for v := 1 to n do
  begin
    st[v] := -1;
    fr[v] := v;
    wt[v] := inf;
  end;

  st[1] := 1;
  wt[n] := inf;

  min := 1;

  while min <> n do
  begin
    v := min;
    st[min] := fr[min];

    for w := 1 to n do
      if st[w] = -1 then
      begin
        if (a[v, w] < wt[w]) then
        begin
          wt[w] := a[v, w];
          fr[w] := v;
        end;
        if wt[w] < wt[min] then
          min := w;
      end;
  end;
end;


begin
  init;

  writeln('minimal spanning tree (Prim''s algorithm)');

  prim;
  print;
end.