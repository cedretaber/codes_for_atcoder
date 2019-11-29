import std.stdio, std.string, std.conv, std.array, std.algorithm;

void main()
{
    auto abc = readln.chomp.split(" ").map!(to!int);

    writeln(
        abc.count!"a==5" == 2 && abc.count!"a==7" == 1 ? "YES" : "NO"
    );
}
