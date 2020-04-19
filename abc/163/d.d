import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto nk = readln.split.to!(long[]);
    auto N = nk[0];
    auto K = nk[1];
    auto cs = new long[](N+1);
    foreach (long i; 0..N+1) {
        cs[i] = i;
        if (i) cs[i] += cs[i-1];
    }
    long r;
    foreach (k; K..N+1) {
        auto d = (cs[N] - cs[N-k] - cs[k-1] + 1) % P;
        r += d %= P;
    }
    writeln((r+1)%P);
}