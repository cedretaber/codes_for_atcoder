import std.stdio, std.algorithm, std.conv, std.array, std.string;

enum AEIOU = "aeiou";

void main()
{
    auto c = readln[0];
    writeln(AEIOU.canFind(c) ? "vowel" : "consonant");
}