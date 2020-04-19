import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    long[] as;
    foreach (_; 0..N) as ~= readln.chomp.to!long;
    sort(as);

    long s, c;
    foreach (a; as) if (s < a) {
        ++c;
        s += a;
    }
    writeln(c);
}