import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.range;

enum PS = [11, 31, 41, 61, 71, 101, 131, 151, 181, 191, 211, 241, 251, 271, 281, 311, 331, 401, 421, 431, 461, 491, 521, 541, 571, 601, 631, 641, 661, 691, 701, 751, 761, 811, 821, 881, 911, 941, 971,991, 1021, 1031, 1051, 1061, 1091, 1151, 1171, 1181, 1201, 1231, 1291, 1301, 1321, 1361, 1381].to!(string[]);

void main()
{
    writeln(PS[0..readln.chomp.to!int].join(" "));
}