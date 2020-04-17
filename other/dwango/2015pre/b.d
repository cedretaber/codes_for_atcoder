import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    auto N = S.length;

    long[] nc;
    long r;
    size_t i;
    while (i < N) {
        while (i+1 < N && S[i] == '2' && S[i+1] == '5') {
            r += 1;
            i += 2;
        }
        if (r > 0) {
            nc ~= r;
            r = 0;
        } else {
            ++i;
        }
    }
    r = 0;
    foreach (n; nc) r += n * (n+1) / 2;
    writeln(r);
}