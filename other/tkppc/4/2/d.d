import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto npq = readln.split.to!(long[]);
    auto N = npq[0];
    auto P = npq[1];
    auto Q = npq[2];
    auto as = readln.split.to!(long[]);

    if ((P+Q)%2 == 1) {
        writeln(0);
        return;
    }
    auto a1 = (P+Q)/2;
    auto a23 = P - a1;

    long[long] memo;
    auto cs = new long[](N);
    long c;
    foreach_reverse (i; 0..N) {
        cs[i] = c;
        auto a3 = a23 - as[i];
        if (a3 in memo) {
            c += memo[a3];
        }
        ++memo[as[i]];
    }
    c = 0;
    foreach (i; 0..N) if (as[i] == a1) c += cs[i];
    writeln(c);
}