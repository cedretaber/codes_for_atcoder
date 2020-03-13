import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto A = new long[][](N, N);
    foreach (i; 0..N) {
        foreach (j, a; readln.split.to!(long[])) {
            A[i][j] = a;
        }
    }

    foreach (k; 0..N) {
        foreach (i; 0..N) {
            foreach (j; 0..N) {
                if (A[i][j] > A[i][k] + A[k][j]) {
                    writeln("-1");
                    return;
                }
            }
        }
    }

    long r;
    foreach (i; 0..N) {
        foreach (j; 0..N) {
            foreach (k; 0..N) {
                if (k != i && k != j && A[i][j] == A[i][k] + A[k][j]) goto ng;
            }
            r += A[i][j];
            ng:
        }
    }
    writeln(r/2);
}