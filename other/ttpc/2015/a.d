import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    string s;
    switch (S[2]) {
        case 'B': s = "Bachelor"; break;
        case 'M': s = "Master"; break;
        case 'D': s = "Doctor"; break;
        default:
    }
    writefln("%s %s", s, S[0..2]);
}