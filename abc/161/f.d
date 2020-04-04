import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;
 
void main()
{
    auto N = readln.chomp.to!long;
    if (N == 2) {
        writeln(1);
        return;
    }
    int res;
    long d;
    for (d = 2; d^^2 < N; ++d) {
        if (N % d == 1) {
            auto dd = (N-1)/d;
            res += d == dd ? 1 : 2;
        }
        if (N % d == 0) {
            auto n = N;
            while (n%d == 0) n /= d;
            if (n % d == 1) {
                ++res;
            }
            auto dd = N / d;
            n = N;
            while (n % dd == 0) n /= dd;
            if (n % dd == 1) {
                ++res;
            }
        }
    }
    if (d^^2 == N) {
        ++res;
    }
    writeln(res+2);
}