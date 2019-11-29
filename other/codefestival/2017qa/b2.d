import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nmk = readln.split.to!(int[]);
    auto N = nmk[0];
    auto M = nmk[1];
    auto K = nmk[2];

    foreach (y; 0..N+1) {
        auto b = 2*y - N;
        if (b == 0) {
            if (N*M == 2*K) {
                writeln("Yes");
                return;
            }
        } else {
            auto s = K + M*y - M*N;
            if (s % b != 0) continue;
            auto x = s / b;
            if (0 <= x && x <= M) {
                writeln("Yes");
                return;
            }
        }
    }
    writeln("No");
    return;
}