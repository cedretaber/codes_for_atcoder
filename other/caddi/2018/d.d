import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = new int[](N);
    foreach (i; 0..N) as[i] = readln.chomp.to!int;
    sort!"a > b"(as);

    uint x;
    foreach (i; 1..N) if ((as[i-1] - as[i]) % 2) {
        x ^= i;
    }
    if (as[$-1] % 2) x ^= N;
    writeln(x ? "first" : "second");
}