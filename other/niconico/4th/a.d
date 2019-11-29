import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto s = readln.chomp.to!(dchar[]);
    writeln(s[0] == s[2] && s[1] == s[3] ? "Yes" : "No");
}