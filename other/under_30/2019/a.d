import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto as = new int[](N);
    foreach (i; 0..N) as[i] = readln.chomp.to!int;
    sort!"a > b"(as);
    int c;
    foreach (i; 0..K) c += as[i];
    foreach (i; K..N) c += as[i]*2;
    writeln(c);
}