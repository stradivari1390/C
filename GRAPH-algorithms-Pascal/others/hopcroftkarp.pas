program HopcroftKarp; {$APPTYPE CONSOLE} {$R+}
uses
    Windows; { For GetTickCount() }
const
    MaxN = 5000;
    maxm = 10000;

type
    TGraph = record
        nV, nL, nR, nE: LongInt;
        E: array [0..maxm] of record
            AdjCount: Integer;
            Adj: array of Integer;
        end;
    end;

    TMatching = array of Integer;

{ Procedure allocates graph }
procedure NewGraph(var G: TGraph; L, R: Integer);
var
    i: Integer;
    N: Integer;
begin
    N := L+R;

    G.nV := N;
    G.nL := L;
    G.nR := R;
    G.nE := 0;

//    SetLength(G.E, N);
    for i := 0 to N-1 do
    begin
        G.E[i].AdjCount := 0;
        SetLength(G.E[i].Adj, N);
    end;
end;

{ Procedure frees graph }
procedure FreeGraph(var G: TGraph);
var
    i: Integer;
begin
    for i := 0 to G.nV-1 do
        SetLength(G.E[i].Adj, 0);
//    SetLength(G.E, 0);

    G.nV := 0;
    G.nE := 0;
end;

{ Procedure to add edge to graph }
procedure AddEdge(var G: TGraph; u, v: Integer);
begin
    Inc(G.E[u].AdjCount);
    G.E[u].Adj[  G.E[u].AdjCount  ] := v;
end;

{ Main procedure. Implementation of Hopcroft-Karp algorithm }
var
    Total: Integer;
procedure MaxMatching(const G: TGraph; var Match: TMatching);
var
    Front: array of Integer;

    { DFS with augumentation. Returns TRUE if found free vertex in Y }
    function DFS(v: Integer): Boolean;
    var
        i, u, t: Integer;
    begin
        DFS := False;
        Front[v] := -1;
        for i := 1 to G.E[v].AdjCount do
        begin
            u := G.E[v].Adj[i];
            if Front[u] <= 0 then
                Continue;
            Front[u] := -1;

            t := Match[u];
            if t = -1 then
            begin { Found path tail! }
                DFS := True;
                Match[v] := u;
                Match[u] := v;
                Exit;
            end else
            begin
                if DFS(t) then
                begin { Found path! }
                    DFS := True;
                    Match[v] := u;
                    Match[u] := v;
                    Exit;
                end;
            end;
        end;
    end;

var
    Cur, Prev: Integer;
    Q: array[0..1] of array of Integer;
    h: array[0..1] of Integer;

    YFree: Integer;

    u, v, t: Integer;
    i, j: Integer;
begin
    { Initializate empty match }
    Total := 0;
    SetLength(Match, G.nV);
    for i := 0 to G.nV-1 do
        Match[i] := -1;

    SetLength(Front, G.nV);
    SetLength(Q[0], G.nV);
    SetLength(Q[1], G.nV);

    { Main algo }
    while TRUE do
    begin
        { Create G(M) - BFS }
        { 0. Emptify labels }
        YFree := 0;
        for i := 0 to G.nV-1 do
            Front[i] := 0;

        { 1. Include all X-Free vertices }
        Cur := 0;
        h[Cur] := -1;
        for i := 0 to G.nL-1 do
            if Match[i] = -1 then
            begin
                Front[i] := 1;
                Inc(h[Cur]);
                Q[Cur, h[Cur]] := i;
            end;

        { 2. BFS itself }
        repeat
            Prev := Cur;
            Cur := Cur XOR 1;
            h[Cur] := -1;

            for i := 0 to h[Prev] do
            begin
                v := Q[Prev, i];
                for j := 1 to G.E[v].AdjCount do
                begin
                    u := G.E[v].Adj[j];
                    if u = Match[v] then
                        Continue; { We do not consider edges in matching }

                    if Front[u] = 0 then
                    begin
                        Front[u] := Front[v]+1;
                        t := Match[u];
                        if t = -1 then
                        begin
                            Inc(YFree);
                        end else
                        begin
                            Front[t] := Front[u]+1;
                            Inc(h[Cur]);
                            Q[Cur, h[Cur]] := t;
                        end;
                    end;
                end;
            end;
        until (h[Cur] = -1) or (YFree > 0);

        if YFree = 0 then
            Break; { Max matching! }

        { Find vertex disjoint augumenting pathes - DFS }
        for i := 0 to G.nL-1 do
        begin
            if Match[i] <> -1 then
                Continue; { i not in XFree set }

            if DFS(i) then
            begin
                Inc(Total);
                Dec(YFree);
            end;
            if YFree = 0 then
                Break; { All augumentations done }
        end;
    end;

    { Free memory }
    SetLength(Front, 0);
    SetLength(Q[0], 0);
    SetLength(Q[1], 0);
end;

{ Global data }
var
    FIn, FOut: Text;

    L, R, M: LongInt;
    G: TGraph;
    MaxMatch: TMatching;

    i: Integer;
    u, v: Integer;
    t0, t1: DWORD;
    Choice: String;
begin
    { Read data }
    WriteLn('--- Reading input file ---');
    Assign(FIn, 'HopcroftKarp.in');
    Reset(FIn);
        ReadLn(FIn, L, R, M);
        NewGraph(G, L, R);

        for i := 1 to M do
        begin
            ReadLn(FIn, u, v);

            AddEdge(G, u, v);
            AddEdge(G, v, u);
        end;
    Close(FIn);
    WriteLn('--- Done reading ---');

    { Run main algo }
    WriteLn;
    WriteLn('--- Algorithm launced ---');
    t0 := GetTickCount;
        MaxMatching(G, MaxMatch);
    t1 := GetTickCount;
    WriteLn('--- Algorithm finished ---');

    { Save matching to file }
    Assign(FOut, 'HopcroftKarp.out');
    Rewrite(FOut);
        WriteLn(FOut, Total);
        for i := 0 to G.nL-1 do
            if MaxMatch[i] <> -1 then
                WriteLn(FOut, i+1, ' ', MaxMatch[i]+1);
    Close(FOut);

    { Print statistics data }
    WriteLn;
    WriteLn('Total execution time (ms): ', t1-t0);
    WriteLn('Cardinality of maximum matching is ', Total);
    Write('Type "print" to print max match...');
    ReadLn(Choice);
    if Choice = 'print' then
    begin
        for i := 0 to G.nL-1 do
            if MaxMatch[i] <> -1 then
                Write('(',i+1, ' , ', MaxMatch[i]+1, ')  ');
        WriteLn;
    end;

    { Free memory }
    FreeGraph(G);
    SetLength(MaxMatch, 0);

    { Exit banner }
    WriteLn;
    WriteLn('Press ENTER to exit...');
    ReadLn;
end.
