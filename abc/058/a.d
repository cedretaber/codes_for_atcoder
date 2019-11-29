import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto abc = readln.chomp.split(" ").map!(to!int);

    writeln(
        abc[1] - abc[0] == abc[2] - abc[1] ? "YES" : "NO"
    );
}