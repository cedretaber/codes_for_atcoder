import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abk = readln.split.to!(long[]);
    auto A = abk[0];
    auto B = abk[1];
    auto K = abk[2];
    if (A >= K) {
        A -= K;
    } else {
        K -= A;
        A = 0;
        B = max(0, B - K);
    }
    writeln(A, " ", B);
}