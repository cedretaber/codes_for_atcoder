import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;

    int[] r;
    int n;
    foreach (int i; 1..5000) {
        n += i;
        r ~= i;
        if (n >= N) break;
    }
    if (n > N) {
        r[n-N-1] = 0;
    }
    foreach (x; r) if (x) {
        writeln(x);
    }
}