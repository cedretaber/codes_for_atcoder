import std.stdio, std.algorithm, std.conv, std.array, std.string, std.range;

void main()
{
    auto o = readln.chomp;
    auto e = readln.chomp;
    auto ret = o.zip(e).map!(t => [t[0], t[1]]).joiner.to!string;
    writeln(o.length > e.length ? ret ~ o[$-1] : ret);
}
