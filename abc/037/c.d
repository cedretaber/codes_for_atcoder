import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto as = readln.split.to!(long[]);

    int i, j;
    long s, t;
    while (j != N) {
        if (j-i < K) {
            s += as[j++];
        } else {
            t += s;
            s = s - as[i++] + as[j++];
        }
    }
    writeln(s + t);
}