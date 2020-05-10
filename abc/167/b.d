import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abck = readln.split.to!(long[]);
    auto A = abck[0];
    auto B = abck[1];
    auto C = abck[2];
    auto K = abck[3];

    long r;
    if (K > 0) {
        r += min(K, A);
        K -= min(K, A);
    }
    if (K > 0) {
        K -= min(K, B);
    }
    if (K > 0) {
        r -= min(K, C);
    }
    writeln(r);
}