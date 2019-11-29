import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto M = readln.split[1].to!long;

    long[long] HS = [0: 0];
    long c;
    foreach (a; readln.split.to!(long[])) {
        c = (c + a) % M;
        if (c in HS) {
            ++HS[c];
        } else {
            HS[c] = 0;
        }
    }

    long r;
    foreach (_, n; HS) {
        r += n * (n + 1) / 2;
    }
    writeln(r);
}