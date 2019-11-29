import std.stdio, std.algorithm, std.conv, std.array, std.string, std.typecons;

void main()
{
    auto nLR = readln.split.to!(int[]);
    auto L = nLR[1];
    auto R = nLR[2];
    writeln(
        readln.split.map!((i) {
            auto a = i.to!int;
            return (a < L ? L : a > R ? R : a).to!string;
        }).array.join(" ")
    );
}