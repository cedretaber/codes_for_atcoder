import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto n = readln.chomp.to!int;
    auto ps = readln.split.to!(int[]);
    
    int cnt;

    if (ps[0] == 1) {
        swap(ps[0], ps[1]);
        cnt++;
    }
    foreach (i; 1..n) if (ps[i] == i+1) {
        swap(ps[i], ps[i+1]);
        cnt++;
    }
    if (ps[$-1] == n) {
        swap(ps[$-1], ps[$-2]);
        cnt++;
    }
    writeln(cnt);
}