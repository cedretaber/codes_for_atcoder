import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    char[][] AB, AC;
    AB.length = N;
    AC.length = N;
    foreach (i; 0..N) AB[i] = readln.chomp.to!(char[]);
    foreach (i; 0..N) AC[i] = readln.chomp.to!(char[]);

    ulong[5][] BX;
    BX.length = N;
    foreach (i; 0..N) {
        foreach (j; 0..N) {
            if (AB[i][j] == '1') {
                BX[j][i/60] |= 1L<<(i%60);
            }
        }
    }

    ulong[5][] CX;
    CX.length = N;
    foreach (i; 0..N) {
        foreach (j; 0..N) {
            if (AC[i][j] == '1') {
                CX[j][i/60] |= 1L<<(i%60);
            }
        }
    }

    auto BC = new char[][](N, N);
    foreach (i; 0..N) {
        ulong[5] xs;
        foreach (j; 0..N) {
            foreach (k; 0..5) if ((BX[j][k] | CX[i][k]) != CX[i][k]) goto ng;
            BC[j][i] = '1';
            foreach (k; 0..5) xs[k] |= BX[j][k];
            continue;
            ng:
            BC[j][i] = '0';
        }
        if (xs != CX[i]) {
            writeln(-1);
            return;
        }
    }
    writeln(BC.join('\n'));
}