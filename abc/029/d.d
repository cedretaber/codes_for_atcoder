import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!long;
    
    auto n = N;
    long r;
    foreach (k; 1..11) {
        auto i = 10L^^k;
        auto m = N/i;
        r += m * 10L^^(k-1);
        auto rest = N-m*i-10L^^(k-1)+1;
        if (rest > 0) r += min(rest, 10L^^(k-1));
    }
    writeln(r);
}