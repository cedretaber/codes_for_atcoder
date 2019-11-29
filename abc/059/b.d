import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto a = readln.chomp;
    auto b = readln.chomp;

    writeln(
        a.length > b.length ? "GREATER" :
        a.length < b.length ? "LESS" :
        a > b ? "GREATER" :
        a < b ? "LESS" :
        "EQUAL"
    );
}