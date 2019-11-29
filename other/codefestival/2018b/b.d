import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias AB = Tuple!(int, int);

void main()
{
    auto nx = readln.split.to!(int[]);
    auto N = nx[0];
    auto X = nx[1];

    AB[] abs;
    abs.length = N;
    foreach (i; 0..N) {
        auto ab = readln.split.to!(int[]);
        abs[i] = AB(ab[0], ab[1]);
    }
    sort!"a[1] > b[1]"(abs);
    abs[0][0] += X;
    int s;
    foreach (ab; abs) {
        s += ab[0] * ab[1];
    }
    writeln(s);
}
