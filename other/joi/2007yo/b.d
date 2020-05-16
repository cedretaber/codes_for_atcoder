import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    int[30] ss;
    foreach (_; 0..28) ss[readln.chomp.to!int-1] = true;
    foreach (i, s; ss) if (!s) writeln(i+1);
}