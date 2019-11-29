import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto kab = readln.split.to!(long[]);
    auto K =kab[0];
    auto A = kab[1];
    auto B = kab[2];

    if (A+2 > B) {
        writeln(K+1);
        return;
    } else if (K == 1) {
        writeln(2);
        return;
    } else {
        auto K2 = K - A + 1;
        if (K2 < 2) {
            writeln(K + 1);
            return;
        }
        auto b = B;
        K2 -= 2;
        b += (K2 / 2) * (B - A);
        b += (K2 % 2);
        writeln(b);
    }
}