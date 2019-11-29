import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[10^^5] XS, LS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    foreach (i, x; readln.split.to!(int[])) {
        XS[i] = x;
    }

    if (N >= M) {
        writeln("0");
        return;
    }
    
    sort(XS[0..M]);
    foreach (i; 0..M-1) {
        LS[i] = abs(XS[i] - XS[i+1]);
    }
    sort!"a > b"(LS[0..M-1]);

    writeln(reduce!"a + b"(0, LS[N-1..$]));
}