import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto T = new int[][](N, N);
    
    int x = 1, s = 2;
    foreach (i; 1..N) {
        if (T[0][i] == 0) {
            while (i < N) {
                T[0][i] = x;
                i += s;
            }
            ++x;
            s *= 2;
        }
    }

    foreach (i; 1..N) {
        foreach (j; i+1..N) {
            T[i][j] = T[i-1][j-1];
        }
    }

    foreach (i; 0..N-1) {
        writeln(T[i][i+1..$].to!(string[]).join(" "));
    }
}