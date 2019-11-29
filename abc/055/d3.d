import std.stdio, std.string, std.array, std.conv, std.algorithm;

void main()
{
    auto n = readln.chomp.to!size_t;
    auto ss = readln.split;
    foreach (i, s; ss) SS[i] = s;
    
    auto ret = solve(n, ['S', 'S']);
    if (!ret) ret = solve(n, ['S', 'W']);
    if (!ret) ret = solve(n, ['W', 'S']);
    if (!ret) ret = solve(n, ['W', 'W']);

    writeln(ret);
}