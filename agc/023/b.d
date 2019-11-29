import std.stdio, std.algorithm, std.conv, std.array, std.string;

wchar[600][600] BD1, BD2;

void main()
{
    auto N = readln.chomp.to!int;

    foreach (i; 0..N) {
        foreach (j, c; readln.chomp) {
            BD1[i][j] = BD1[i][N+j] = BD1[N+i][j] = BD1[N+i][N+j] = c;
            BD2[j][i] = BD2[j][N+i] = BD2[N+j][i] = BD2[N+j][N+i] = c;
        }
    }

    int cnt;
    foreach (a; 0..N) {
        foreach (i; 0..N) {
            if (BD1[a+i][0..N] != BD2[i][a..N+a]) goto bad;
        }
        ++cnt;
        bad:
    }
    writeln(cnt * N);
}