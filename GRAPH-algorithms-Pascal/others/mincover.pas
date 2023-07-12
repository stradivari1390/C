{$APPTYPE CONSOLE}
CONST
  M_MAX = 400;

VAR
  L : LongInt;

  V, U : ARRAY[1..M_MAX] OF LongInt;
  W : ARRAY[1..M_MAX, 1..M_MAX] OF LongInt;

  MateA, MateB, Pred : ARRAY[1..M_MAX] OF LongInt;

  MarkA, MarkB : ARRAY[1..M_MAX] OF Boolean;

  PROCEDURE LAPInit;
  VAR
    I, J, K : LongInt;
  BEGIN
    FOR I := 1 TO L DO U[I] := 0;
    FOR I := 1 TO L DO
      BEGIN
        K := 0;
        FOR J := 1 TO L DO
          IF (K < W[I, J]) THEN K := W[I, J];
        V[I] := K;
      END;
  END;

  FUNCTION LAPMaxMatching : Boolean;
  VAR
    I, J, X, Y, A, B, C, QueueUp, QueueDown : LongInt;
    Queue : ARRAY[1..M_MAX] OF LongInt;
    Found, OK : Boolean;
  BEGIN
    OK := True;
    FOR I := 1 TO L DO
      IF MateA[I] = 0 THEN
        BEGIN
          FOR J := 1 TO L DO Pred[J] := 0;
          QueueDown := 1; QueueUp := 2; Queue[1] := I; Found := False;
          WHILE (QueueDown <> QueueUp) DO
            BEGIN
              X := Queue[QueueDown]; Inc(QueueDown);
              FOR Y := 1 TO L DO
                IF (W[X, Y] - V[X] - U[Y] = 0) THEN
                  BEGIN
                    IF (MateB[Y] = 0) THEN
                      BEGIN
                        A := X; B := Y;
                        WHILE (A <> 0) DO
                          BEGIN
                            C := MateA[A];
                            MateA[A] := B;
                            MateB[B] := A;
                            B := C; A := Pred[A];
                          END;
                        Found := True; Break;
                      END;
                    IF (Pred[MateB[Y]] = 0) THEN
                      BEGIN
                        Pred[MateB[Y]] := X;
                        Queue[QueueUp] := MateB[Y]; Inc(QueueUp);
                      END;
                  END;
              IF Found THEN Break;
            END;
          OK := OK AND Found;
        END;
    LAPMaxMatching := OK;
  END;

  PROCEDURE LAPMinSupport;
  VAR
    I, X, Y, QueueUp, QueueDown : LongInt;
    Queue : ARRAY[1..M_MAX] OF LongInt;
  BEGIN
    FOR I := 1 TO L DO MarkA[I] := False;
    FOR I := 1 TO L DO MarkB[I] := False;
    FOR I := 1 TO L DO
      IF (NOT MarkA[I]) AND (MateA[I] = 0) THEN
        BEGIN
          MarkA[I] := True;
          QueueDown := 1; QueueUp := 2; Queue[1] := I;
          WHILE (QueueDown <> QueueUp) DO
            BEGIN
              X := Queue[QueueDown]; Inc(QueueDown);
              FOR Y := 1 TO L DO
                IF (W[X, Y] - V[X] - U[Y] = 0) AND (NOT MarkB[Y]) THEN
                  BEGIN
                    MarkB[Y] := True;
                    IF (NOT MarkA[MateB[Y]]) THEN
                      BEGIN
                        MarkA[MateB[Y]] := True;
                        Queue[QueueUp] := MateB[Y]; Inc(QueueUp);
                      END;
                  END;
            END;
        END;
  END;

  PROCEDURE LAPRotateZeroes;
  VAR
    I, J, E : LongInt;
  BEGIN
    E := MaxLongInt;
    FOR I := 1 TO L DO
      IF (MarkA[I]) THEN
        FOR J := 1 TO L DO
          IF (NOT MarkB[J]) THEN
            IF (E > V[I] + U[J] - W[I, J]) THEN E := V[I] + U[J] - W[I, J];
    FOR I := 1 TO L DO
      IF (MarkA[I]) THEN V[I] := V[I] - E;
    FOR J := 1 TO L DO
      IF (MarkB[J]) THEN U[J] := U[J] + E;
  END;

  PROCEDURE LAP;
  BEGIN
    LAPInit;
    WHILE True DO
      BEGIN
        IF LAPMaxMatching THEN Break;
        LAPMinSupport;
        LAPRotateZeroes;
      END;
  END;

BEGIN

  LAP;

END.
