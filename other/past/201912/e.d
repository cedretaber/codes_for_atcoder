import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];

    auto FS = new char[][](N, N);
    foreach (ref fs; FS) fs[] = 'N';

    foreach (_; 0..Q) {
        auto q = readln.split.to!(int[]);
        auto a = q[1]-1;
        switch (q[0]) {
            case 1:
                auto b = q[2]-1;
                FS[a][b] = 'Y';
                break;
            case 2:
                foreach (i; 0..N) if (FS[i][a] == 'Y') FS[a][i] = 'Y';
                break;
            case 3:
                int[] fs;
                foreach (i; 0..N) if (FS[a][i] == 'Y') fs ~= i;
                foreach (i; fs) {
                    foreach (j; 0..N) if (j != a && FS[i][j] == 'Y') {
                        FS[a][j] = 'Y';
                    }
                }
                break;
            default:
        }
    }
    foreach (ref fs; FS) writeln(fs);
}