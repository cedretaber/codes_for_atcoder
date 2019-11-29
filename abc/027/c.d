import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!long;

    int k;
    auto n = N;
    for (; n; ++k, n /= 2) {}

    long m = 1;
    auto x = 0;
    for (;;) {
        if (x%2==0) {
            m = (k%2==0) ? 2*m : 2*m+1; 
        } else {
            m = (k%2==0) ? 2*m+1 : 2*m;
        }
        if (m > N) break;
        ++x;
    }
    writeln(x%2==0 ? "Aoki" : "Takahashi");
}