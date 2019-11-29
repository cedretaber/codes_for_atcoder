import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nmk = readln.split.to!(int[]);
    auto N = nmk[0];
    auto M = nmk[1];
    auto K = nmk[2];

    auto as = readln.split.to!(int[]);
    auto bs = readln.split.to!(int[]);

    if (N > M) {
        writeln("Y");
        return;
    } else if (M > N) {
        writeln("X");
        return;
    }

    foreach (i; 0..N) {
        if (as[i] > bs[i]) {
            writeln("Y");
            return;
        } else if (bs[i] > as[i]) {
            writeln("X");
            return;
        }
    }
    
    writeln("Same");
}