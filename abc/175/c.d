import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto xkd = readln.split.to!(long[]);
    auto X = xkd[0];
    auto K = xkd[1];
    auto D = xkd[2];
    X = abs(X);
    if (X/D >= K) {
        writeln(X - K*D);
        return;
    }
    auto k = K - X/D;
    if (k%2 == 0) {
        writeln(X - D*(X/D));
    } else {
        writeln(abs(X - D*(X/D+1)));
    }
}