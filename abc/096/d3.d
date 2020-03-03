import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum PS = [3, 13, 23, 43, 53, 73, 83, 103, 113, 163, 173, 193, 223, 233, 263, 283, 293, 313, 353, 373, 383, 433, 443, 463, 503, 523, 563, 593, 613, 643, 653, 673, 683, 733, 743, 773, 823, 853, 863, 883, 953, 983, 1013, 1033, 1063, 1093, 1103, 1123, 1153, 1163, 1193, 1213, 1223, 1283, 1303];

void main()
{
    writeln(PS[0..readln.chomp.to!int].to!(string[]).join(" "));
}