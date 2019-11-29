import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ss = readln.split.to!(long[]);

    long r;
    foreach (x; 1..N-1) {
        long rr;
        int i, j = N-1;
        while (i < N-1 && j > 0) {
            if (i == j || i == j+x || i > N-1-x || j < x) break;
            rr += ss[i] + ss[j];
            r = max(r, rr);
            i += x;
            j -= x;
        }
    }
    writeln(r);
}