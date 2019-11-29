import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(long[]);

    foreach (k; 1..N+1) {
        int i, j;
        long s;
        for (; i < k; ++i) s += as[i];
        auto max_s = s;
        for (; i < N; ++i, ++j) {
            s = s - as[j] + as[i];
            max_s = max(max_s, s); 
        }
        writeln(max_s);
    }
}