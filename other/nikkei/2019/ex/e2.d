import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    auto s = "##abcde";
    foreach (i; 1..N+1) {
        string o;
        foreach (j; 2..7) if (i >= j && i%j == 0) o ~= s[j];
        if (o.empty) o = i.to!string;
        writeln(o);
    }
}