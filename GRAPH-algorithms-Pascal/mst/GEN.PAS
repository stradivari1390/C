const
  n = 200;
  p = 50;

var
  a: array [1..n, 1..n] of byte;
  edges_num, v: longint;

procedure init;
begin
  randomize;
  fillchar(a, sizeof(a), 0);

  assign(output, 'ranw.in');
  rewrite(output);
end;

procedure add_random_edges(percent: real);
var
  i, j, nn: longint;
begin
  nn := round((n*(n-1) div 2) * (percent / 100));
  edges_num := nn;

  while nn > 0 do
  begin
    while true do
    begin
      i := random(n)+1;
      j := random(n)+1;

      if (a[i, j] = 0) and (i <> j) then
        break;
    end;

    a[i, j] := random(255)+1;
    a[j, i] := a[i, j];
    dec(nn);
  end;
end;

procedure run;
begin
  add_random_edges(p);
end;

procedure done;
var
  i, j: integer;
begin
  writeln(n, ' ', edges_num);

  for i := 1 to n do
    for j := 1 to n do
      if a[i, j] > 0 then
      begin
        writeln(i, ' ', j, ' ', a[i, j]);
        a[j, i] := 0;                           { not to double edges }
      end;

  close(output);
end;

begin
  init;
  run;
  done;
end.