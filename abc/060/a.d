import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto str = readln.split(" ");

    writeln(
        str[0][$-1] == str[1][0] && str[1][$-1] == str[2][0] ? "YES" : "NO"
    );
}