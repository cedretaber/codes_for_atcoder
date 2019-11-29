import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!long;

    long r;
    foreach (x; 1..N) {
        if (x^^2 > N) break;
        if (N%x == 0) {
            auto m = N/x - 1;
            if (x*m + x == N && N/m == N%m) r += m;
        }
    }
    writeln(r);
}