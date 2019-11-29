import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abk = readln.split.to!(int[]);
    auto A = abk[0];
    auto B = abk[1];
    auto K = abk[2];

    foreach_reverse (k; 1..101) {
        if (A % k == 0 && B % k == 0 && --K == 0) {
            writeln(k);
            return;
        }
    }
}