import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto X = readln.chomp.to!int;

    auto ns = new bool[](100004);
    foreach (i; 2..100004) {
        if (ns[i]) continue;
        if (i >= X) {
            writeln(i);
            return;
        }
        auto j = i*2;
        while (j < 100004) {
            ns[j] = true;
            j += i;
        }
    }
}